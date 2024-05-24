* Encoding: UTF-8.
* We want to load data from `R` and merge the data within SPSS.
* Read file: https://stackoverflow.com/questions/36380260/opening-a-csv-file-using-spss
* Combine results: https://stackoverflow.com/questions/43763480/combining-add-cases-and-add-variables-by-merging-files-in-spss .

cd '@PROJECT_LOCATION@/data/'.
show dir.

PRESERVE.
SET DECIMAL DOT.

GET DATA  /TYPE=TXT
  /FILE="@PROJECT_LOCATION@/data/003-MaxDiff-output.csv"
  /ENCODING='UTF8'
  /DELIMITERS=","
  /QUALIFIER='"'
  /ARRANGEMENT=DELIMITED
  /FIRSTCASE=2
  /DATATYPEMIN PERCENTAGE=95.0
  /VARIABLES=
  pid A50
  discussGithubprojects AUTO
  discussyourpastprojects AUTO
  jobinterview AUTO
  pairprogrammingwithinterviewer AUTO
  solveaproblemathome AUTO
  whiteboardcoding AUTO
  /MAP.
EXECUTE.

save outfile='004-BigFiveHR-csv-ready.sav'.

match files /file='002-BigFiveHR-ready.sav' /file='004-BigFiveHR-csv-ready.sav' /by pid.
execute.

save outfile='004-BigFiveHR-pre-analysis.sav'.
