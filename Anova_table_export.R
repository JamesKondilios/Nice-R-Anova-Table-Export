# Author: James Kondilios
# email: u6046902@anu.edu.au / James.Kondilios@anu.edu.au

# R version 3.3.3
library(Hmisc) # install.packages("Hmisc") straight from CRAN. version 4.0-3
library(grid) # version 3.3.3
library(gtable) # version 0.2.0
library(gridExtra) # version 2.2.1

# 'DisplayAnovaSummary' takes anova summary object and returns graphical represntation of the table for image export.
DisplayAnovaSummary <- function(model_summary_object, title, title_font_size = 20, footnote = " ", sig_digits =2){
  # Error handling:
  suppressWarnings(if(class(model_summary_object) != "summary.aov"){
    stop("Error: model_summary_object must be of class 'summary.aov' ")
  })
  # Convert model summary object to data frame
  model_summary <- data.frame(unclass(model_summary_object))
  model_summary <- signif(model_summary,sig_digits) #sig figs
  
  # Add asterisks to significant P-values. (They get removed in conversion to data.frame)
  for(x in 1:(length(model_summary$Pr..F.)-1)){
    if((model_summary$Pr..F.)[x] < 0.001){
      model_summary$Pr..F.[x]<- paste( formatC(model_summary$Pr..F.[x], format = "e", digits = sig_digits),"***",sep = " ")
    }
    else if((model_summary$Pr..F.)[x] < 0.01){
      model_summary$Pr..F.[x]<- paste(formatC(model_summary$Pr..F.[x], format = "e", digits = sig_digits),"**",sep = " ")
    }
    else if((model_summary$Pr..F.)[x] <= 0.05){
      model_summary$Pr..F.[x]<- paste( formatC(model_summary$Pr..F.[x], format = "e", digits = sig_digits),"*",sep = " ")
    }
    else if((model_summary$Pr..F.[x] > 0.05)){
      model_summary$Pr..F.[x]<- paste( formatC(model_summary$Pr..F.[x], format = "e", digits = sig_digits),"",sep = " ")
    }
  }
  # Fix colnames
  colnames(model_summary) <- c("   Df    ", "Sum Sq", 'Mean Sq', "F-value", "Pr(>F)")
  model_summary[is.na(model_summary)] <- " " # replace NAs so on table display they're invisible.

  # Make gtable object for display
  table <- tableGrob(model_summary)
  title <- textGrob(title ,gp=gpar(fontsize=title_font_size)) # title
  footnote <- textGrob(footnote, x=0, hjust=0,gp=gpar( fontface="italic")) # figure caption
  padding <- unit(2.3,"line")
  table <- gtable_add_rows(table, heights = grobHeight(title) + padding, pos = 0)
  table <- gtable_add_rows(table, heights = grobHeight(footnote) + padding)
  table <- gtable_add_grob(table, list(title, footnote),t=c(1, nrow(table)), l=c(1,2), r=ncol(table))
  grid.newpage()
  grid.draw(table)
}

model1 <- summary(aov(mtcars$mpg ~ mtcars$cyl + mtcars$hp + mtcars$drat + mtcars$gear + mtcars$cyl*mtcars$gear))
DisplayAnovaSummary(model_summary_object = model1, title = "TITLE", title_font_size = 16,footnote = "footnote")

