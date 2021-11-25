/*
  transientNOreserve.h -  Header file specifying the elementary life-history functions of
                the resource-consumer model with 2 habitats

                Simple size-structured model with a niche shift
                Two habitats with unstructured resources
                Niche shift occurs before maturation

  Layout for the i-state variables:

    istate[0][0]  : Age
    istate[0][1]  : Size

  Layout for the environment variables:

    E[0]          : Resource in breeding habitat
    E[1]          : Resource in non-breeding habitat

  Layout for the interaction (and output) variables:

    I[0][0]       : Total resource ingestion by the individuals in the breeding habitat
    I[0][1]       : Total resource ingestion by the individuals in the non-breeding habitat

    I[0][2]       : Total biomass of individuals in the breeding habitat
    I[0][3]       : Total biomass of immature individuals in the non-breeding habitat
    I[0][4]       : Total biomass of mature individuals in the non-breeding habitat
    I[0][5]       : Number of individuals in the breeding habitat
    I[0][6]       : Number of individuals in the non-breeding habitat
 

  Last modification: RF C - June 16, 2021
*/

/*
 *====================================================================================================================================
 *  SECTION 1: PROBLEM DIMENSIONS, NUMERICAL SETTINGS AND MODEL PARAMETERS
 *====================================================================================================================================
 */
// Dimension settings: Required
#define POPULATION_NR             1
#define STAGES                    3
#define I_STATE_DIM               2
#define ENVIRON_DIM               2
#define INTERACT_DIM              7
#define PARAMETER_NR              8

// Numerical settings: Optional (default values adopted otherwise)
#define MIN_SURVIVAL              1.0E-9                                            // Survival at which individual is considered dead
#define MAX_AGE                   100000                                            // Give some absolute maximum for individual age

#define DYTOL                     1.0E-7                                            // Variable tolerance
#define RHSTOL                    1.0E-6                                            // Function tolerance

#define ALLOWNEGATIVE             0                                                 // Negative solution values allowed?
#define COHORT_NR                 500                                               // Number of cohorts in state output


// Descriptive names of parameters in parameter array (at least two parameters are required)
char *parameternames[PARAMETER_NR] = { "phi", "rho", "q", "beta", "eta1", "eta2", "fet","ws"};

// Default values of all parameters
double parameter[PARAMETER_NR] = {1.0, 0.5, 1.0, 2000.0, 0.8, 0.8, 0.1, 0.1};


// Aliases definitions for all istate variables
#define AGE                       istate[0][0]
#define SIZE                      istate[0][1]

// Aliases definitions for all environment variables
    
#define F1                        E[0]                                              // Resource in the breeding habitat
#define F2                        E[1]                                              // Resource in the non-breeding habitat

// Aliases definitions for all parameters
#define PHI                         parameter[0]                                      // Resource growth rate (0.1)
#define RHO                       parameter[1]                                      // Relation between the carrying capacity of the two resources
#define Q                            parameter[2]                                      // Relation between the feeding rate on the two resources
#define BETA                      parameter[3]                                      // 
#define ETA1                      parameter[4]                                      // Mortality in the breeding habitat
#define ETA2                      parameter[5]                                      // Mortality in the non-breeding habitat harvested area
#define FET                         parameter[6]                                      // Fishing effort in the non-breeding habitat harvested area
#define WS                         parameter[7]                                      // Size at habitat switch 

/*
 *====================================================================================================================================
 *  SECTION 2: DEFINITION OF THE INDIVIDUAL LIFE HISTORY
 *====================================================================================================================================
 */

/*
 * Specify the number of states at birth for the individuals in all structured
 * populations in the problem in the vector BirthStates[].
 */

void SetBirthStates(int BirthStates[POPULATION_NR], double E[])
{
  BirthStates[0] = 1;

  return;
}


/*
 * Specify all the possible states at birth for all individuals in all
 * structured populations in the problem. BirthStateNr represents the index of
 * the state of birth to be specified. Each state at birth should be a single,
 * constant value for each i-state variable.
 *
 * Notice that the first index of the variable 'istate[][]' refers to the
 * number of the structured population, the second index refers to the
 * number of the individual state variable. The interpretation of the latter
 * is up to the user.
 */

