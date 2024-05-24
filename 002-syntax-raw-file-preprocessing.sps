* Encoding: UTF-8.
cd '@PROJECT_LOCATION@/data'.
show dir.

get file='001-BigFiveHR-raw.sav'.

* rename ResponseId to pid and sort by pid - this will help us later on while merging with `R` output.
SORT CASES BY pid.

* calculate personal traits.
* From the scoring instructions for BFI.
* We have to reverse-score  all negatively-keyed items:.
* Extraversion:       6, 21, 31
* Agreeableness:      2, 12, 27, 37
* Conscientiousness:  8, 18, 23, 43
* Neuroticism:        9, 24, 34
* Openness:          35, 41
*
* 2,       6,       8,       9,       12,      18,      21,      23,      24,      27,      31,      34,      35,      37,      41,      43.
RECODE
  BFI_02   BFI_06   BFI_08   BFI_09   BFI_12   BFI_18   BFI_21   BFI_23   BFI_24   BFI_27   BFI_31   BFI_34   BFI_35   BFI_37   BFI_41   BFI_43
  (1=5)  (2=4)  (3=3)  (4=2)  (5=1)
  INTO  
  BFI_02_R BFI_06_R BFI_08_R BFI_09_R BFI_12_R BFI_18_R BFI_21_R BFI_23_R BFI_24_R BFI_27_R BFI_31_R BFI_34_R BFI_35_R BFI_37_R BFI_41_R BFI_43_R.
* 2,       6,       8,       9,       12,      18,      21,      23,      24,      27,      31,      34,      35,      37,      41,      43.
EXECUTE.

* Next, you will create scale scores by averaging the following items for each B5 domain (where R indicates using the reverse-scored item).
* Extraversion:       1, 6R,  11,  16, 21R,  26, 31R,  36.
* Agreeableness:     2R,  7, 12R,  17,  22, 27R,  32, 37R,  42.
* Conscientiousness:  3, 8R,  13, 18R, 23R,  28,  33,  38, 43R.
* Neuroticism:        4, 9R,  14,  19, 24R,  29, 34R,  39.
* Openness:           5, 10,  15,  20,  25,  30, 35R,  40, 41R, 44.

* Extraversion:      1,        6R,       11,       16,       21R,      26,       31R,      36.
COMPUTE BFI_E = mean(BFI_01,   BFI_06_R, BFI_11,   BFI_16,   BFI_21_R, BFI_26,   BFI_31_R, BFI_36).

* Agreeableness:     2R,       7,        12R,      17,       22,       27R,      32,       37R,      42.
COMPUTE BFI_A = mean(BFI_02_R, BFI_07,   BFI_12_R, BFI_17,   BFI_22,   BFI_27_R, BFI_32,   BFI_37_R, BFI_42).

* Conscientiousness: 3,        8R,       13,       18R,      23R,      28,       33,       38,       43R.
COMPUTE BFI_C = mean(BFI_03,   BFI_08_R, BFI_13,   BFI_18_R, BFI_23_R, BFI_28,   BFI_33,   BFI_38,   BFI_43_R).

* Neuroticism:       4,        9R,       14,       19,       24R,      29,       34R,      39.
COMPUTE BFI_N = mean(BFI_04,   BFI_09_R, BFI_14,   BFI_19,   BFI_24_R, BFI_29,   BFI_34_R, BFI_39).

* Openness:          5,        10,       15,       20,       25,       30,       35R,      40,       41R,      44.
COMPUTE BFI_O = mean(BFI_05,   BFI_10,   BFI_15,   BFI_20,   BFI_25,   BFI_30,   BFI_35_R, BFI_40,   BFI_41_R, BFI_44).
EXECUTE.

VARIABLE LABELS BFI_E 'BFI - Extraversion scale score'.
VARIABLE LABELS BFI_A 'BFI - Agreeableness scale score'.
VARIABLE LABELS BFI_C 'BFI - Conscientiousness scale score'.
VARIABLE LABELS BFI_N 'BFI - Neuroticism scale score'.
VARIABLE LABELS BFI_O 'BFI - Openness scale score'.
EXECUTE.

