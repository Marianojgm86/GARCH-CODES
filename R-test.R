setwd("C:\\Users\\USUARIO\\Documents\\00-MQE-UCLA\\Capstone\\GARCH-CODES")

library(rugarch)
library(rugarch)
#library(ts)
library(xts)
library(ggplot)
library(ggplot2)
library(plotly)
data <- data.frame(read.csv("output\\inflationLags.csv", 
                            header=TRUE, sep=";", row.names='date')
)
# rownames(data) <- data$date
# data$date <- NULL

p <- plot_ly(x=data$date, y=data$v_cpi, type="scatter", mode="markers")
p <- add_trace(p, x=data$date, y=data$v_cpi, type="scatter", mode="markers", fill='tonexty')
p

