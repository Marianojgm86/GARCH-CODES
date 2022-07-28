# Libraries -----------
library(rugarch)
library(xts)
library(ggplot2)
library(plotly)

# ----
data <- read.csv("output\\inflationLags.csv",header=TRUE, sep=";", row.names='date')

TSdata <- as.xts(data, order.by=as.Date(rownames(data)))#,"%m/%d/%Y"))
inf <- TSdata[,3]["1993/2021"]



# -------------
# Three steps:
#  1. ugarchspec() specify the GARCH model to use (mu, variance and distriburion of e)
#  2. ugarchfit() Estimate the GARCH model specified in 1 on the time series.
#  3. ugarchforecast(): use the GARCH model to make volatility predictions for t+1

# Constant mean standar GARCH model
garchspec <- ugarchspec(mean.model=list(armaOrder = c(0,0)),
                        variance.model = list(model='sGARCH'),
                        distribution.model = 'norm')

garchfit <- ugarchfit(data = inf, spec = garchspec)

garchforercast <- ugarchforecast(fitORspec = garchfit, n.ahead = 5)

# Methods ------
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
volpred <- sigma(garchforecast)
# mean pred
meanpred <- fitted(garchforecast)






