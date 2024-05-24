* Encoding: UTF-8.
cd '@PROJECT_LOCATION@/data'.
show dir.

get file='005-BigFiveHR-analysis.sav'.

DATASET NAME big5hr.
DATASET ACTIVATE big5hr.

* demographics (gender). 
* section: Demographics of the Respondents.
RECODE IMP_02 (SYSMIS = 4).
FREQUENCIES VARIABLES=IMP_02
  /ORDER=ANALYSIS.

* IT experience.
* section: Demographics of the Respondents.
FREQUENCIES VARIABLES=IMP_04
  /ORDER=ANALYSIS.

* IT area experience.
* section: Demographics of the Respondents.
FREQUENCIES VARIABLES=IMP_04_01
  /ORDER=ANALYSIS.

* Team size.
* section: Demographics of the Respondents.
FREQUENCIES VARIABLES=IMP_05
  /ORDER=ANALYSIS.

* Test whether distribution of extraversion, neuroticism, agreeableness, conscientiousness, openness is normal.
* Shapiro-Wilk and Kolmogorov-Smirnov.
* section: Analysis of the BFI Levels Distribution.
EXAMINE VARIABLES=BFI_E BFI_A BFI_C BFI_N BFI_O
  /PLOT BOXPLOT STEMLEAF HISTOGRAM NPPLOT
  /COMPARE GROUPS
  /STATISTICS NONE
  /CINTERVAL 95
  /MISSING PAIRWISE
  /NOTOTAL.

* -------------------------------------------------------.
* Extraversion.
* -------------------------------------------------------.
* Note! This is a part of the STUDY! Test of Extraversion against recruitmen process preferences.
* section: Verification of the Hypotheses.
T-TEST GROUPS=BFI_E_2nd(1 2)
  /MISSING=ANALYSIS
  /VARIABLES=GITHUB_BAYES PAST_PROJECTS_BAYES JOB_INTERVIEW_BAYES PAIR_PROGRAMMING_BAYES HOMEWORK_BAYES WHITEBOARD_BAYES
  /ES DISPLAY(TRUE)
  /CRITERIA=CI(.95).
* -------------------------------------------------------.

* Note! This is not a part of the study. This analysis was run to check whether there are differences between BAYES results and normalized values of choices.
* It was possible to test against the normalized values of choices in MaxDiff due to the fact that we were dealing with fully ortogonal MaxDiff plan.
T-TEST GROUPS=BFI_E_2nd(1 2)
  /MISSING=ANALYSIS
  /VARIABLES=GITHUB_NORMALIZED PAST_PROJECTS_NORMALIZED JOB_INTERVIEW_NORMALIZED PAIR_PROGRAMMING_NORMALIZED HOMEWORK_NORMALIZED WHITEBOARD_NORMALIZED
  /ES DISPLAY(TRUE)
  /CRITERIA=CI(.95).

* Note! This is not a part of the study.
temporary.
select if (BFI_E_2nd eq 1) or (BFI_E_2nd eq 2).
NPTESTS 
  /INDEPENDENT TEST (GITHUB_BAYES PAST_PROJECTS_BAYES JOB_INTERVIEW_BAYES PAIR_PROGRAMMING_BAYES HOMEWORK_BAYES WHITEBOARD_BAYES) GROUP (BFI_E_2nd) 
  /MISSING SCOPE=ANALYSIS USERMISSING=EXCLUDE
  /CRITERIA ALPHA=0.05  CILEVEL=95.

* -------------------------------------------------------.
* Openness to experience.
* -------------------------------------------------------.
* Note! This is a part of the STUDY! Test of Openness against recruitmen process preferences. We use Mann-Whitney here - openness is not normally distributed.
* section: Verification of the Hypotheses.
temporary.
select if (BFI_O_2nd eq 1) or (BFI_O_2nd eq 2).
NPTESTS 
  /INDEPENDENT TEST (GITHUB_BAYES PAST_PROJECTS_BAYES JOB_INTERVIEW_BAYES PAIR_PROGRAMMING_BAYES HOMEWORK_BAYES WHITEBOARD_BAYES) GROUP (BFI_O_2nd) 
  /MISSING SCOPE=ANALYSIS USERMISSING=EXCLUDE
  /CRITERIA ALPHA=0.05  CILEVEL=95.
