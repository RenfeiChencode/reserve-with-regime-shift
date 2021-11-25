/***
 NAME
 fishingHabSwitch-qc
 DESCRIPTION
 EBT implementation of a simple model for cohort competition, in which
 individuals switch between foraging on resource 1 in habitat 1 to resource 2
 in habitat 2 on reaching size ws. In habitat 2, individulas experience fishing
 mortality besides background mortality.
 The model implements a quantitative genetics approach focussed on the
 evolution of the size at habitat switch. The average size at habitat switch
 among newborn offspring is related to selection differential and the
 heritability.

Individuals grow under the mortality caused by both fishing and natural background mortality.
It describes a situation in reality that  fishing activities continuously exist during fish individuals grow.
i.e. permanent open harvesting.
 
 Last modification: CCP - Jul 5, 2021
 ***/
#include  "escbox.h"

#define    CONS                      0


/*
 *==========================================================================
 *
 *        LABELLING ENVIRONMENT AND I-STATE VARIABLES
 *
 *==========================================================================
 */
#define time                      (env[0])
#define F1                        (env[1])
#define F2                        (env[2])

#define ADULTS                    (env[3])
#define ADULTWS                   (env[4])
#define ADULTFEC                  (env[5])
#define ADULTFECWS                (env[6])

#define    lnsurvival                (0)
#define    age                       (i_state( 0))
#define    size                      (i_state( 1))

#define IDnumber                  (i_const( 0))
#define IDsmoltsize               (i_const( 1))
#define    IDnbegin                    (i_const( 2))
#define    IDmatured                 (i_const( 3))
#define    IDsmolted                    (i_const( 4))
#define IDagematur                (i_const( 5))
#define IDagesmolt                (i_const( 6))
#define IDcohortID                (i_const( 7))

#define ismature(n)               (lrint(popIDcard[CONS][n][IDmatured]) > 0)
#define issmolted(n)              (lrint(popIDcard[CONS][n][IDsmolted]) > 0)
#define isdead(n)                 ((pop[CONS][n][lnsurvival] - 1.0) > LogMinSurvival)


/*
 *==========================================================================
 *
 *        DEFINING AND LABELLING CONSTANTS AND PARAMETERS
 *
 *==========================================================================
 */

#define RHO                       parameter[0]                                      // Productivity ratio resource 1 and 2
#define DELTA                     parameter[1]                                      // Scaled resource turn-over rate

#define ETA1                      parameter[2]                                      // Scaled background mortality rate small consumers
#define ETA2                      parameter[3]                                      // Scaled Background mortality rate large consumers
#define ETS                       parameter[4]                                      // Scaled fishing mortality rate large consumers

#define WS                        parameter[5]                                      // Default switch size (scaled)
#define Q                         parameter[6]                                      // Attack rate ratio on resource 1 and 2
#define BETA                      parameter[7]                                      // Scaled fecundity parameter

#define HERITABILITY              parameter[8]                                      // Heritability of trait value (0.3)
#define GENETICVARIANCE           parameter[9]                                      // Half-width of the truncated normal distribution (0.25)

#define MIN_SURVIVAL                1.0E-8
#define SUBCOHORTS                10


/*
 *==========================================================================
 *
 *        OTHER DEFINITIONS
 *
 *==========================================================================
 */

static long int                        MaxCohortID = 0L;
static int                            MaturingCohort, SmoltingCohort;
static int                        SubCohorts;
static double *                   subcohortfrac;
static double                     LogMinSurvival;


/*
 *==========================================================================
 *
 * USER INITIALIZATION ROUTINE ALLOWS OPERATIONS ON INITIAL POPULATIONS
 *
 *==========================================================================
 */

void    UserInit(int argc, char **argv, double *env, population *pop)

