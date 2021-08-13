# README!

Die hier bereitgestellten Datensatz- und Syntax-Dateien können genutzt werden, um die von Diana Rausch im Rahmen ihrer Dissertation "Einflussfaktoren auf die sexuelle Zufriedenheit von Frauen in fester Partnerschaft" im Jahr 2021 veröffentlichten Forschungsergebnisse nachzuvollziehen.

Mithilfe eines umfassenden Fragebogens wurden zahlreiche Einstellungen und Verhaltensweisen erhoben, die in Zusammenhang mit Sexualität und Partnerschaft stehen. Daher stellen die Daten auch eine gute Grundlage für zukünftige Forschungsprojekte zum Thema Sexualität und Partnerschaft dar.

Die Daten wurden durch eine Umfrage vom 22.04.2015 bis zum 17.07.2015 über die Online-Plattform Unipark erhoben. Die Verbreitung erfolgte durch Social Media Posts auf Facebook und Twitter mit Bitte um weiteres Teilen des Umfragelinks, durch den Versand an Mailinglisten verschiedener Fachschaften und durch Aushänge an der Johannes Gutenberg-Universität Mainz. Insgesamt wurde die Umfrage 4 483 Mal aufgerufen und von 2 768 Teilnehmenden vollständig bearbeitet.

Als erster Zugang zum Datensatz eignet sich die Datei mit dem vollständigen Fragebogen (Fragebogen zu Sexualität und Partnerschaft.pdf), in der hinter jedem Item des Fragebogens die zugehörige Variable im aufbereiteten Datensatz vermerkt ist.

Im Ordner "data.zip" steht der Datensatz unbearbeitet (_raw) und mit einer bereits durchgeführten grundlegenden Aufbereitung (_clean) im Stata- (.dta) und im SPSS-Format (.sav) bereit. Die aufbereitete Version unterscheidet sich vom unbearbeiteten Datensatz insbesondere darin, dass Variablen, die aufgrund verschiedener Geschlechterformulierungen durch separate Items erhoben worden sind, zusammengefasst wurden und fehlende Angaben im Fragebogen einer einheitlichen Missing-Codierung zugeordnet wurden. Die gesamte Aufbereitung kann mithilfe des Stata-Skripts und der zugehörigen Kommentare in der Datei "00_BASIC_RECODING.do" nachvollzogen werden.

Die Syntax-Dateien im Ordner "do-files" können genutzt werden, um alle Ergebnisse der zuvor erwähnten Dissertation auf Basis des unbearbeiteten Datensatzes in Stata nachzuvollziehen (do-Files 00−13 und A1−A5). Dafür ist es am einfachsten, die im Hauptverzeichnis befindliche Syntax mit dem Namen "!!_MASTER_CODE.do" in Stata auszuführen, durch die alle do-Files nacheinander ausgeführt werden.

Durch die Syntax in der Datei "B1_ANHANG_WEITEREVARIABLEN.do" wurden einige im Fragebogen erhobenen Items in Variablen zusammengefasst, die nicht Teil des Dissertationsprojektes waren, aber interessante Ansatzpunkte für weitere Forschungsarbeiten darstellen.

> Für Rückfragen stehe ich gerne zur Verfügung. 
> Ich wünsche euch viel Spaß mit dem Datensatz und freue mich auf spannende Ergebnisse!

## Verwendung des Datensatzes in Stata
* Download des gesamten Github-Projekts als zip-Datei und entpacken der heruntergeladenen Datei im gewünschten lokalen Ordner
* Entpacken der im Projekt enthaltenen data.zip-Datei im gleichen Ordner, sodass die gepackten Dateien in einem Unterordner namens "data" vorliegen
* Die Datei "!!_MASTER_CODE.do" öffnen und die angegebenen Pfade anpassen, sodass sie mit dem lokal erstellten Ordner für die Projektdateien übereinstimmen
* Ausführen der do-Files mit Stata. Dafür kann die "!!_MASTER_CODE.do"-Datei genutzt werden, die alle do-Files aus dem Unterordner "do-files" in der richtigen Reihenfolge ausführt.
* Alternativ können die do-Files im Unterordner "do-files" auch einzeln ausgeführt werden. Die do-Files bauen jedoch aufeinander auf und die Ausführung der do-Files 00 bis 02 ist für die Ausführung der weiteren do-Files erforderlich.

#### In Veröffentlichungen auf Basis der Daten ist dieser Datensatz wie folgt zu zitieren:

Rausch, Diana. (2021). *Dataset for Research about Sexuality and Relationships*. Abgerufen von https://github.com/diana-rausch/ResearchDataSexualityRelationship


## ENGLISH


The provided dataset and syntax files can be used to replicate the research results published 2021 in the PhD thesis of Diana Rausch titled "Predictors of Sexual Satisfaction in Women in Permanent Relationships".

Numerous attitudes and behavioral characteristics related to sexuality and relationship were measured with a comprehensive questionnaire. Therefore, the data are a great foundation for future research projects about sexuality and relationship topics.

The data were collected in 2015 with an online survey administered via the platform Unipark (April 4th - July 15th, 2015). The survey was distributed through social media posts, emails to different faculties and public postings on campus at the Johannes Gutenberg-University Mainz. Of the 4 483 people, who started the survey, 2 768 completed the entire questionnaire.

As a starting point to work with the data the file describing the complete questionnaire can be useful (Fragebogen zu Sexualität und Partnerschaft.pdf). It contains the name of each dataset variable adjacent to the respect questionnaire item.

In the zip archive "data.zip" the dataset is available unmodified (_raw) and cleaned (_clean) both in Stata (.dta) and in SPSS (.sav) format. The main difference of the clean version is that variables which belonged together but were separate in the survey platform because of gender specific wording have already been summarized. Furthermore, missing values have been recoded to be correctly recognized by Stata and custom responses to specific items have been sorted to the standardized value options if possible. The entire cleanup process can be reviewed and applied to the unmodified dataset with the Stata syntax file "00_BASIC_RECODING.do".

The other syntax files (do-Files 00−13 and A1−A5) in the folder "do-files" can be used to replicate all results of the PhD thesis mentioned above based on the unmodified version of the Stata dataset. The easiest way to do this is to open and run the syntax file "!!_MASTER_CODE.do" which executes all other files in the correct order and can be found in the root directory of the project.

The syntax in file "B1_ANHANG_WEITEREVARIABLEN.do" adds further variables to the dataset which were not used in the PhD thesis but could be interesting for future research projects.

> Please reach out to me in case of questions or issues around these files!
> I hope you enjoy working with the dataset and am excited to see your interesting research results!

## How to use the dataset in Stata
* Download the complete Github project and unzip to the desired local folder.
* Unzip the data.zip file contained in the project in the same folder resulting in a folder called "data", which contains the individual dataset files. 
* Open the file "!!_MASTER_CODE.do" and adjust the path settings defined at the beginning to align them with the local folder used for the project.
* Run the do-files with Stata. The file "!!_MASTER_CODE.do" can be used to run all do-files located in the folder "do-files" in the right order.
* You can also run files in the "do-files" folder separately but be aware that the do-files 00 to 02 need to be run as a preparation for any following do-files.

#### Publications based on this data must cite this project in the following way:

Rausch, Diana. (2021). *Dataset for Research about Sexuality and Relationships*. Retrieved from https://github.com/diana-rausch/ResearchDataSexualityRelationship
