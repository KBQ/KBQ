Quality measures verification conditions 

-- Persistency: Persistency measure values [0,1]: class specific measure result to identify presistency issue.
- Interpretation : The value of 1 implies no persistency issue present in the class. The value of 0 indicates persistency issues
found in the class.

-- Historical Persistency: Percentage (%) of historical persistency: estimation of persistency issue over all KB releases
- Interpretation: High % presents an estimation of fewer issues, and lower % entail more issues present in KB releases.

-- Completeness: List of properties with completeness measures weighted value [0,1]: property specific measure to detect
completeness issue.
- Interpretation: The value of 1 implies no completeness issue present in the property. The value of 0 indicates completeness issues found in the property.

-- KB growth: The value is 1 if the normalized distance between actual value is higher than predicted value of a class, otherwise it is 0. 
- Interpretation: In particular, if the KB growth measure has value of 1 then the KB may have unexpected growth with unwanted entities otherwise KB remains stable.