* -------------------------------------------------------.

* Note! This is not a part of the study.
T-TEST GROUPS=BFI_O_2nd(1 2)
  /MISSING=ANALYSIS
  /VARIABLES=GITHUB_BAYES PAST_PROJECTS_BAYES JOB_INTERVIEW_BAYES PAIR_PROGRAMMING_BAYES HOMEWORK_BAYES WHITEBOARD_BAYES
  /ES DISPLAY(TRUE)
  /CRITERIA=CI(.95).

* Note! This is not a part of the study.
T-TEST GROUPS=BFI_O_2nd(1 2)
  /MISSING=ANALYSIS
  /VARIABLES=GITHUB_NORMALIZED PAST_PROJECTS_NORMALIZED JOB_INTERVIEW_NORMALIZED PAIR_PROGRAMMING_NORMALIZED HOMEWORK_NORMALIZED WHITEBOARD_NORMALIZED
  /ES DISPLAY(TRUE)
  /CRITERIA=CI(.95).

* -------------------------------------------------------.
* Neuroticism.
* -------------------------------------------------------.
* Note! This is a part of the STUDY! Test of Neuroticism against recruitmen process preferences.
* section: Agreeableness, Conscientiousness, Neuroticism and Recruitment Process Preferences.
T-TEST GROUPS=BFI_N_2nd(1 2)
  /MISSING=ANALYSIS
  /VARIABLES=GITHUB_BAYES PAST_PROJECTS_BAYES JOB_INTERVIEW_BAYES PAIR_PROGRAMMING_BAYES HOMEWORK_BAYES WHITEBOARD_BAYES
  /ES DISPLAY(TRUE)
  /CRITERIA=CI(.95).
* -------------------------------------------------------.

* Note! This is not a part of the study. This analysis was run to check whether there are differences between BAYES results and normalized values of choices.
* It was possible to test against the normalized values of choices in MaxDiff due to the fact that we were dealing with fully ortogonal MaxDiff plan.
T-TEST GROUPS=BFI_N_2nd(1 2)
  /MISSING=ANALYSIS
  /VARIABLES=GITHUB_NORMALIZED PAST_PROJECTS_NORMALIZED JOB_INTERVIEW_NORMALIZED PAIR_PROGRAMMING_NORMALIZED HOMEWORK_NORMALIZED WHITEBOARD_NORMALIZED
  /ES DISPLAY(TRUE)
  /CRITERIA=CI(.95).

* Note! This is not a part of the study.
temporary.
select if (BFI_N_2nd eq 1) or (BFI_N_2nd eq 2).
NPTESTS 
  /INDEPENDENT TEST (GITHUB_BAYES PAST_PROJECTS_BAYES JOB_INTERVIEW_BAYES PAIR_PROGRAMMING_BAYES HOMEWORK_BAYES WHITEBOARD_BAYES) GROUP (BFI_N_2nd) 
  /MISSING SCOPE=ANALYSIS USERMISSING=EXCLUDE
  /CRITERIA ALPHA=0.05  CILEVEL=95.

* -------------------------------------------------------.
* Agreeableness.
* -------------------------------------------------------.
* Note! This is a part of the STUDY! Test of Agreeableness against recruitmen process preferences.
* section: Agreeableness, Conscientiousness, Neuroticism and Recruitment Process Preferences.
T-TEST GROUPS=BFI_A_2nd(1 2)
  /MISSING=ANALYSIS
  /VARIABLES=GITHUB_BAYES PAST_PROJECTS_BAYES JOB_INTERVIEW_BAYES PAIR_PROGRAMMING_BAYES HOMEWORK_BAYES WHITEBOARD_BAYES
  /ES DISPLAY(TRUE)
  /CRITERIA=CI(.95).
* -------------------------------------------------------.

