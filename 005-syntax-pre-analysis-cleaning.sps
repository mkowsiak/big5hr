* Encoding: UTF-8.
cd '@PROJECT_LOCATION@/data'.
show dir.

get file='004-BigFiveHR-pre-analysis.sav'.

DATASET NAME big5hr.
DATASET ACTIVATE big5hr.

RENAME VARIABLES discussGithubprojects = GITHUB_BAYES.
VARIABLE LABELS GITHUB_BAYES "Discuss Github projects".

RENAME VARIABLES discussyourpastprojects        = PAST_PROJECTS_BAYES.
VARIABLE LABELS PAST_PROJECTS_BAYES               "Discuss your past projects".

RENAME VARIABLES jobinterview                   = JOB_INTERVIEW_BAYES.
VARIABLE LABELS JOB_INTERVIEW_BAYES               "Job interview".

RENAME VARIABLES pairprogrammingwithinterviewer = PAIR_PROGRAMMING_BAYES.
VARIABLE LABELS PAIR_PROGRAMMING_BAYES            "Pair programming with interviewer".

RENAME VARIABLES solveaproblemathome            = HOMEWORK_BAYES.
VARIABLE LABELS HOMEWORK_BAYES                    "Solve a problem at home".

RENAME VARIABLES whiteboardcoding               = WHITEBOARD_BAYES.
VARIABLE LABELS WHITEBOARD_BAYES                  "White board coding".
EXECUTE.

* min and max for GITHUB_BAYES.
AGGREGATE  /OUTFILE=*  OVERWRITE=YES MODE=ADDVARIABLES
/BREAK=   /GITHUB_BAYES_MIN = MIN(GITHUB_BAYES).
AGGREGATE  /OUTFILE=*  OVERWRITE=YES MODE=ADDVARIABLES
/BREAK=   /GITHUB_BAYES_MAX = MAX(GITHUB_BAYES).

* min and max for PAST_PROJECTS_BAYES.
AGGREGATE  /OUTFILE=*  OVERWRITE=YES MODE=ADDVARIABLES
/BREAK=   /PAST_PROJECTS_BAYES_MIN = MIN(PAST_PROJECTS_BAYES).
AGGREGATE  /OUTFILE=*  OVERWRITE=YES MODE=ADDVARIABLES
/BREAK=   /PAST_PROJECTS_BAYES_MAX = MAX(PAST_PROJECTS_BAYES).

* min and max for JOB_INTERVIEW_BAYES.
AGGREGATE  /OUTFILE=*  OVERWRITE=YES MODE=ADDVARIABLES
/BREAK=   /JOB_INTERVIEW_BAYES_MIN = MIN(JOB_INTERVIEW_BAYES).
AGGREGATE  /OUTFILE=*  OVERWRITE=YES MODE=ADDVARIABLES
/BREAK=   /JOB_INTERVIEW_BAYES_MAX = MAX(JOB_INTERVIEW_BAYES).

* min and max for PAIR_PROGRAMMING_BAYES.
AGGREGATE  /OUTFILE=*  OVERWRITE=YES MODE=ADDVARIABLES
/BREAK=   /PAIR_PROGRAMMING_BAYES_MIN = MIN(PAIR_PROGRAMMING_BAYES).
AGGREGATE  /OUTFILE=*  OVERWRITE=YES MODE=ADDVARIABLES
/BREAK=   /PAIR_PROGRAMMING_BAYES_MAX = MAX(PAIR_PROGRAMMING_BAYES).

* min and max for HOMEWORK_BAYES.
AGGREGATE  /OUTFILE=*  OVERWRITE=YES MODE=ADDVARIABLES
/BREAK=   /HOMEWORK_BAYES_MIN = MIN(HOMEWORK_BAYES).
AGGREGATE  /OUTFILE=*  OVERWRITE=YES MODE=ADDVARIABLES
/BREAK=   /HOMEWORK_BAYES_MAX = MAX(HOMEWORK_BAYES).