{
    int           i;
    double        yval, cumuldist;
    
    switch (argc)
    {
        case 7:
            GENETICVARIANCE = atof(argv[6]);
        case 6:
            HERITABILITY    = atof(argv[5]);
        case 5:
            WS              = atof(argv[4]);
        case 4:
            ETA2            = atof(argv[3]);
        case 3:
            ETA1            = atof(argv[2]);
        default:
            break;
    }
    
    LogMinSurvival = -log(MIN_SURVIVAL);
    for (i = 0; i < cohort_no[CONS]; i++)
    {
        popIDcard[CONS][i][IDcohortID] = MaxCohortID;
        MaxCohortID++;
        
        if ((popIDcard[CONS][i][IDnbegin] > 0.9*MISSING_VALUE) || (popIDcard[CONS][i][IDnbegin] < popIDcard[CONS][i][IDnumber]))
            popIDcard[CONS][i][IDnbegin] = popIDcard[CONS][i][IDnumber];
        
        if ((pop[CONS][i][lnsurvival] > 0.9*MISSING_VALUE) || (pop[CONS][i][lnsurvival] < 0))
            pop[CONS][i][lnsurvival] = -log(popIDcard[CONS][i][IDnumber]/popIDcard[CONS][i][IDnbegin]);
        
        if (popIDcard[CONS][i][IDsmoltsize] > 0.9*MISSING_VALUE)
            popIDcard[CONS][i][IDsmoltsize] = WS;
        
        if ((pop[CONS][i][size] >= 1.0) || isequal(pop[CONS][i][size], 1.0))
        {
            popIDcard[CONS][i][IDmatured] = 1.0;
        }
        else
        {
            popIDcard[CONS][i][IDmatured] = 0.0;
        }
        
        if ((pop[CONS][i][size] >= popIDcard[CONS][i][IDsmoltsize]) || isequal(pop[CONS][i][size]/popIDcard[CONS][i][IDsmoltsize], 1.0))
        {
            popIDcard[CONS][i][IDsmolted] = 1.0;
        }
        else
        {
            popIDcard[CONS][i][IDsmolted] = 0.0;
        }
    }
    
    if (iszero(GENETICVARIANCE)) SubCohorts = 1;
    else SubCohorts = SUBCOHORTS;
    
    subcohortfrac = (double *)malloc(SubCohorts*sizeof(double));
    cumuldist     = 0.0;
    for (i = 0; i < (SubCohorts - 1); i++)
    {
        yval = (i + 1)*(3.0/SubCohorts);
        if (yval < 1)
            subcohortfrac[i] = yval*yval*yval/6.0;
        else if (yval < 2)
            subcohortfrac[i] = -1.5*yval + 1.5*yval*yval - yval*yval*yval/3.0 + 0.5;
        else
            subcohortfrac[i] =  4.5*yval - 1.5*yval*yval + yval*yval*yval/6.0 - 3.5;
        
        subcohortfrac[i] -= cumuldist;
        cumuldist        += subcohortfrac[i];
    }
    subcohortfrac[SubCohorts - 1] = 1.0 - cumuldist;
    
    return;
}



/*
 *==========================================================================
 *
 *    SPECIFICATION OF THE NUMBER AND VALUES OF BOUNDARY POINTS
 *
 *==========================================================================
 */

void    SetBpointNo(double *env, population *pop, int *bpoint_no)

{
    // Create all the sub-cohorts as new boundary cohorts
    bpoint_no[CONS] = SubCohorts;
    
    ADULTS = ADULTWS = ADULTFEC = ADULTFECWS = 0.0;
    
    return;
}



/*==========================================================================*/

void    SetBpoints(double *env, population *pop, population *bpoints)

{
    register int        i;
    
    // All sub-cohorts have identical i-state at birth
    // The size at smolting will be set when the boundary cohort is closed off
    for (i = 0; i < SubCohorts; i++)
    {
        bpoints[CONS][i][age]  = 0.0;
        bpoints[CONS][i][size] = 0.0;
    }
    
    return;
}



/*
 *==========================================================================
 *
 *            SPECIFICATION OF DERIVATIVES
 *
 *==========================================================================
 */

void    Gradient(double *env, population *pop, population *ofs, double *envgrad, population *popgrad, population *ofsgrad, population *bpoints)