* calculate max diff preferences counts.
COUNT GITHUB_PRO=MAX_DIFF_01_1 MAX_DIFF_02_1 MAX_DIFF_03_1 MAX_DIFF_04_1 MAX_DIFF_06_1 MAX_DIFF_07_1 MAX_DIFF_10_1 MAX_DIFF_11_1 MAX_DIFF_13_1 MAX_DIFF_14_1 (2).
COUNT GITHUB_AGAINST=MAX_DIFF_01_1 MAX_DIFF_02_1 MAX_DIFF_03_1 MAX_DIFF_04_1 MAX_DIFF_06_1 MAX_DIFF_07_1 MAX_DIFF_10_1 MAX_DIFF_11_1 MAX_DIFF_13_1 MAX_DIFF_14_1 (1).

COUNT PAST_PROJECTS_PRO=MAX_DIFF_02_3 MAX_DIFF_03_3 MAX_DIFF_05_2 MAX_DIFF_07_2 MAX_DIFF_08_2 MAX_DIFF_09_1 MAX_DIFF_11_2 MAX_DIFF_12_2 MAX_DIFF_13_3 MAX_DIFF_14_2 (2).
COUNT PAST_PROJECTS_AGAINST=MAX_DIFF_02_3 MAX_DIFF_03_3 MAX_DIFF_05_2 MAX_DIFF_07_2 MAX_DIFF_08_2 MAX_DIFF_09_1 MAX_DIFF_11_2 MAX_DIFF_12_2 MAX_DIFF_13_3 MAX_DIFF_14_2 (1).

COUNT JOB_INTERVIEW_PRO=MAX_DIFF_01_3 MAX_DIFF_04_2 MAX_DIFF_05_3 MAX_DIFF_06_3 MAX_DIFF_07_3 MAX_DIFF_09_2 MAX_DIFF_11_3 MAX_DIFF_12_3 MAX_DIFF_13_4 MAX_DIFF_15_2 (2).
COUNT JOB_INTERVIEW_AGAINST=MAX_DIFF_01_3 MAX_DIFF_04_2 MAX_DIFF_05_3 MAX_DIFF_06_3 MAX_DIFF_07_3 MAX_DIFF_09_2 MAX_DIFF_11_3 MAX_DIFF_12_3 MAX_DIFF_13_4 MAX_DIFF_15_2 (1).

COUNT PAIR_PROGRAMMING_PRO=MAX_DIFF_02_4 MAX_DIFF_04_4 MAX_DIFF_05_4 MAX_DIFF_06_4 MAX_DIFF_08_4 MAX_DIFF_09_4 MAX_DIFF_10_4 MAX_DIFF_11_4 MAX_DIFF_14_4 MAX_DIFF_15_4 (2).
COUNT PAIR_PROGRAMMING_AGAINST=MAX_DIFF_02_4 MAX_DIFF_04_4 MAX_DIFF_05_4 MAX_DIFF_06_4 MAX_DIFF_08_4 MAX_DIFF_09_4 MAX_DIFF_10_4 MAX_DIFF_11_4 MAX_DIFF_14_4 MAX_DIFF_15_4 (1).

COUNT HOMEWORK_PRO=MAX_DIFF_01_2 MAX_DIFF_02_2 MAX_DIFF_03_2 MAX_DIFF_05_1 MAX_DIFF_06_2 MAX_DIFF_08_1 MAX_DIFF_10_2 MAX_DIFF_12_1 MAX_DIFF_13_2 MAX_DIFF_15_1 (2).
COUNT HOMEWORK_AGAINST=MAX_DIFF_01_2 MAX_DIFF_02_2 MAX_DIFF_03_2 MAX_DIFF_05_1 MAX_DIFF_06_2 MAX_DIFF_08_1 MAX_DIFF_10_2 MAX_DIFF_12_1 MAX_DIFF_13_2 MAX_DIFF_15_1 (1).