* min and max for WHITEBOARD_BAYES.
AGGREGATE  /OUTFILE=*  OVERWRITE=YES MODE=ADDVARIABLES
/BREAK=   /WHITEBOARD_BAYES_MIN = MIN(WHITEBOARD_BAYES).
AGGREGATE  /OUTFILE=*  OVERWRITE=YES MODE=ADDVARIABLES
/BREAK=   /WHITEBOARD_BAYES_MAX = MAX(WHITEBOARD_BAYES).

VARIABLE LABELS GITHUB_BAYES_MIN           "Discuss Github projects (minimum)".
VARIABLE LABELS PAST_PROJECTS_BAYES_MIN    "Discuss your past projects (minimum)".
VARIABLE LABELS JOB_INTERVIEW_BAYES_MIN    "Job interview (minimum)".
VARIABLE LABELS PAIR_PROGRAMMING_BAYES_MIN "Pair programming with interviewer (minimum)".
VARIABLE LABELS HOMEWORK_BAYES_MIN         "Solve a problem at home (minimum)".
VARIABLE LABELS WHITEBOARD_BAYES_MIN       "White board coding (minimum)".

VARIABLE LABELS GITHUB_BAYES_MAX           "Discuss Github projects (maximum)".
VARIABLE LABELS PAST_PROJECTS_BAYES_MAX    "Discuss your past projects (maximum)".
VARIABLE LABELS JOB_INTERVIEW_BAYES_MAX    "Job interview (maximum)".
VARIABLE LABELS PAIR_PROGRAMMING_BAYES_MAX "Pair programming with interviewer (maximum)".
VARIABLE LABELS HOMEWORK_BAYES_MAX         "Solve a problem at home (maximum)".
VARIABLE LABELS WHITEBOARD_BAYES_MAX       "White board coding (maximum)".
EXECUTE.

* normalized values of all preferences.
COMPUTE GITHUB_BAYES_NORMALIZED            =(GITHUB_BAYES           - GITHUB_BAYES_MIN)            / (GITHUB_BAYES_MAX           - GITHUB_BAYES_MIN).
COMPUTE PAST_PROJECTS_BAYES_NORMALIZED     =(PAST_PROJECTS_BAYES    - PAST_PROJECTS_BAYES_MIN)     / (PAST_PROJECTS_BAYES_MAX    - PAST_PROJECTS_BAYES_MIN).
COMPUTE JOB_INTERVIEW_BAYES_NORMALIZED     =(JOB_INTERVIEW_BAYES    - JOB_INTERVIEW_BAYES_MIN)     / (JOB_INTERVIEW_BAYES_MAX    - JOB_INTERVIEW_BAYES_MIN).
COMPUTE PAIR_PROGRAMMING_BAYES_NORMALIZED  =(PAIR_PROGRAMMING_BAYES - PAIR_PROGRAMMING_BAYES_MIN)  / (PAIR_PROGRAMMING_BAYES_MAX - PAIR_PROGRAMMING_BAYES_MIN).
COMPUTE HOMEWORK_BAYES_NORMALIZED          =(HOMEWORK_BAYES         - HOMEWORK_BAYES_MIN)          / (HOMEWORK_BAYES_MAX         - HOMEWORK_BAYES_MIN).
COMPUTE WHITEBOARD_BAYES_NORMALIZED        =(WHITEBOARD_BAYES       - WHITEBOARD_BAYES_MIN)        / (WHITEBOARD_BAYES_MAX       - WHITEBOARD_BAYES_MIN).

* we need new variables for Extraversion - these variables will be used later on for the segmentation purpose.
* BFI_E_2nd - two ranges: [min, median] and [median, max] .

* median of BFI_E.
AGGREGATE  /OUTFILE=*  OVERWRITE=YES MODE=ADDVARIABLES
/BREAK=   /BFI_E_MEDIAN = MEDIAN(BFI_E).

COMPUTE  BFI_E_2nd=0.
variable level BFI_E_2nd(NOMINAL).
formats BFI_E_2nd(f1.0).
if (BFI_E < BFI_E_MEDIAN)  BFI_E_2nd = 1.
if (BFI_E = BFI_E_MEDIAN)  BFI_E_2nd = 3.
if (BFI_E > BFI_E_MEDIAN)  BFI_E_2nd = 2.
execute.