{
    register int    i;
    double          juveniles1 = 0.0, juveniles2 = 0.0, adults = 0.0;
    double          adultws = 0.0;
    
    for(i=0; i<cohort_no[CONS]; i++)
    {
        popIDcard[CONS][i][IDnumber] = exp(-(pop[CONS][i][lnsurvival] - 1.0))*popIDcard[CONS][i][IDnbegin];
        if (issmolted(i))
        {
            popgrad[CONS][i][number] = ETA2 + ETS;
            popgrad[CONS][i][size]   = Q*F2;
            popgrad[CONS][i][age]    = 1.0;
            
            if (isdead(i)) continue;
            
            if (ismature(i))
            {
                adults   += popIDcard[CONS][i][IDnumber];
                adultws  += popIDcard[CONS][i][IDsmoltsize]*popIDcard[CONS][i][IDnumber];
            }
            else
                juveniles2 += popIDcard[CONS][i][IDnumber];
        }
        else
        {
            popgrad[CONS][i][number] = ETA1;
            popgrad[CONS][i][size]   = F1;
            popgrad[CONS][i][age]    = 1.0;
            
            if (isdead(i)) continue;
            
            juveniles1 += popIDcard[CONS][i][IDnumber];
        }
    }
    
    for (i = 0; i < SubCohorts; i++)
    {
        // A fraction subcohortfrac[i] of the produced offspring ends up in sub-cohort i
        ofsgrad[CONS][i][number]  = -ETA1*ofs[CONS][i][number] + subcohortfrac[i]*BETA*Q*F2*adults;
        ofsgrad[CONS][i][age]     = -ETA1*ofs[CONS][i][age]    + ofs[CONS][i][number];
        ofsgrad[CONS][i][size]    = -ETA1*ofs[CONS][i][size]   + F1*ofs[CONS][i][number];
        
        juveniles1 += ofs[CONS][i][number];
    }
    
    envgrad[0] = 1.0;
    envgrad[1] = 1.0 - DELTA*F1 - F1*juveniles1;
    envgrad[2] = RHO - DELTA*F2 - Q*F2*(juveniles2 + adults);
    
    envgrad[3] = adults;
    envgrad[4] = adultws;
    envgrad[5] = BETA*Q*F2*adults;
    envgrad[6] = BETA*Q*F2*adultws;
    
    return;
}



/*
 *==========================================================================
 *
 *    SPECIFICATION OF EVENT LOCATION AND DYNAMIC COHORT CLOSURE
 *
 *==========================================================================
 */

void    EventLocation(double *env, population *pop, population *ofs, population *bpoints, double *events)

{
    int            i;
    
    events[0] = -1.0;
    events[1] = -1.0;
    
    for (i=0; i<cohort_no[CONS]; i++)
    {
        if (isdead(i)) continue;
        
        if (!ismature(i))
        {
            if ((pop[CONS][i][size] - 1.0) > events[0])
            {
                events[0] = (pop[CONS][i][size] - 1.0);
                MaturingCohort = i;
            }
        }
        
        if (!issmolted(i))
        {
            if ((pop[CONS][i][size]/popIDcard[CONS][i][IDsmoltsize] - 1.0) > events[1])
            {
                events[1] = (pop[CONS][i][size]/popIDcard[CONS][i][IDsmoltsize] - 1.0);
                SmoltingCohort = i;
            }
        }
    }
    
    return;
}




/*==============================================================================*/

int    ForceCohortEnd(double *env, population *pop, population *ofs, population *bpoints)