COUNT WHITEBOARD_PRO=MAX_DIFF_01_4 MAX_DIFF_03_4 MAX_DIFF_04_3 MAX_DIFF_07_4 MAX_DIFF_08_3 MAX_DIFF_09_3 MAX_DIFF_10_3 MAX_DIFF_12_4 MAX_DIFF_14_3 MAX_DIFF_15_3 (2).
COUNT WHITEBOARD_AGAINST=MAX_DIFF_01_4 MAX_DIFF_03_4 MAX_DIFF_04_3 MAX_DIFF_07_4 MAX_DIFF_08_3 MAX_DIFF_09_3 MAX_DIFF_10_3 MAX_DIFF_12_4 MAX_DIFF_14_3 MAX_DIFF_15_3 (1).

* normalize results of MaxDiff - will be easier to compare with Experimental Bayesan results.
COMPUTE GITHUB_NORMALIZED=           (GITHUB_PRO            - GITHUB_AGAINST        + 10) / 20.
COMPUTE PAST_PROJECTS_NORMALIZED=    (PAST_PROJECTS_PRO     - PAST_PROJECTS_AGAINST + 10) / 20.
COMPUTE JOB_INTERVIEW_NORMALIZED=    (JOB_INTERVIEW_PRO     - JOB_INTERVIEW_AGAINST + 10) / 20.
COMPUTE PAIR_PROGRAMMING_NORMALIZED= (PAIR_PROGRAMMING_PRO  - PAST_PROJECTS_AGAINST + 10) / 20.
COMPUTE HOMEWORK_NORMALIZED=         (HOMEWORK_PRO          - HOMEWORK_AGAINST      + 10) / 20.
COMPUTE WHITEBOARD_NORMALIZED=       (WHITEBOARD_PRO        - WHITEBOARD_AGAINST    + 10) / 20.

* score for each choice. It is calculated as a difference between prefered against disregarded divided.
* by number of times each element was shown. Design was full, ortogonal, this is why every choice was.
* shown the same number of times.
COMPUTE GITHUB_TOTAL           = (GITHUB_PRO            - GITHUB_AGAINST)        / 10.
COMPUTE PAST_PROJECTS_TOTAL    = (PAST_PROJECTS_PRO     - PAST_PROJECTS_AGAINST) / 10.
COMPUTE JOB_INTERVIEW_TOTAL    = (JOB_INTERVIEW_PRO     - JOB_INTERVIEW_AGAINST) / 10.
COMPUTE PAIR_PROGRAMMING_TOTAL = (PAIR_PROGRAMMING_PRO  - PAST_PROJECTS_AGAINST) / 10.
COMPUTE HOMEWORK_TOTAL         = (HOMEWORK_PRO          - HOMEWORK_AGAINST)      / 10.
COMPUTE WHITEBOARD_TOTAL       = (WHITEBOARD_PRO        - WHITEBOARD_AGAINST)    / 10.
execute.

VARIABLE LABELS GITHUB_NORMALIZED           'Github - normalized'.
VARIABLE LABELS PAST_PROJECTS_NORMALIZED    'Past projects - normalized'.
VARIABLE LABELS JOB_INTERVIEW_NORMALIZED    'Job interview - normalized'.
VARIABLE LABELS PAIR_PROGRAMMING_NORMALIZED 'Pair programming - normalized'.
VARIABLE LABELS HOMEWORK_NORMALIZED         'Homework - normalized'.
VARIABLE LABELS WHITEBOARD_NORMALIZED       'Whiteboard - normalized'.
execute.

* safety check. If it turns out that PREFERENCES_SUM (number of answers) is not equal to `30` - that is: `15` pro + `15` against - it means that respondend didn't finished the survey.
* these people will not be taken into the final set of people who are analysed.
COMPUTE PREFERENCES_SUM=GITHUB_PRO+GITHUB_AGAINST+PAST_PROJECTS_PRO+PAST_PROJECTS_AGAINST+JOB_INTERVIEW_PRO+JOB_INTERVIEW_AGAINST+PAIR_PROGRAMMING_PRO+PAIR_PROGRAMMING_AGAINST+HOMEWORK_PRO+HOMEWORK_AGAINST+WHITEBOARD_PRO+WHITEBOARD_AGAINST.
execute.