value labels BFI_E_2nd 1 'solitary/reserved' 2 'outgoing/energetic' 3 'out of the analysis'.

* we need new variables for Neurotism - these variables will be used later on for the segmentation purpose.
* BFI_N_2nd - two ranges: [min, median] and [median, max] .

* median of BFI_N.
AGGREGATE  /OUTFILE=*  OVERWRITE=YES MODE=ADDVARIABLES
/BREAK=   /BFI_N_MEDIAN = MEDIAN(BFI_N).

COMPUTE  BFI_N_2nd=0.
variable level BFI_N_2nd(NOMINAL).
formats BFI_N_2nd(f1.0).
if (BFI_N < BFI_N_MEDIAN)  BFI_N_2nd = 1.
if (BFI_N = BFI_N_MEDIAN)  BFI_N_2nd = 3.
if (BFI_N > BFI_N_MEDIAN)  BFI_N_2nd = 2.
execute.

value labels BFI_N_2nd 1 'resilient/confident' 2 'sensitive/nervous' 3 'out of the analysis'.

* we need new variables for Agreeablenes - these variables will be used later on for the segmentation purpose.
* BFI_A_2nd - two ranges: [min, median] and [median, max] .

* median of BFI_A.
AGGREGATE  /OUTFILE=*  OVERWRITE=YES MODE=ADDVARIABLES
/BREAK=   /BFI_A_MEDIAN = MEDIAN(BFI_A).

COMPUTE  BFI_A_2nd=0.
variable level BFI_A_2nd(NOMINAL).
formats BFI_A_2nd(f1.0).
if (BFI_A < BFI_A_MEDIAN)  BFI_A_2nd = 1.
if (BFI_A = BFI_A_MEDIAN)  BFI_A_2nd = 3.
if (BFI_A > BFI_A_MEDIAN)  BFI_A_2nd = 2.
execute.

value labels BFI_A_2nd 1 'critical/rational' 2 'friendly/compassionate' 3 'out of the analysis'.

* we need new variables for Conciousnes - these variables will be used later on for the segmentation purpose.
* BFI_C_2nd - two ranges: [min, median] and [median, max] .

* median of BFI_C.
AGGREGATE  /OUTFILE=*  OVERWRITE=YES MODE=ADDVARIABLES
/BREAK=   /BFI_C_MEDIAN = MEDIAN(BFI_C).

COMPUTE  BFI_C_2nd=0.
variable level BFI_C_2nd(NOMINAL).
formats BFI_C_2nd(f1.0).
if (BFI_C < BFI_C_MEDIAN)  BFI_C_2nd = 1.
if (BFI_C = BFI_C_MEDIAN)  BFI_C_2nd = 3.
if (BFI_C > BFI_C_MEDIAN)  BFI_C_2nd = 2.
execute.

value labels BFI_C_2nd 1 'extravagant/careless' 2 'efficient/organized' 3 'out of the analysis'.

* we need new variables for Openes - these variables will be used later on for the segmentation purpose.
* BFI_O_2nd - two ranges: [min, median] and [median, max] .

* median of BFI_O.
AGGREGATE  /OUTFILE=*  OVERWRITE=YES MODE=ADDVARIABLES
/BREAK=   /BFI_O_MEDIAN = MEDIAN(BFI_O).

COMPUTE  BFI_O_2nd=0.
variable level BFI_O_2nd(NOMINAL).
formats BFI_O_2nd(f1.0).
if (BFI_O < BFI_O_MEDIAN)  BFI_O_2nd = 1.
if (BFI_O = BFI_O_MEDIAN)  BFI_O_2nd = 3.
if (BFI_O > BFI_O_MEDIAN)  BFI_O_2nd = 2.
execute.

value labels BFI_O_2nd 1 'consistent/cautious' 2 'inventive/curious' 3 'out of the analysis'.

save outfile='005-BigFiveHR-analysis.sav'.
