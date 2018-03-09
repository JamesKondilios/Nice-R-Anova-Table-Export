# Nice-R-Anova-Table-Export
There's currently no function in R to export an anova summary table as an image. Screenshotting the table from the consol looks ugly. This script is an answer to this problem. The 'Display_AnovaSummary' function takes a summary.aov object and produces a graphical represntation of it. It also adds significance asterisks to the P-value column. Auguments 'title' and 'footnote' can be used to add titles and footnotes to your tables. 

# Example table
![alt text](https://github.com/JamesKondilios/Nice-R-Anova-Table-Export/blob/master/Example_table.png)

# Example implimentation:
`data(mtcars)`<br />
`source("Anova_table_export.R")`<br />
`model1 <- summary(aov(mtcars$mpg ~ mtcars$cyl + mtcars$hp + mtcars$drat + mtcars$gear +  mtcars$cyl*mtcars$gear))`<br />
`Display_AnovaSummary(model_summary_object = model1, title = "TITLE", title_font_size = 16,footnote = "footnote")`<br />
