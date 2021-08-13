/*
MASTER DO-FILE

Diese Datei führt alle DO-Files aus und erfordert die Nutzung von Stata (ab Version 14) mit der raw-Version des Datensatzes.
*/

//Festlegen der Pfade, bspw. "C:\\Ordner\Ordner\...\do-files\"

global doFileDirectory = "PFAD-ZUM-PROJEKTVERZEICHNIS\do-files\"       // Do-File-Verzeichnis
global dataDirectory = "PFAD-ZUM-PROJEKTVERZEICHNIS\data\"             // Datensatz-Verzeichnis
global logDirectory = "PFAD-ZUM-PROJEKTVERZEICHNIS\log\"               // Log-Datei-Verzeichnis
global graphDirectory = "PFAD-ZUM-PROJEKTVERZEICHNIS\graph\"           // Grafik-Output-Verzeichnis

//Festlegen der genutzten (raw) Datensatz-Datei
global dataset = "rausch-2021_sexat_data_project_raw_20150718.dta"

//Öffnen der Datensatz-Datei
cd "${dataDirectory}"
use "${dataset}",clear

//Ausführen der DO-Files
cd "${doFileDirectory}" 

do 00_BASIC_RECODING
do 01_STICHPROBE_EINSCHRAENKEN
do 02_VARIABLEN_REVIEW_INDEXBILDUNG
do 03_ERHEBUNG_BESCHREIBUNG

do 04_SEM_FULL_FINAL
do 05_SEM_FULL_FINAL_KONTROLL
do 05_SEM_FULL_FINAL_KONTROLL_MLSB
do 06_SEM_GRUPPE_COUPLEDURATION
do 07_SEM_VARIANZ_VARIABLENGRUPPEN

do 08_MULTIKOLLINEARITAET_CHECK
do 09_MISSINGS_CHECK
do 10_SPLIT_HALF
do 11_GRAPH

do 12_MESSMODELL
do 13_BASELINE

do A1_STICHPROBE_BESCHREIBUNG
do A2_TTESTS_COUPLEDURATION

do A3_SEM_ALTERNATIV_MEAN_STATT_LAT
do A4_ALTERNATE_MODELS
do A5_COVARIANCE_MATRIX

do B1_ANHANG_WEITEREVARIABLEN
