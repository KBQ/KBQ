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

The app is hosted on the website: http://datascience.polito.it/shiny/KBQ/

Code can be found on github: https://github.com/rifat963/KBQ-Tool

To run this app locally on your machine, download R or RStudio and run the following commands once to set up the environment:

```
install.packages(c("ggplot2", "dplyr", "plyr", 
"dtplyr", "plotly","SPARQL",
"rmarkdown","DT","readr","data.table",
"shinyjs","shiny","shinydashboard",
"shinythemes","stringr","jsonlite","gtools",
"htmltools","httr","shinyTime","shinyBS"))

```
You may now run the shiny app with just one command in R:

```
shiny::runGitHub("KBQ-Tool", "rifat963")
```

### Collect

KBQ based on class based analysis for any KBs using SPARQLs. Data extraction is performed based on specific set of sparql queries to extract summary statistics. 

You may use this app by

1. Exploring the Indexed KBs.
2. Collect class specific Snapshots data by using scheduler or save class summary data manually.
3. All the input datasets saved in a .CSV *comma-separated-value* file.
4. File must have a header row. Each CSV contains following headers.

| CSV Header    | Description |
| ------------- | ------------- |
| p             | Property name for a specific class  |
| freq          | Count of a property |
| Release       | Release information in date |
| className     | Name of the selected class for quality profiling |
| Graph         | Name of the graph |
| count         | Entity count of the class |


For periodic data extraction we have created a set of REST API. We use this API to create scheduler in the hosting server based on the selected class. Details API documentation presented in the github: https://github.com/rifat963/KbDataObservetory


#### Analyze

Purpose of KBQ is to automatic analysis of quality profiling of any KB using sparql endpoint. Profiling is based on the four quality characteristics. Following are the steps used to performed quality profiling.

- For indexed KBs: Select a class by using **ClassName**. Then start quality profiling simple click ** Quality Profiling**. Results can be visualize after computing data finished.

- For sanapshots dataset: Select a scheduler from the lisit and press **Visualize**. 

### Visualize

Visualization is performed using two seperate stage.

- Overview of quality profiling results: In the visualize section an summary of the quality profiling results present together with a link to details quality report. 

- Quality profiling specific visualization: Based on the quality characteriscs measure results a set of indicators is used to notify the end users for quality profiling results.


### Validate

- List of quality properties with completeness issues presented in the validation module. 

- For validation user need to select a properties followed by extract instances of that property.

- By selecting each instance user can explore subject and sources. If the instance is present in the KB however it is missing in the sources there is a completeness issue present for the instance.

#### Licence
These scripts are free software; you can redistribute it and/or modify it under the terms of the GNU General Public License published by
the Free Software Foundation, either version 3 of the License, or (at your option) any later version. See the file Documentation/GPL3 in the original distribution for details. There is ABSOLUTELY NO warranty. 
<a name="rdata"></a> 

<a name="vis"></a> 

<a name="pcaplots"></a>


<a name="analysisplots"></a>



 


 



