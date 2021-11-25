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
 
 Only harvesting adults in the harvested area. Harvesting effort is seperated from background
mortality. Fish individuals grow during a certain time interval. After the time interval, harvesting events 
happen. Thus, the iteration process is that indivdiduals grow first and then part of individuals
(decide by fishing effort) is harvested. The escaped individuals continue grow next time step and then 
repeat like the first time step.
i.e. periodically closures
 Last modification: RFC - Jul 11, 2021
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
#define F3                        (env[3])

#define ADULTS                    (env[4])
#define ADULTWS                   (env[5])
#define ADULTFEC                  (env[6])
#define ADULTFECWS                (env[7])

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
#define IDreserve                (i_const( 7))    //0 if this individual is out of reserve 1 if it is in reserve
#define IDcohortID                (i_const( 8))

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

#define RHO1                      parameter[0]                                      // Productivity ratio resource 1 and 2
#define RHO2                      parameter[1]                                      // Productivity ratio resource 1 and 3
#define DELTA                     parameter[2]                                      // Scaled resource turn-over rate

#define ETA1                      parameter[3]                                      // Scaled background mortality rate small consumers
#define ETA2                      parameter[4]                                      // Scaled Background mortality rate large consumers outside reserve
#define ETA3                      parameter[5]                                      // Scaled Background mortality rate large consumers in reserve
#define E0S                       parameter[6]                                      // Scaled fishing mortality rate large consumers
#define EE0S                      parameter[7]                                      // Scaled escapement rate large consumers outside reserve 

#define WS                        parameter[8]                                      // Default switch size (scaled)
#define Q                         parameter[9]                                      // Attack rate ratio on resource 1 and 2
#define BETA                      parameter[10]                                      // Scaled fecundity parameter
#define C                         parameter[11]                                     // Fraction of large consumers in reserve

#define HERITABILITY              parameter[12]                                     // Heritability of trait value (0.3)
#define GENETICVARIANCE           parameter[13]                                     // Half-width of the truncated normal distribution (0.25)

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
    bpoint_no[CONS] = 2*SubCohorts;
    
    ADULTS = ADULTWS = ADULTFEC = ADULTFECWS = 0.0;
    
    return;
}



/*==========================================================================*/

void    SetBpoints(double *env, population *pop, population *bpoints)

