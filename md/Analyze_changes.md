This module extracts, inspects and comment on instances with quality issues. An end user can extract properties with quality issue after performing quality profiling. It performs validation in four steps: 

**Incomplete properties:** list of properties with completeness quality issues for validation. 

**Instances:** quality profiling is done based on summary statistics. To detect the missing instances of a property, instance extraction component perform comparison between the list of instances of two version. 

**Inspections:** after the instance, extraction is done any user can select every instance for inspection and report. 

**Report:** an end user can report if the instance is true positive (the subject presents an issue, and an actual problem was detected) or false positive (the item presents a possible issue, but none actual problem is found), as well as an end user can comment on specific issues. Finally, an end user can save the validation report in a CSV file. Currently, validation module is only performed for DBpedia ES.