void StateAtBirth(double *istate[POPULATION_NR], int BirthStateNr, double E[])
{
  AGE  = 0.0;
  SIZE = 0.0;

  return;
}


/*
 * Specify the threshold determining the end point of each discrete life
 * stage in individual life history as function of the i-state variables and
 * the individual's state at birth for all populations in every life stage.
 *
 * Notice that the first index of the variable 'istate[][]' refers to the
 * number of the structured population, the second index refers to the
 * number of the individual state variable. The interpretation of the latter
 * is up to the user.
 */

void IntervalLimit(int lifestage[POPULATION_NR], double *istate[POPULATION_NR], double *birthstate[POPULATION_NR], int BirthStateNr, double E[],
                   double limit[POPULATION_NR])
{
  switch (lifestage[0])
    {
      case 0:
        limit[0] = SIZE - WS;
        break;
      case 1:
        limit[0] = SIZE - 1;
        break;
    }

  return;
}


/*
 * Specify the development of individuals as a function of the i-state
 * variables and the individual's state at birth for all populations in every
 * life stage.
 *
 * Notice that the first index of the variables 'istate[][]' and 'development[][]'
 * refers to the number of the structured population, the second index refers
 * to the number of the individual state variable. The interpretation of the
 * latter is up to the user.
 */

void Development(int lifestage[POPULATION_NR], double *istate[POPULATION_NR], double *birthstate[POPULATION_NR], int BirthStateNr, double E[],
                 double development[POPULATION_NR][I_STATE_DIM])
{
  double Tfac;
    
  development[0][0] = 1.0;

  if (lifestage[0] == 0)
    {
      development[0][1] = F1;
    }
  else
    {
      development[0][1] = Q*F2;
    }
  return;
}


/*
 * Specify the possible discrete changes (jumps) in the individual state
 * variables when ENTERING the stage specified by 'lifestage[]'.
 *
 * Notice that the first index of the variable 'istate[][]' refers to the
 * number of the structured population, the second index refers to the
 * number of the individual state variable. The interpretation of the latter
 * is up to the user.
 */

void DiscreteChanges(int lifestage[POPULATION_NR], double *istate[POPULATION_NR], double *birthstate[POPULATION_NR], int BirthStateNr, double E[])
{
  return;
}


/*
 * Specify the fecundity of individuals as a function of the i-state
 * variables and the individual's state at birth for all populations in every
 * life stage.
 *
 * The number of offspring produced has to be specified for every possible
 * state at birth in the variable 'fecundity[][]'. The first index of this
 * variable refers to the number of the structured population, the second
 * index refers to the number of the birth state.
 *
 * Notice that the first index of the variable 'istate[][]' refers to the
 * number of the structured population, the second index refers to the
 * number of the individual state variable. The interpretation of the latter
 * is up to the user.
 */

void Fecundity(int lifestage[POPULATION_NR], double *istate[POPULATION_NR], double *birthstate[POPULATION_NR], int BirthStateNr, double E[],
               double *fecundity[POPULATION_NR])
{
  double        Wnewborn, Tfac;

  fecundity[0][0] = 0.0;
  if (lifestage[0] == 2)
  {
    fecundity[0][0] = BETA*Q*F2;
  }

  return;
}


/*
 * Specify the mortality of individuals as a function of the i-state
 * variables and the individual's state at birth for all populations in every
 * life stage.
 *
 * Notice that the first index of the variable 'istate[][]' refers to the
 * number of the structured population, the second index refers to the
 * number of the individual state variable. The interpretation of the latter
 * is up to the user.
 */

void Mortality(int lifestage[POPULATION_NR], double *istate[POPULATION_NR], double *birthstate[POPULATION_NR], int BirthStateNr, double E[],
               double mortality[POPULATION_NR])
{
  double lenval, lmaxpr, sizemort;

  if (lifestage[0] == 0)
    mortality[0] = ETA1;
  else
  {
    mortality[0] = ETA2+FET;
  }
  return;
}


