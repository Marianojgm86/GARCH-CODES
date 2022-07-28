# setwd("C:\\Users\\USUARIO\\Documents\\00-MQE-UCLA\\Capstone\\GARCH-CODES")

library(rugarch)
library(rmgarch)
#library(ts)
library(xts)
# library(ggplot)
library(ggplot2)
library(plotly)

# Data Loading -----------------------

data <- read.csv("output\\inflationLags.csv",header=TRUE, sep=";", row.names='date')

xts<- as.xts(data, order.by=as.Date(rownames(data)))#,"%m/%d/%Y"))

# XTS ---------------
nmonts(xts)
nquarters(xts)
start(xts)
end(xts)
lapply(xts,FUN=mean)
xts_yearly <- split(xts,f="years")

# rolling mean (sd)
rollapply(xts, 12, mean) 

# subset
mar95 <- xts["1995-03"]
dat95 <- xts["1995"]
xts_janmarch <- xts["1994/1994-03"]
# just a column
xts["1994/1994-03"][,3]
# lag(xts, number of lags)
# lagged difference
# diff(xts5,lag=12,differences=1) 


# Plots -----------------------------

# using plot function from xts package
plot(xts[,3])

plot(xts[,3]["1993/2021"])

# ggplot
# p <- plot_ly(x=data$date, y=data$v_cpi, type="scatter", mode="markers")
# p <- add_trace(p, x=data$date, y=data$v_cpi, type="scatter", mode="markers", fill='tonexty')
# p

p <- ggplot(xts, aes(y=v_cpi)) +
  geom_line() + 
  xlab("")
p

