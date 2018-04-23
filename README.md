# Nice-R-Anova-Table-Export
There's currently no function in R to export an analysis of variance summary table as an image. Screenshotting the table from the consol looks ugly. This script is an answer to this problem. The 'DisplayAnovaSummary' function takes a summary.aov object and produces a graphical represntation of it. It also adds significance asterisks to the P-value column. Auguments 'title' and 'footnote' can be used to add titles and footnotes to your tables. 

## This is unplesant:
![alt text](https://github.com/JamesKondilios/Nice-R-Anova-Table-Export/blob/master/Screen%20Shot%202018-04-23%20at%204.08.39%20pm.png)

## This is less unpleasant:
![alt text](https://github.com/JamesKondilios/Nice-R-Anova-Table-Export/blob/master/Example_table.png)

## Example implimentation:
`data(mtcars)`<br />
`source("Anova_table_export.R")`<br />
`model1 <- summary(aov(mtcars$mpg ~ mtcars$cyl + mtcars$hp + mtcars$drat + mtcars$gear +  mtcars$cyl*mtcars$gear))`<br />
`DisplayAnovaSummary(model_summary_object = model1, title = "TITLE", title_font_size = 16,footnote = "footnote")`<br />