{
    register int        i;
    
    // All sub-cohorts have identical i-state at birth
    // The size at smolting will be set when the boundary cohort is closed off
    for (i = 0; i < 2*SubCohorts; i++)
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
    register int    i, fi;
    double          juveniles1 = 0.0, juveniles2 = 0.0, juveniles3 = 0.0, frac = 0.0, fracAdultHab;
    double          adults = 0.0, adultws = 0.0, adults2 = 0.0, adults3 = 0.0, adultws2 = 0.0, adultws3 = 0.0;
    
    for(i=0; i<cohort_no[CONS]; i++)
    {
        popIDcard[CONS][i][IDnumber] = exp(-(pop[CONS][i][lnsurvival] - 1.0))*popIDcard[CONS][i][IDnbegin];
        if (issmolted(i))
        {
            if (popIDcard[CONS][i][IDreserve]>0.0)
            {
                popgrad[CONS][i][number] = ETA3;
                popgrad[CONS][i][size]   = Q*F3;
                popgrad[CONS][i][age]    = 1.0;
                if (isdead(i)) continue;
                if (ismature(i))
                {
                    adults3  += popIDcard[CONS][i][IDnumber];
                    adultws3 += popIDcard[CONS][i][IDsmoltsize]*popIDcard[CONS][i][IDnumber];
                }
                else
                    juveniles3 += popIDcard[CONS][i][IDnumber];
            }
            else
            {
                popgrad[CONS][i][number] = ETA2;
                popgrad[CONS][i][size]   = Q*F2;
                popgrad[CONS][i][age]    = 1.0;
                if (isdead(i)) continue;
                if (ismature(i))
                {
                    adults2  += EE0S*popIDcard[CONS][i][IDnumber];
                    adultws2 += EE0S*popIDcard[CONS][i][IDsmoltsize]*popIDcard[CONS][i][IDnumber];
                }
                else
                    juveniles2 += popIDcard[CONS][i][IDnumber];
            }
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
    
    for (i = 0; i < 2*SubCohorts; i++)
    {
        // A fraction subcohortfrac[i] of the produced offspring ends up in sub-cohort i
        
        fi = fmod(i,SubCohorts);
        fracAdultHab = C;
        if (i<SubCohorts) fracAdultHab = 1-C;
        
        ofsgrad[CONS][i][number]  = -ETA1*ofs[CONS][i][number] + fracAdultHab*subcohortfrac[fi]*BETA*Q*(F2*adults2+F3*adults3);
        ofsgrad[CONS][i][age]     = -ETA1*ofs[CONS][i][age]    + ofs[CONS][i][number];
        ofsgrad[CONS][i][size]    = -ETA1*ofs[CONS][i][size]   + F1*ofs[CONS][i][number];
        
        juveniles1 += ofs[CONS][i][number];
    }
    
    envgrad[0] = 1.0;
    envgrad[1] = 1.0 - DELTA*F1 - F1*juveniles1;
    envgrad[2] = RHO1 - DELTA*F2 - Q*F2*(juveniles2 + adults2);
    envgrad[3] = RHO2 - DELTA*F3 - Q*F3*(juveniles3 + adults3);
    
    envgrad[4] = adults2+adults3;
    envgrad[5] = adultws2+adultws3;
    envgrad[6] = BETA*Q*(F2*adults2+F3*adults3);
    envgrad[7] = BETA*Q*(F2*adultws2+F3*adultws3);
    
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
    register int          i, k;
    double            SelDif, meanparsize, meanofssize, newsmoltsize, maxsmoltsize, smoltsizedif, res;
    char              tmpstr[256];
    
    for (i = 0; i < cohort_no[CONS]; i++)
    {
        // remove dead cohorts
        if (isdead(i)) pop[CONS][i][lnsurvival] = 0.0;
        
        if ((!ismature(i)) && ((pop[CONS][i][size] >= 1.0) || isequal(pop[CONS][i][size]/1.0, 1.0)))
        {
//            sprintf(tmpstr, "InstantDynamics(): Cohort #%d is maturing at t = %.6f with size W = %.5f but did not trigger a maturation event!",
//                    i, env[0], pop[CONS][i][size]);
//            Warning(tmpstr);
            
            popIDcard[CONS][i][IDmatured]   = 1.0;
            popIDcard[CONS][i][IDagematur]  = pop[CONS][i][age];
        }
        
        if ((!issmolted(i)) && ((pop[CONS][i][size] >= popIDcard[CONS][i][IDsmoltsize]) || isequal(pop[CONS][i][size]/popIDcard[CONS][i][IDsmoltsize], 1.0)))
        {
  //          sprintf(tmpstr, "InstantDynamics(): Cohort #%d is smolting at t = %.6f with size W = %.5f (target: %.5f) but did not trigger a smolting event!",
  //                  i, env[0], pop[CONS][i][size], popIDcard[CONS][i][IDsmoltsize]);
  //          Warning(tmpstr);
            
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
        
        for (i = 0; i < 2*SubCohorts; i++)
        {
            res = 1.0;
            if (i<SubCohorts) res = 0.0;
            
            ofsIDcard[CONS][i][IDnumber]    = ofs[CONS][i][number];
            ofsIDcard[CONS][i][IDnbegin]    = ofs[CONS][i][number];
            ofsIDcard[CONS][i][IDmatured]   = 0.0;
            ofsIDcard[CONS][i][IDsmolted]   = 0.0;
            ofsIDcard[CONS][i][IDsmoltsize] = max(0.0,maxsmoltsize - (i + 0.5)*smoltsizedif);
            ofsIDcard[CONS][i][IDagematur]  = 0.0;
            ofsIDcard[CONS][i][IDagesmolt]  = 0.0;
            ofsIDcard[CONS][i][IDreserve]   = res;
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
 * [ 2]     4: Resource 3
 * [ 3]     5: Total number
 * [ 4]     6: Total biomass
 * [ 5]     7: Total number in habitat 1
 * [ 6]     8: Total biomass in habitat 1
 * [ 7]     9: Total number in habitat 2
 * [ 8]    10: Total biomass in habitat 2
 * [ 9]    11: Total number in habitat 3
 * [10]    12: Total biomass in habitat 3
 * [11]    13: Total number of juveniles in habitat 2
 * [12]    14: Total biomass of juveniles in habitat 2
 * [13]    15: Total number of juveniles in habitat 3
 * [14]    16: Total biomass of juveniles in habitat 3
 * [15]    17: Total number of adults in habitat 2
 * [16]    18: Total biomass of adults in habitat 2
 * [17]    19: Total number of adults in habitat 3
 * [18]    20: Total biomass of adults in habitat 3
 * [19]    21: Average smolt size in the population
 * [20]    22: Number of cohorts
 * [21]    23: Total number of fisheries yields
 * [22]    24: Total biomass of fisheries yields
 */

{
    register int    i, outnr = 0;
    double          juveniles1 = 0.0, juveniles2 = 0.0, juveniles3 = 0.0, adults2 = 0.0, adults3 = 0.0, sumsizesmolt = 0.0;
    double          juveniles1bio = 0.0, juveniles2bio = 0.0, juveniles3bio = 0.0, adults2bio = 0.0, adults3bio = 0.0, yieldnum = 0.0,yieldbio = 0.0;
    
    for(i=0; i<cohort_no[CONS]; i++)
    {
        popIDcard[CONS][i][IDnumber] = exp(-(pop[CONS][i][lnsurvival] - 1.0))*popIDcard[CONS][i][IDnbegin];
        sumsizesmolt += popIDcard[CONS][i][IDsmoltsize]*popIDcard[CONS][i][IDnumber];
        
        if (issmolted(i))
        {
            if (popIDcard[CONS][i][IDreserve]>0.0)
            {
                if (ismature(i))
                {
                    adults3     += popIDcard[CONS][i][IDnumber];
                    adults3bio  += pop[CONS][i][size]*popIDcard[CONS][i][IDnumber];
                }
                else
                {
                    juveniles3    += popIDcard[CONS][i][IDnumber];
                    juveniles3bio += pop[CONS][i][size]*popIDcard[CONS][i][IDnumber];
                }
            }
            else
            {
                if (ismature(i))
                {
                    adults2     += EE0S*popIDcard[CONS][i][IDnumber];
                    adults2bio  += EE0S*pop[CONS][i][size]*popIDcard[CONS][i][IDnumber];
                    yieldnum    += E0S*popIDcard[CONS][i][IDnumber];
                    yieldbio    += E0S*pop[CONS][i][size]*popIDcard[CONS][i][IDnumber];
                }
                else
                {
                    juveniles2    += popIDcard[CONS][i][IDnumber];
                    juveniles2bio += pop[CONS][i][size]*popIDcard[CONS][i][IDnumber];
                }
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
    output[outnr++] = F3;
    output[outnr++] = juveniles1 + juveniles2 + juveniles3 + adults2 + adults3;
    output[outnr++] = juveniles1bio + juveniles2bio + juveniles3bio + adults2bio + adults3bio;
    output[outnr++] = juveniles1;
    output[outnr++] = juveniles1bio;
    output[outnr++] = juveniles2 + adults2;
    output[outnr++] = juveniles2bio + adults2bio;
    output[outnr++] = juveniles3 + adults3;
    output[outnr++] = juveniles3bio + adults3bio;
    output[outnr++] = juveniles2;
    output[outnr++] = juveniles2bio;
    output[outnr++] = juveniles3;
    output[outnr++] = juveniles3bio;
    output[outnr++] = adults2;
    output[outnr++] = adults2bio;
    output[outnr++] = adults3;
    output[outnr++] = adults3bio;
    output[outnr++] = sumsizesmolt/(juveniles1 + juveniles2 + juveniles3 + adults2 + adults3);
    output[outnr++] = cohort_no[CONS];
    output[outnr++] = yieldnum;
    output[outnr++] = yieldbio;

    return;
}

