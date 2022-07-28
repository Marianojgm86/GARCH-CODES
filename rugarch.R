# Libraries -----------
library(rugarch)
library(xts)
library(ggplot2)
library(plotly)

setwd("C:\\Users\\USUARIO\\Documents\\00-MQE-UCLA\\Capstone\\GARCH-CODES")
# DATA LOADING ----

# Inflation
data <- read.csv("output\\inflationLags.csv",header=TRUE, sep=";", row.names='date')
TSdata <- as.xts(data, order.by=as.Date(rownames(data)))#,"%m/%d/%Y"))
inf <- TSdata[,3]["1993/2021"]

# External Controls
cont <- read.csv("output\\controls_base.csv",header=TRUE, sep=',', row.names='date')
TScont <- as.xts(cont, order.by=as.Date(rownames(cont),"%m/%d/%Y"))#,"%m/%d/%Y""))


# General steps -------------
# Three steps:
#  1. ugarchspec() specify the GARCH model to use (mu, variance and distriburion of e)
#  2. ugarchfit() Estimate the GARCH model specified in 1 on the time series.
#  3. ugarchforecast(): use the GARCH model to make volatility predictions for t+1

# Constant mean standard GARCH(1,1) model -----
garchspec <- ugarchspec(mean.model=list(armaOrder = c(0,0)),
                        variance.model = list(model='sGARCH'),
                        distribution.model = 'norm')

garchfit <- ugarchfit(data = inf, spec = garchspec)

garchforercast <- ugarchforecast(fitORspec = garchfit, n.ahead = 5)

# Methods 
# Coefficients
garchcoef <- coef(garchfit)

# Unconditional Variance
garchuncvar <- uncvariance(garchfit)

# Predicted Mean
garchmean <- fitted(garchfit)

# Predicted volatility
garchvol <- sigma(garchfit)

# for predictions
# volatility prediction
volpred <- sigma(garchforercast)
# mean pred
meanpred <- fitted(garchforercast)

# plots 



# With mean model

garchspec2 <- ugarchspec(mean.model=list(armaOrder = c(1,1)),
                        variance.model = list(model='sGARCH'),
                        distribution.model = 'std')

garchfit2 <- ugarchfit(data = inf, spec = garchspec2)

garchforercast2 <- ugarchforecast(fitORspec = garchfit, n.ahead = 5)