VARIABLE LABELS GITHUB_PRO               'discuss Github projects - pro'.
VARIABLE LABELS GITHUB_AGAINST           'discuss Github projects - against'.
VARIABLE LABELS PAST_PROJECTS_PRO        'discuss your past projects - pro'.
VARIABLE LABELS PAST_PROJECTS_AGAINST    'discuss your past projects - against'.
VARIABLE LABELS JOB_INTERVIEW_PRO        'job interview - pro'.
VARIABLE LABELS JOB_INTERVIEW_AGAINST    'job interview - against'.
VARIABLE LABELS PAIR_PROGRAMMING_PRO     'pair programming - pro'.
VARIABLE LABELS PAIR_PROGRAMMING_AGAINST 'pair programming - against'.
VARIABLE LABELS HOMEWORK_PRO             'solve a problem at home - pro'.
VARIABLE LABELS HOMEWORK_AGAINST         'solve a problem at home - against'.
VARIABLE LABELS WHITEBOARD_PRO           'whiteboard coding - pro'.
VARIABLE LABELS WHITEBOARD_AGAINST       'whiteboard coding - against'.
execute.

* for main analysis we are removing people who didn't get to the end of survey.
* in case we want to analyse these cases, we can always reproduce data from the raw data.
SELECT IF (PREFERENCES_SUM = 30).
EXECUTE.

save outfile='002-BigFiveHR-ready.sav'.

* These variables will be used in Experimental Bayes analysis.
* I am preparing data such way it fits the procedure described here:
* https://cran.r-project.org/web/packages/bwsTools/vignettes/tidying_data.html

COMPUTE q1_1=MAX_DIFF_01_1.
COMPUTE q1_2=MAX_DIFF_01_2.
COMPUTE q1_3=MAX_DIFF_01_3.
COMPUTE q1_4=MAX_DIFF_01_4.
COMPUTE q2_1=MAX_DIFF_02_1.
COMPUTE q2_2=MAX_DIFF_02_2.
COMPUTE q2_3=MAX_DIFF_02_3.
COMPUTE q2_4=MAX_DIFF_02_4.
COMPUTE q3_1=MAX_DIFF_03_1.
COMPUTE q3_2=MAX_DIFF_03_2.
COMPUTE q3_3=MAX_DIFF_03_3.
COMPUTE q3_4=MAX_DIFF_03_4.
COMPUTE q4_1=MAX_DIFF_04_1.
COMPUTE q4_2=MAX_DIFF_04_2.
COMPUTE q4_3=MAX_DIFF_04_3.
COMPUTE q4_4=MAX_DIFF_04_4.
COMPUTE q5_1=MAX_DIFF_05_1.
COMPUTE q5_2=MAX_DIFF_05_2.
COMPUTE q5_3=MAX_DIFF_05_3.
COMPUTE q5_4=MAX_DIFF_05_4.
COMPUTE q6_1=MAX_DIFF_06_1.
COMPUTE q6_2=MAX_DIFF_06_2.
COMPUTE q6_3=MAX_DIFF_06_3.
COMPUTE q6_4=MAX_DIFF_06_4.
COMPUTE q7_1=MAX_DIFF_07_1.
COMPUTE q7_2=MAX_DIFF_07_2.
COMPUTE q7_3=MAX_DIFF_07_3.
COMPUTE q7_4=MAX_DIFF_07_4.
COMPUTE q8_1=MAX_DIFF_08_1.
COMPUTE q8_2=MAX_DIFF_08_2.
COMPUTE q8_3=MAX_DIFF_08_3.
COMPUTE q8_4=MAX_DIFF_08_4.
COMPUTE q9_1=MAX_DIFF_09_1.
COMPUTE q9_2=MAX_DIFF_09_2.
COMPUTE q9_3=MAX_DIFF_09_3.
COMPUTE q9_4=MAX_DIFF_09_4.
COMPUTE q10_1=MAX_DIFF_10_1.
COMPUTE q10_2=MAX_DIFF_10_2.
COMPUTE q10_3=MAX_DIFF_10_3.
COMPUTE q10_4=MAX_DIFF_10_4.
COMPUTE q11_1=MAX_DIFF_11_1.
COMPUTE q11_2=MAX_DIFF_11_2.
COMPUTE q11_3=MAX_DIFF_11_3.
COMPUTE q11_4=MAX_DIFF_11_4.
COMPUTE q12_1=MAX_DIFF_12_1.
COMPUTE q12_2=MAX_DIFF_12_2.
COMPUTE q12_3=MAX_DIFF_12_3.
COMPUTE q12_4=MAX_DIFF_12_4.
COMPUTE q13_1=MAX_DIFF_13_1.
COMPUTE q13_2=MAX_DIFF_13_2.
COMPUTE q13_3=MAX_DIFF_13_3.
COMPUTE q13_4=MAX_DIFF_13_4.
COMPUTE q14_1=MAX_DIFF_14_1.
COMPUTE q14_2=MAX_DIFF_14_2.
COMPUTE q14_3=MAX_DIFF_14_3.
COMPUTE q14_4=MAX_DIFF_14_4.
COMPUTE q15_1=MAX_DIFF_15_1.
COMPUTE q15_2=MAX_DIFF_15_2.
COMPUTE q15_3=MAX_DIFF_15_3.
COMPUTE q15_4=MAX_DIFF_15_4.
EXECUTE.