{
    int     i;
#if (DEBUG)
    char    tmpstr[256];
#endif
    
    for (i = 0; i < cohort_no[CONS]; i++)
    {
        if (isdead(i) || (ismature(i) && issmolted(i))) continue;                     // If the cohort is already mature and smolted, continue to next i value.
        
        if (!ismature(i))
        {
            if (((LocatedEvent == 0) && (i == MaturingCohort)) ||
                (pop[CONS][i][size] >= 1.0) || isequal(pop[CONS][i][size]/1.0, 1.0))
            {
#if (DEBUG)
                if (i < MaturingCohort)
                {
                    sprintf(tmpstr, "ForceCohortEnd(): Cohort #%d is maturing at t = %.6f with size W = %.5f but did not trigger a maturation event!",
                            i, env[0], pop[CONS][i][size]);
                    Warning(tmpstr);
                }
#endif
                popIDcard[CONS][i][IDmatured]   = 1.0;
                popIDcard[CONS][i][IDagematur]  = pop[CONS][i][age];
            }
        }
        
        if (!issmolted(i))
        {
            if (((LocatedEvent == 1) && (i == SmoltingCohort)) ||
                (pop[CONS][i][size] >= popIDcard[CONS][i][IDsmoltsize]) || isequal(pop[CONS][i][size]/popIDcard[CONS][i][IDsmoltsize], 1.0))
            {
#if (DEBUG)
                if (i < SmoltingCohort)
                {
                    sprintf(tmpstr, "ForceCohortEnd(): Cohort #%d is smolting at t = %.6f with size W = %.5f (target: %.5f) but did not trigger a smolting event!",
                            i, env[0], pop[CONS][i][size], popIDcard[CONS][i][IDsmoltsize]);
                    Warning(tmpstr);
                }
#endif
                popIDcard[CONS][i][IDsmolted]  = 1.0;
                popIDcard[CONS][i][IDagesmolt] = pop[CONS][i][age];
            }
        }
    }
    MaturingCohort = SmoltingCohort = -1;
    
    return NO_COHORT_END;
}



/*
 *==========================================================================
 *
 *        SPECIFICATION OF BETWEEN COHORT CYCLE DYNAMICS
 *
 *==========================================================================
 */

void    InstantDynamics(double *env, population *pop, population *ofs)

{
    register int          i;
    double            SelDif, meanparsize, meanofssize, newsmoltsize, maxsmoltsize, smoltsizedif;
    char              tmpstr[256];
    
    for (i = 0; i < cohort_no[CONS]; i++)
    {
        // remove dead cohorts
        if (isdead(i)) pop[CONS][i][lnsurvival] = 0.0;
        
        if ((!ismature(i)) && ((pop[CONS][i][size] >= 1.0) || isequal(pop[CONS][i][size]/1.0, 1.0)))
        {
            sprintf(tmpstr, "InstantDynamics(): Cohort #%d is maturing at t = %.6f with size W = %.5f but did not trigger a maturation event!",
                    i, env[0], pop[CONS][i][size]);
            Warning(tmpstr);
            
            popIDcard[CONS][i][IDmatured]   = 1.0;
            popIDcard[CONS][i][IDagematur]  = pop[CONS][i][age];
        }
        
        if ((!issmolted(i)) && ((pop[CONS][i][size] >= popIDcard[CONS][i][IDsmoltsize]) || isequal(pop[CONS][i][size]/popIDcard[CONS][i][IDsmoltsize], 1.0)))
        {
            sprintf(tmpstr, "InstantDynamics(): Cohort #%d is smolting at t = %.6f with size W = %.5f (target: %.5f) but did not trigger a smolting event!",
                    i, env[0], pop[CONS][i][size], popIDcard[CONS][i][IDsmoltsize]);
            Warning(tmpstr);
            
            popIDcard[CONS][i][IDsmolted]   = 1.0;
            popIDcard[CONS][i][IDagesmolt]  = pop[CONS][i][age];
        }
    }
    
    if (ADULTFEC)
    {
        if (!iszero(HERITABILITY))
        {
            meanparsize    = ADULTWS/ADULTS;
            meanofssize    = ADULTFECWS/ADULTFEC;
            SelDif         = HERITABILITY*(meanofssize - meanparsize);
            newsmoltsize   = meanparsize + SelDif;
        }
        else
            newsmoltsize = WS;
        
        maxsmoltsize  = (1 + GENETICVARIANCE)*newsmoltsize;
        smoltsizedif  = 2*GENETICVARIANCE*newsmoltsize/SubCohorts;
        
        for (i = 0; i < SubCohorts; i++)
        {
            ofsIDcard[CONS][i][IDnumber]    = ofs[CONS][i][number];
            ofsIDcard[CONS][i][IDnbegin]    = ofs[CONS][i][number];
            ofsIDcard[CONS][i][IDmatured]   = 0.0;
            ofsIDcard[CONS][i][IDsmolted]   = 0.0;
            ofsIDcard[CONS][i][IDsmoltsize] = maxsmoltsize - (i + 0.5)*smoltsizedif;
            ofsIDcard[CONS][i][IDagematur]  = 0.0;
            ofsIDcard[CONS][i][IDagesmolt]  = 0.0;
            ofsIDcard[CONS][i][IDcohortID]  = MaxCohortID;
            MaxCohortID++;
            
            ofs[CONS][i][age]        += i*1.0E-5;
            ofs[CONS][i][lnsurvival]  = 1.0;
        }
    }
    
    return;
}



