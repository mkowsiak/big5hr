* Encoding: UTF-8.
* Remove all unnecesary variables. This step should be done only in case we are working with an export from Qualtrics.
* Qualtrics generates number of technical variables that are not needed.
cd '@PROJECT_LOCATION@/data'.
show dir.

DEFINE !cleandata(infile=!tokens(1)
  /surveys=!tokens(1))

get file=!QUOTE(!CONCAT(!infile, ".sav")).

DELETE VARIABLES CONSENT_01, StartDate, EndDate, Status, IPAddress.
DELETE VARIABLES Progress, ResponseID.0, RecordedDate, RecipientLastName.
DELETE VARIABLES RecipientFirstName, RecipientEmail, ExternalReference.
DELETE VARIABLES LocationLatitude, LocationLongitude, DistributionChannel, UserLanguage.
DELETE VARIABLES Duration__in_seconds_, Finished.
EXECUTE.

compute survey_source=!surveys.
variable level survey_source(NOMINAL).
EXECUTE.

variable labels survey_source 'Survey Source'.
add value labels survey_source 
  1 'A-1' 
  2 'A-2' 
  3 'A-3' 
  4 'A-4' 
  5 'B-1' 
  6 'B-2' 
  7 'HN-1' 
  8 'HR-1' 
  9 'HR-2'.

* variables inside Qualtrics are sometimes very long, multi-line, etc.
* all variable labels are being processed here.
  
* Variable labels - imprint.
variable labels IMP_02 'Sex'.
variable labels IMP_03 'Mother language'.
variable labels IMP_03_01 'Other language'.
variable labels IMP_04 'Experience in IT'.
variable labels IMP_04_01 'Primary area of IT'.
variable labels IMP_05 'Team size'.

* Variable labels - BFI.
variable labels BFI_01 "I see myself as someone who is talkative".
variable labels BFI_02 "I see myself as someone who tends to find fault with others.".
variable labels BFI_03 "I see myself as someone who does things carefully and completely.".
variable labels BFI_04 "I see myself as someone who is depressed, blue.".
variable labels BFI_05 "I see myself as someone who is original, comes up with new ideas.".
variable labels BFI_06 "I see myself as someone who reserved  keeps thoughts and feelings to self.".
variable labels BFI_07 "I see myself as someone who is helpful and unselfish with others.".
variable labels BFI_08 "I see myself as someone who can be somewhat careless.".
variable labels BFI_09 "I see myself as someone who is relaxed, handles stress well.".
variable labels BFI_10 "I see myself as someone who is curious about many different things.".
variable labels BFI_11 "I see myself as someone who is full of energy.".
variable labels BFI_12 "I see myself as someone who starts quarrels with others.".
variable labels BFI_13 "I see myself as someone who is a reliable worker.".
variable labels BFI_14 "I see myself as someone who can be tense.".
variable labels BFI_15 "I see myself as someone who is clever, thinks a lot.".
variable labels BFI_16 "I see myself as someone who generates a lot of enthusiasm.".
variable labels BFI_17 "I see myself as someone who has a forgiving nature.".
variable labels BFI_18 "I see myself as someone who tends to be disorganized.".
variable labels BFI_19 "I see myself as someone who worries a lot.".
variable labels BFI_20 "I see myself as someone who has an active imagination.".
variable labels BFI_21 "I see myself as someone who tends to be quiet.".
variable labels BFI_22 "I see myself as someone who is generally trusting.".
variable labels BFI_23 "I see myself as someone who tends to be lazy.".
variable labels BFI_24 "I see myself as someone who doesn’t get easily upset, emotionally stable.".
variable labels BFI_25 "I see myself as someone who is creative and inventive.".
variable labels BFI_26 "I see myself as someone who takes charge, has an assertive personality.".
variable labels BFI_27 "I see myself as someone who can be cold and distant with others.".
variable labels BFI_28 "I see myself as someone who keeps working until things are done.".
variable labels BFI_29 "I see myself as someone who can be moody.".
variable labels BFI_30 "I see myself as someone who likes artistic and creative experiences.".
variable labels BFI_31 "I see myself as someone who is sometimes shy, inhibited.".
variable labels BFI_32 "I see myself as someone who is considerate and kind to almost everyone.".
variable labels BFI_33 "I see myself as someone who does things efficiently (quickly and correctly).".
variable labels BFI_34 "I see myself as someone who stays calm in tense situations.".
variable labels BFI_35 "I see myself as someone who likes work that is the same every time (routine).".
variable labels BFI_36 "I see myself as someone who is outgoing, sociable.".
variable labels BFI_37 "I see myself as someone who is sometimes rude to others.".
variable labels BFI_38 "I see myself as someone who makes plans and sticks to them.".
variable labels BFI_39 "I see myself as someone who nets nervous easily.".
variable labels BFI_40 "I see myself as someone who likes to think and play with ideas.".
variable labels BFI_41 "I see myself as someone who doesn’t like artistic things (plays, music).".
rename variables BFI_42_=BFI_42.
variable labels BFI_42 "I see myself as someone who likes to cooperate  goes along with others.".
rename variables BIF_43=BFI_43.
variable labels BFI_43 "I see myself as someone who is easily distracted  has trouble paying attention.".
variable labels BFI_44 "I see myself as someone who knows a lot about art, music, or books.".
variable labels BFI_45 "I see myself as someone who is the kind of person almost everyone likes.".
variable labels BFI_46 "I see myself as someone who people really enjoy spending time with.".