* Note! This is not a part of the study. This analysis was run to check whether there are differences between BAYES results and normalized values of choices.
* It was possible to test against the normalized values of choices in MaxDiff due to the fact that we were dealing with fully ortogonal MaxDiff plan.
T-TEST GROUPS=BFI_A_2nd(1 2)
  /MISSING=ANALYSIS
  /VARIABLES=GITHUB_NORMALIZED PAST_PROJECTS_NORMALIZED JOB_INTERVIEW_NORMALIZED PAIR_PROGRAMMING_NORMALIZED HOMEWORK_NORMALIZED WHITEBOARD_NORMALIZED
  /ES DISPLAY(TRUE)
  /CRITERIA=CI(.95).

* Note! This is not a part of the study.
temporary.
select if (BFI_A_2nd eq 1) or (BFI_A_2nd eq 2).
NPTESTS 
  /INDEPENDENT TEST (GITHUB_BAYES PAST_PROJECTS_BAYES JOB_INTERVIEW_BAYES PAIR_PROGRAMMING_BAYES HOMEWORK_BAYES WHITEBOARD_BAYES) GROUP (BFI_A_2nd) 
  /MISSING SCOPE=ANALYSIS USERMISSING=EXCLUDE
  /CRITERIA ALPHA=0.05  CILEVEL=95.

* -------------------------------------------------------.
* Conscientiousness.
* -------------------------------------------------------.
* Note! This is a part of the STUDY! Test of Conscientiousness against recruitmen process preferences.
* section: Agreeableness, Conscientiousness, Neuroticism and Recruitment Process Preferences.
T-TEST GROUPS=BFI_C_2nd(1 2)
  /MISSING=ANALYSIS
  /VARIABLES=GITHUB_BAYES PAST_PROJECTS_BAYES JOB_INTERVIEW_BAYES PAIR_PROGRAMMING_BAYES HOMEWORK_BAYES WHITEBOARD_BAYES
  /ES DISPLAY(TRUE)
  /CRITERIA=CI(.95).
* -------------------------------------------------------.

* Note! This is not a part of the study. This analysis was run to check whether there are differences between BAYES results and normalized values of choices.
* It was possible to test against the normalized values of choices in MaxDiff due to the fact that we were dealing with fully ortogonal MaxDiff plan.
T-TEST GROUPS=BFI_C_2nd(1 2)
  /MISSING=ANALYSIS
  /VARIABLES=GITHUB_NORMALIZED PAST_PROJECTS_NORMALIZED JOB_INTERVIEW_NORMALIZED PAIR_PROGRAMMING_NORMALIZED HOMEWORK_NORMALIZED WHITEBOARD_NORMALIZED
  /ES DISPLAY(TRUE)
  /CRITERIA=CI(.95).

* Note! This is not a part of the study.
temporary.
select if (BFI_C_2nd eq 1) or (BFI_C_2nd eq 2).
NPTESTS 
  /INDEPENDENT TEST (GITHUB_BAYES PAST_PROJECTS_BAYES JOB_INTERVIEW_BAYES PAIR_PROGRAMMING_BAYES HOMEWORK_BAYES WHITEBOARD_BAYES) GROUP (BFI_C_2nd) 
  /MISSING SCOPE=ANALYSIS USERMISSING=EXCLUDE
  /CRITERIA ALPHA=0.05  CILEVEL=95.

* -------------------------------------------------------.
* Correlation between BFI and Recruitment Preferences.
* -------------------------------------------------------.
* Note! This is a part of the STUDY!
* section: Correlation between levels of BFI factors and Recruitment Process Preferences.
CORRELATIONS
/VARIABLES=BFI_E BFI_O BFI_N BFI_A BFI_C GITHUB_BAYES PAST_PROJECTS_BAYES JOB_INTERVIEW_BAYES PAIR_PROGRAMMING_BAYES HOMEWORK_BAYES WHITEBOARD_BAYES
/PRINT=TWOTAIL NOSIG
/MISSING=PAIRWISE.

CORRELATIONS
/VARIABLES=BFI_E BFI_O GITHUB_BAYES PAST_PROJECTS_BAYES JOB_INTERVIEW_BAYES PAIR_PROGRAMMING_BAYES HOMEWORK_BAYES WHITEBOARD_BAYES
/PRINT=TWOTAIL NOSIG
/MISSING=PAIRWISE.