/*
 *==========================================================================
 *
 *            SPECIFICATION OF OUTPUT VARIABLES
 *
 *==========================================================================
 */

void    DefineOutput(double *env, population *pop, double *output)

/*
 * OUTPUT VARIABLES:
 * [ 0]     2: Resource 1
 * [ 1]     3: Resource 2
 * [ 2]     4: Total number
 * [ 3]     5: Total biomass
 * [ 4]     6: Total number in habitat 1
 * [ 5]     7: Total biomass in habitat 1
 * [ 6]     8: Total number in habitat 2
 * [ 7]     9: Total biomass in habitat 2
 * [ 8]    10: Total number of juveniles in habitat 2
 * [ 9]    11: Total biomass of juveniles in habitat 2
 * [10]    12: Total number of adults
 * [11]    13: Total biomass of adults
 * [12]    14: Average smolt size in the population
 * [13]    15: Number of cohorts
 */

{
    register int    i, outnr = 0;
    double          juveniles1 = 0.0, juveniles2 = 0.0, adults = 0.0, sumsizesmolt = 0.0;
    double          juveniles1bio = 0.0, juveniles2bio = 0.0, adultsbio = 0.0;
    
    for(i=0; i<cohort_no[CONS]; i++)
    {
        popIDcard[CONS][i][IDnumber] = exp(-(pop[CONS][i][lnsurvival] - 1.0))*popIDcard[CONS][i][IDnbegin];
        sumsizesmolt += popIDcard[CONS][i][IDsmoltsize]*popIDcard[CONS][i][IDnumber];
        
        if (issmolted(i))
        {
            if (ismature(i))
            {
                adults      += popIDcard[CONS][i][IDnumber];
                adultsbio   += pop[CONS][i][size]*popIDcard[CONS][i][IDnumber];
            }
            else
            {
                juveniles2    += popIDcard[CONS][i][IDnumber];
                juveniles2bio += pop[CONS][i][size]*popIDcard[CONS][i][IDnumber];
            }
        }
        else
        {
            juveniles1    += popIDcard[CONS][i][IDnumber];
            juveniles1bio += pop[CONS][i][size]*popIDcard[CONS][i][IDnumber];
        }
    }
    
    output[outnr++] = F1;
    output[outnr++] = F2;
    output[outnr++] = juveniles1 + juveniles2 + adults;
    output[outnr++] = juveniles1bio + juveniles2bio + adultsbio;
    output[outnr++] = juveniles1;
    output[outnr++] = juveniles1bio;
    output[outnr++] = juveniles2 + adults;
    output[outnr++] = juveniles2bio + adultsbio;
    output[outnr++] = juveniles2;
    output[outnr++] = juveniles2bio;
    output[outnr++] = adults;
    output[outnr++] = adultsbio;
    output[outnr++] = sumsizesmolt/(juveniles1 + juveniles2 + adults);
    output[outnr++] = cohort_no[CONS];
    
    return;
}