/*
 *====================================================================================================================================
 *  SECTION 3: FEEDBACK ON THE ENVIRONMENT
 *====================================================================================================================================
 */

/*
 * For all the integrals (measures) that occur in interactions of the
 * structured populations with their environments and for all the integrals
 * that should be computed for output purposes (e.g. total juvenile or adult
 * biomass), specify appropriate weighing function dependent on the i-state
 * variables, the individual's state at birth, the environment variables and
 * the current life stage of the individuals. These weighing functions should
 * be specified for all structured populations in the problem. The number of
 * weighing functions is the same for all of them.
 *
 * Notice that the first index of the variables 'istate[][]' and 'impact[][]'
 * refers to the number of the structured population, the second index of the
 * variable 'istate[][]' refers to the number of the individual state variable,
 * while the second index of the variable 'impact[][]' refers to the number of
 * the interaction variable. The interpretation of these second indices is up
 * to the user.
 */

void Impact(int lifestage[POPULATION_NR], double *istate[POPULATION_NR], double *birthstate[POPULATION_NR], int BirthStateNr, double E[],
            double impact[POPULATION_NR][INTERACT_DIM])
{
  
  switch (lifestage[0])
    {
      case 0:
        impact[0][0] = F1;
        impact[0][1] = 0;
        impact[0][2] = SIZE;
        impact[0][3] = 0;
        impact[0][4] = 0;
        impact[0][5] = 1;
        impact[0][6] = 0;
        break;
      case 1:
        impact[0][0] = 0;
        impact[0][1] = Q*F2;
        impact[0][2] = 0;
        impact[0][3] = SIZE;
        impact[0][4] = 0;
        impact[0][5] = 0;
        impact[0][6] = 1;
        break;
      case 2:
        impact[0][0] = 0;
        impact[0][1] = Q*F2;
        impact[0][2] = 0;
        impact[0][3] = 0;
        impact[0][4] = SIZE;
        impact[0][5] = 0;
        impact[0][6] = 1;
        break;
    }

  return;
}


/*
 * Specify the type of each of the environment variables by setting
 * the entries in EnvironmentType[ENVIRON_DIM] to PERCAPITARATE, GENERALODE
 * or POPULATIONINTEGRAL based on the classification below:
 *
 * Set an entry to PERCAPITARATE if the dynamics of E[j] follow an ODE and 0
 * is a possible equilibrium state of E[j]. The ODE is then of the form
 * dE[j]/dt = P(E,I)*E[j], with P(E,I) the per capita growth rate of E[j].
 * Specify the equilibrium condition as condition[j] = P(E,I), do not include
 * the multiplication with E[j] to allow for detecting and continuing the
 * transcritical bifurcation between the trivial and non-trivial equilibrium.
 *
 * Set an entry to GENERALODE if the dynamics of E[j] follow an ODE and 0 is
 * NOT an equilibrium state of E. The ODE then has a form dE[j]/dt = G(E,I).
 * Specify the equilibrium condition as condition[j] = G(E,I).
 *
 * Set an entry to POPULATIONINTEGRAL if E[j] is a (weighted) integral of the
 * population distribution, representing for example the total population
 * biomass. E[j] then can be expressed as E[j] = I[p][i]. Specify the
 * equilibrium condition in this case as condition[j] = I[p][i].
 *
 * Notice that the first index of the variable 'I[][]' refers to the
 * number of the structured population, the second index refers to the
 * number of the interaction variable. The interpretation of the latter
 * is up to the user. Also notice that the variable 'condition[j]' should
 * specify the equilibrium condition of environment variable 'E[j]'.
 */

const int EnvironmentType[ENVIRON_DIM] = {GENERALODE};

void EnvEqui(double E[], double I[POPULATION_NR][INTERACT_DIM], double condition[ENVIRON_DIM])
{
  condition[0] = (1 - PHI*F1) - I[0][0];
  condition[1] = (RHO - PHI*F2) - I[0][1];

  return;
}


/*==================================================================================================================================*/