variable labels q1_1  "discuss Github projects".
variable labels q1_2  "solve a problem at home".
variable labels q1_3  "job interview".
variable labels q1_4  "whiteboard coding".
variable labels q2_1  "discuss Github projects".
variable labels q2_2  "solve a problem at home".
variable labels q2_3  "discuss your past projects".
variable labels q2_4  "pair programming with interviewer".
variable labels q3_1  "discuss Github projects".
variable labels q3_2  "solve a problem at home".
variable labels q3_3  "discuss your past projects".
variable labels q3_4  "whiteboard coding".
variable labels q4_1  "discuss Github projects".
variable labels q4_2  "job interview".
variable labels q4_3  "whiteboard coding".
variable labels q4_4  "pair programming with interviewer".
variable labels q5_1  "solve a problem at home".
variable labels q5_2  "discuss your past projects".
variable labels q5_3  "job interview".
variable labels q5_4  "pair programming with interviewer".
variable labels q6_1  "discuss Github projects".
variable labels q6_2  "solve a problem at home".
variable labels q6_3  "job interview".
variable labels q6_4  "pair programming with interviewer".
variable labels q7_1  "discuss Github projects".
variable labels q7_2  "discuss your past projects".
variable labels q7_3  "job interview".
variable labels q7_4  "whiteboard coding".
variable labels q8_1  "solve a problem at home".
variable labels q8_2  "discuss your past projects".
variable labels q8_3  "whiteboard coding".
variable labels q8_4  "pair programming with interviewer".
variable labels q9_1  "discuss your past projects".
variable labels q9_2  "job interview".
variable labels q9_3  "whiteboard coding".
variable labels q9_4  "pair programming with interviewer".
variable labels q10_1 "discuss Github projects".
variable labels q10_2 "solve a problem at home".
variable labels q10_3 "whiteboard coding".
variable labels q10_4 "pair programming with interviewer".
variable labels q11_1 "discuss Github projects".
variable labels q11_2 "discuss your past projects".
variable labels q11_3 "job interview".
variable labels q11_4 "pair programming with interviewer".
variable labels q12_1 "solve a problem at home".
variable labels q12_2 "discuss your past projects".
variable labels q12_3 "job interview".
variable labels q12_4 "whiteboard coding".
variable labels q13_1 "discuss Github projects".
variable labels q13_2 "solve a problem at home".
variable labels q13_3 "discuss your past projects".
variable labels q13_4 "job interview".
variable labels q14_1 "discuss Github projects".
variable labels q14_2 "discuss your past projects".
variable labels q14_3 "whiteboard coding".
variable labels q14_4 "pair programming with interviewer".
variable labels q15_1 "solve a problem at home".
variable labels q15_2 "job interview".
variable labels q15_3 "whiteboard coding".
variable labels q15_4 "pair programming with interviewer".
execute.

* save file for `R` based analysis.
* From here, we are movig to `R`, where Experimental Bayes will be applied to MaxDiff results.
SAVE TRANSLATE /TYPE=CSV
  /ENCODING='UTF8'
  /FIELDNAMES
  /CELLS=VALUES
  /KEEP=pid q1_1 to q15_4
  /REPLACE
  /OUTFILE='002-BigFiveHR-maxdiff.csv'.