* Variable labels - MaxDiff.
variable labels MAX_DIFF_01_1 "discuss Github projects".
variable labels MAX_DIFF_01_2 "solve a problem at home".
variable labels MAX_DIFF_01_3 "job interview".
variable labels MAX_DIFF_01_4 "whiteboard coding".
variable labels MAX_DIFF_02_1 "discuss Github projects".
variable labels MAX_DIFF_02_2 "solve a problem at home".
variable labels MAX_DIFF_02_3 "discuss your past projects".
variable labels MAX_DIFF_02_4 "pair programming with interviewer".
variable labels MAX_DIFF_03_1 "discuss Github projects".
variable labels MAX_DIFF_03_2 "solve a problem at home".
variable labels MAX_DIFF_03_3 "discuss your past projects".
variable labels MAX_DIFF_03_4 "whiteboard coding".
variable labels MAX_DIFF_04_1 "discuss Github projects".
variable labels MAX_DIFF_04_2 "job interview".
variable labels MAX_DIFF_04_3 "whiteboard coding".
variable labels MAX_DIFF_04_4 "pair programming with interviewer".
variable labels MAX_DIFF_05_1 "solve a problem at home".
variable labels MAX_DIFF_05_2 "discuss your past projects".
variable labels MAX_DIFF_05_3 "job interview".
variable labels MAX_DIFF_05_4 "pair programming with interviewer".
variable labels MAX_DIFF_06_1 "discuss Github projects".
variable labels MAX_DIFF_06_2 "solve a problem at home".
variable labels MAX_DIFF_06_3 "job interview".
variable labels MAX_DIFF_06_4 "pair programming with interviewer".
variable labels MAX_DIFF_07_1 "discuss Github projects".
variable labels MAX_DIFF_07_2 "discuss your past projects".
variable labels MAX_DIFF_07_3 "job interview".
variable labels MAX_DIFF_07_4 "whiteboard coding".
variable labels MAX_DIFF_08_1 "solve a problem at home".
variable labels MAX_DIFF_08_2 "discuss your past projects".
variable labels MAX_DIFF_08_3 "whiteboard coding".
variable labels MAX_DIFF_08_4 "pair programming with interviewer".
variable labels MAX_DIFF_09_1 "discuss your past projects".
variable labels MAX_DIFF_09_2 "job interview".
variable labels MAX_DIFF_09_3 "whiteboard coding".
variable labels MAX_DIFF_09_4 "pair programming with interviewer".
variable labels MAX_DIFF_10_1 "discuss Github projects".
variable labels MAX_DIFF_10_2 "solve a problem at home".
variable labels MAX_DIFF_10_3 "whiteboard coding".
variable labels MAX_DIFF_10_4 "pair programming with interviewer".
variable labels MAX_DIFF_11_1 "discuss Github projects".
variable labels MAX_DIFF_11_2 "discuss your past projects".
variable labels MAX_DIFF_11_3 "job interview".
variable labels MAX_DIFF_11_4 "pair programming with interviewer".
variable labels MAX_DIFF_12_1 "solve a problem at home".
variable labels MAX_DIFF_12_2 "discuss your past projects".
variable labels MAX_DIFF_12_3 "job interview".
variable labels MAX_DIFF_12_4 "whiteboard coding".
variable labels MAX_DIFF_13_1 "discuss Github projects".
variable labels MAX_DIFF_13_2 "solve a problem at home".
variable labels MAX_DIFF_13_3 "discuss your past projects".
variable labels MAX_DIFF_13_4 "job interview".
variable labels MAX_DIFF_14_1 "discuss Github projects".
variable labels MAX_DIFF_14_2 "discuss your past projects".
variable labels MAX_DIFF_14_3 "whiteboard coding".
variable labels MAX_DIFF_14_4 "pair programming with interviewer".
variable labels MAX_DIFF_15_1 "solve a problem at home".
variable labels MAX_DIFF_15_2 "job interview".
variable labels MAX_DIFF_15_3 "whiteboard coding".
variable labels MAX_DIFF_15_4 "pair programming with interviewer".

save outfile=!QUOTE(!CONCAT(!CONCAT("001-",!infile),".sav")).
EXECUTE.

!ENDDEFINE.

!cleandata infile=BigFive_Corporation_A_1 surveys=1.
!cleandata infile=BigFive_Corporation_A_2 surveys=2.
!cleandata infile=BigFive_Corporation_A_3 surveys=3.
!cleandata infile=BigFive_Corporation_A_4 surveys=4.
!cleandata infile=BigFive_Corporation_B_1 surveys=5.
!cleandata infile=BigFive_Corporation_B_2 surveys=6.
!cleandata infile=BigFive_HackerNews_1 surveys=7.
!cleandata infile=BigFive_ProjectPage_1 surveys=8.
!cleandata infile=BigFive_ProjectPage_2 surveys=9.

add files file="001-BigFive_Corporation_A_1.sav"
    /file="001-BigFive_Corporation_A_2.sav"
    /file="001-BigFive_Corporation_A_3.sav"
    /file="001-BigFive_Corporation_A_4.sav"
    /file="001-BigFive_Corporation_B_1.sav"
    /file="001-BigFive_Corporation_B_2.sav"
    /file="001-BigFive_HackerNews_1.sav"
    /file="001-BigFive_ProjectPage_1.sav"
    /file="001-BigFive_ProjectPage_2.sav".

EXECUTE.

* rename ResponseId to pid and sort by pid - this will help us later on while merging with `R` output.
RENAME VARIABLES ResponseId = pid.
SORT CASES BY pid.
EXECUTE.

* remove all the broken cases (people who haven't started the BFI survey).
SELECT IF NOT (SYSMIS(BFI_01)).
EXECUTE.

* save file and prepare it for data analysis.
save outfile='001-BigFiveHR-raw.sav'.


