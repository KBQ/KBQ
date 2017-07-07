---
output:
  html_document:
    theme: united
---

**KBQ is a tool that helps you to perfom quality analysis on any Knowledge Base(KB) using four quality characteristics that are computed using temporal analysis.**

- *Analysis* We use basic statistics (i.e. counts, and diffs) over extracted triples from various KB releases to measure quality characteristics. More specifically, we compute the frequency of predicate and the frequency of entities of a given resource type, and we compare the frequencies with the ones observed in previous releases.
- *Modules* It contains four main module: (i) Collect (ii) Analyze (iii) Visualize and (iv) Validate.
- [*Detail Quality characteristics*](http://softeng.polito.it/rifat/QualityCharacteristics.pdf)

# Instructions

The app is hosted on the website: https://dataquality.shinyapps.io/kbq-tool/

Code can be found on github: https://github.com/rifat963/KBQDashboard

To run this app locally on your machine, download R or RStudio and run the following commands once to set up the environment:

```
install.packages(c("ggplot2", "dplyr", "plyr", 
"dtplyr", "plotly","SPARQL",
"rmarkdown","DT","readr","data.table",
"shinyjs","shiny","shinydashboard",
"shinythemes","stringr","jsonlite","gtools","htmltools"))

```
You may now run the shiny app with just one command in R:

```
shiny::runGitHub("KBQDashboard", "rifat963")
```

<a name="inputdata"></a> 

## Input Data 

You may use this app by

1. Exploring the Indexed KBs.
2. Collect Snapshots data using scheduler or by

<a name="dataformat"></a> 

### Data Format 

- Must be a .CSV *comma-separated-value* file (you may export from Excel).
- File must have a header row.



#### Analyzed Data

<a name="rdata"></a> 

<a name="vis"></a> 

# Visualizations


<a name="pcaplots"></a>


<a name="analysisplots"></a>

## Validate


<a name="volcano"></a>
 

<a name="scatterplots"></a>

 
<a name="boxplots"></a>


<a name="heatmaps"></a>

