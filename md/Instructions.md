---
output:
  html_document:
    theme: united
---

**KBQ is a tool that helps you to perfom quality analysis on any Knowledge Base(KB) using four quality characteristics that are computed using temporal analysis.**

- *Analysis* We use basic statistics (i.e. counts, and diffs) over extracted triples from various KB releases to measure quality characteristics. More specifically, we compute the frequency of predicate and the frequency of entities of a given resource type, and we compare the frequencies with the ones observed in previous releases.
- *Modules* It contains four main module: (i) Collect (ii) Analyze (iii) Visualize and (iv) Validate.
- [*Detail Quality characteristics*](http://softeng.polito.it/rifat/QualityCharacteristics.pdf)

## Instructions

The app is hosted on the website: http://130.192.85.247/shiny/KBQ/

Code can be found on github: https://github.com/KBQ/KBQ

To run this app locally on your machine, download R or RStudio and run the following commands once to set up the environment:

```
install.packages(c("ggplot2", "dplyr", "plyr", 
"dtplyr", "plotly","SPARQL","rmarkdown",
"DT","readr","data.table","shinyjs","shiny",
"shinydashboard","shinythemes","stringr",
"jsonlite","gtools","httr","htmltools",
"httr","shinyTime","shinyBS","RCurl","knitr"))

```
You may now run the shiny app with just one command in R:

```
shiny::runGitHub("KBQ/KBQ", "rifat963")
```

### Collect

KBQ based on class based analysis for any KBs using SPARQLs. Data extraction is performed based on specific set of sparql queries to extract summary statistics. 

You may use this app by

1. Exploring the Indexed KBs.
2. Collect class specific Snapshots data by using scheduler or save class summary data manually.
3. All the input datasets saved in a .CSV *comma-separated-value* file.
4. File must have a header row. Each CSV contains following headers.

----------------------
| CSV Header |  |
| --- | --- |
| p | Property name for a specific class  |
| freq | Instance Count of a property |
| Release | Release information in date |
| className | Name of the selected class for quality profiling |
| Graph | Name of the graph |
| count | Entity count of the class |
----------------------

For periodic data extraction we have created a set of REST API. We use this API to create scheduler in the hosting server based on the selected class. Details API documentation presented in the github: https://github.com/rifat963/KbDataObservetory

**Instructions for building scheduler**

- **Input** Input a KB SPARQL endpoint url. For exmaple we present DBpedia [SPARQL Endpoint](http://dbpedia.org/sparql).

- **Graph** Press button *Graph* to extract available grpahs present in the KB

- **Class Name** Press button *Class Name* to extract all available classes present in the KB. It is mendatory to select a Class Name for snapshots generation due to quality profiling is done based on selected class.

- **Create a New Scheduler** Input a schulder name and set a time for daily scheduling task. Press button *Create Scheduler* to start the schulder in the server. 

- **Save** Manually save snapshots data in a CSV file. 

- **Notification** Please view the notification before creating the schulder.


### Analyze

Purpose of KBQ is to automatic analysis of quality profiling of any KB using sparql endpoint. Profiling is based on the four quality characteristics. Following are the steps used to performed quality profiling.

- For indexed KBs: Select a class by using **ClassName**. Then start quality profiling simple click ** Quality Profiling**. Results can be visualize after computing data finished.

- For sanapshots dataset: Select a scheduler from the lisit and press **Visualize**. 

More details instruction:

**Instructions for indexed KBs**

- **Input** We present two KB DBpedia ES as Inded KB. Select a KB for Data Extraction.

- **Class Name** Press button *Class Name* to extract all available classes present in the selected KB. It is mendatory to select a Class Name  due to quality profiling is done based on selected class

- **Quality Measures Results** Details quality profiling results can be viewed through each quality measure names. 

- **Save** Save quality profiling results in a HTML file.

**Instructions for snapshots datasets**

- **Input** Select a scheduler name from the list or upload local save snapshots CSV for quality profiling. 

- **Class Name** Press button *Class Name* to extract all available classes present in the selected KB. It is mendatory to select a Class Name  due to quality profiling is done based on selected class

- **Quality Profile** Using scheduler press button *Quality Profile* for quality profiling results. Details quality profiling results can be viewed through each quality measure names. 

- **Save** Save quality profiling results in a HTML file.

### Visualize

Visualization is performed using two seperate stage.

- Overview of quality profiling results: In the visualize section an summary of the quality profiling results present together with a link to details quality report. 

- Quality profiling specific visualization: Based on the quality characteriscs measure results a set of indicators is used to notify the end users for quality profiling results.

**Instructions for Indexed KB**

- **Input** We present two KB DBpedia ES as Inded KB. Select a KB for Data Extraction.

- **Class Name** Press button *Class Name* to extract all available classes present in the selected KB. It is mendatory to select a Class Name to explore Indexed dataset.

- **Summary Statistics** Preview summary statistics presented in the table.  

**Instructions for Snapshots Datasets**

- **Input** Select a scheduler name from the list or upload local save snapshots CSV for quality profiling. 

- **Class Name** Press button *Class Name* to extract all available classes present in the selected KB. It is mendatory to select to explore schedule

### Validate

This module extracts, inspects and comment on instances with quality issues. An end user can extract properties with quality issue after performing quality profiling. It performs validation in four steps: 

**Incomplete properties:** list of properties with completeness quality issues for validation. 

**Instances:** quality profiling is done based on summary statistics. To detect the missing instances of a property, instance extraction component perform comparison between the list of instances of two version. 

**Inspections:** after the instance, extraction is done any user can select every instance for inspection and report. 

**Report:** an end user can report if the instance is true positive (the subject presents an issue, and an actual problem was detected) or false positive (the item presents a possible issue, but none actual problem is found), as well as an end user can comment on specific issues. Finally, an end user can save the validation report in a CSV file. Currently, validation module is only performed for DBpedia ES.


#### Licence
These scripts are free software; you can redistribute it and/or modify it under the terms of the GNU General Public License published by
the Free Software Foundation, either version 3 of the License, or (at your option) any later version. See the file Documentation/GPL3 in the original distribution for details. There is ABSOLUTELY NO warranty. 



 


 



