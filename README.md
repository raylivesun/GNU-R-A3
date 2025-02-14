---
title: "GNU-R-A3"
author: "admin"
date: "`r Sys.Date()`"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## R Markdown

This is an R Markdown document. Markdown is a simple formatting syntax for authoring HTML, PDF, and MS Word documents. For more details on using R Markdown see <http://rmarkdown.rstudio.com>.

When you click the **Knit** button a document will be generated that includes both content as well as the output of any embedded R code chunks within the document. You can embed an R code chunk like this:

```{r cars}
summary(cars)
```

## Including Plots

You can also embed plots, for example:

```{r pressure, echo=FALSE}
plot(pressure)
```

Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot.

# GNU-R-A3

Package ‘A3’
October 12, 2022
Type Package
Title Accurate, Adaptable, and Accessible Error Metrics for Predictive
Models
Version 1.0.0
Date 2015-08-15
Author Scott Fortmann-Roe
Maintainer Scott Fortmann-Roe <scottfr@berkeley.edu>
Description Supplies tools for tabulating and analyzing the results of predictive models. The meth-
ods employed are applicable to virtually any predictive model and make comparisons be-
tween different methodologies straightforward.
License GPL (>= 2)
Depends R (>= 2.15.0), xtable, pbapply
Suggests randomForest, e1071
NeedsCompilation no
Repository CRAN
Date/Publication 2015-08-16 23:05:52

R topics documented:
A3-package . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 2
a3 . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 2
a3.base . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 4
a3.gen.default . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 5
a3.lm . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 6
a3.r2 . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 7
housing . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 8
multifunctionality . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 9
plot.A3 . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 10
plotPredictions . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 10
plotSlopes . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 11
print.A3 . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 11
xtable.A3 . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 12
1
2 a3
Index 13
A3-package A3 Error Metrics for Predictive Models

# Description

A package for the generation of accurate, accessible, and adaptable error metrics for developing
high quality predictions and inferences. The name A3 (pronounced "A-Cubed") comes from the
combination of the first letters of these three primary adjectives.

# Details

The overarching purpose of the outputs and tools in this package are to make the accurate assess-
ment of model errors more accessible to a wider audience. Furthermore, a standardized set of
reporting features are provided by this package which create consistent outputs for virtually any
predictive model. This makes it straightforward to compare, for instance, a linear regression model
to more exotic techniques such as Random forests or Support vector machines.
The standard outputs for each model fit provided by the A3 package include:
• Average Slope: Equivalent to a linear regression coefficient.
• Cross Validated R2: Robust calculation of R2 (percent of squared error explained by the
model compared to the null model) values adjusting for over-fitting.
• p Values: Robust calculation of p-values requiring no parametric assumptions other than in-
dependence between observations (which may be violated if compensated for).
The primary functions that will be used are a3 for arbitrary modeling functions and a3.lm for linear
models. This package also includes print.A3 and plot.A3 for outputting the A3 results.
Author(s)
Scott Fortmann-Roe <scottfr@berkeley.edu> http://Scott.Fortmann-Roe.com
a3 A3 Results for Arbitrary Model

# Description

This function calculates the A3 results for an arbitrary model construction algorithm (e.g. Linear
Regressions, Support Vector Machines or Random Forests). For linear regression models, you may
use the a3.lm convenience function.

# Usage

```
a3(formula, data, model.fn, model.args = list(), ...)
```

a3 3

# Arguments

formula the regression formula.
data a data frame containing the data to be used in the model fit.
model.fn the function to be used to build the model.
model.args a list of arguments passed to model.fn.
... additional arguments passed to a3.base.

# Value

S3 A3 object; see a3.base for details

References
Scott Fortmann-Roe (2015). Consistent and Clear Reporting of Results from Diverse Modeling
Techniques: The A3 Method. Journal of Statistical Software, 66(7), 1-23. 

<http://www.jstatsoft.org/v66/i07/>

# Examples

## Standard linear regression results:

```
summary(lm(rating ~ ., attitude))
```

## A3 Results for a Linear Regression model:
# In practice, p.acc should be <= 0.01 in order
# to obtain finer grained p values.

```
a3(rating ~ ., attitude, lm, p.acc = 0.1)
```

## A3 Results for a Random Forest model:
# It is important to include the "+0" in the formula
# to eliminate the constant term.

```
require(randomForest)
```

```
a3(rating ~ .+0, attitude, randomForest, p.acc = 0.1)
```

# Set the ntrees argument of the randomForest function to 100

```
a3(rating ~ .+0, attitude, randomForest, p.acc = 0.1, model.args = list(ntree = 100))
```

# Speed up the calculation by doing 5-fold cross-validation.
# This is faster and more conservative (i.e. it should over-estimate error)

```
a3(rating ~ .+0, attitude, randomForest, n.folds = 5, p.acc = 0.1)
```

# Use Leave One Out Cross Validation. The least biased approach,
# but, for large data sets, potentially very slow.

4 a3.base

```
a3(rating ~ .+0, attitude, randomForest, n.folds = 0, p.acc = 0.1)
```

## Use a Support Vector Machine algorithm.
# Just calculate the slopes and R^2 values, do not calculate p values.

```
require(e1071)
a3(rating ~ .+0, attitude, svm, p.acc = NULL)
```

a3.base Base A3 Results Calculation

# Description

This function calculates the A3 results. Generally this function is not called directly. It is simpler
to use a3 (for arbitrary models) or a3.lm (specifically for linear regressions).

# Usage

a3.base(formula, data, model.fn, simulate.fn, n.folds = 10,
data.generating.fn = replicate(ncol(x), a3.gen.default), p.acc = 0.01,
features = TRUE, slope.sample = NULL, slope.displacement = 1)

# Arguments

formula the regression formula.
data a data frame containing the data to be used in the model fit.
model.fn function used to generate a model.
simulate.fn function used to create the model and generate predictions.
n.folds the number of folds used for cross-validation. Set to 0 to use Leave One Out
Cross Validation.
data.generating.fn
the function used to generate stochastic noise for calculation of exact p values.
p.acc the desired accuracy for the calculation of exact p values. The entire calculation
process will be repeated 1/p.acc times so this can have a dramatic affect on time
required. Set to NULL to disable the calculation of p values.
features whether to calculate the average slopes, added R2 and p values for each of the
features in addition to the overall model.
slope.sample if not NULL the sample size for use to calculate the average slopes (useful for
very large data sets).
slope.displacement
the amount of displacement to take in calculating the slopes. May be a single
number in which case the same slope is applied to all features. May also be a
named vector where there is a name for each feature.
a3.gen.default 5

# Value

S3 A3 object containing:
model.R2 The cross validated R2 for the entire model.
feature.R2 The cross validated R2’s for the features (if calculated).
model.p The p value for the entire model (if calculated).
feature.p The p value for the features (if calculated).
all.R2 The R2’s for the model features, and any stochastic simulations for calculating
exact p values.
observed The observed response for each observation.
predicted The predicted response for each observation.
slopes Average slopes for each of the features (if calculated).
all.slopes Slopes for each of the observations for each of the features (if calculated).
table The A3 results table.
a3.gen.default Stochastic Data Generators

# Description

The stochastic data generators generate stochastic noise with (if specified correctly) the same prop-
erties as the observed data. By replicating the stochastic properties of the original data, we are able
to obtain the exact calculation of p values.

# Usage

```
a3.gen.default(x, n.reps)
```

# Arguments

x the original (observed) data series.
n.reps the number of stochastic repetitions to generate.
Details
Generally these will not be called directly but will instead be passed to the data.generating.fn
argument of a3.base.
6 a3.lm

# Value

A list of of length n.reps of vectors of stochastic noise. There are a number of different methods
of generating noise:
a3.gen.default The default data generator. Uses a3.gen.bootstrap.
a3.gen.resample
Reorders the original data series.
a3.gen.bootstrap
Resamples the original data series with replacement.
a3.gen.normal Calculates the mean and standard deviation of the original series and generates
a new series with that distribution.
a3.gen.autocor Assumesa first order autocorrelation of the original series and generates a new
series with the same properties.

# Examples

# Calculate the A3 results assuming an auto-correlated set of observations.
# In usage p.acc should be <=0.01 in order to obtain more accurate p values.

```
a3.lm(rating ~ ., attitude, p.acc = 0.1,
data.generating.fn = replicate(ncol(attitude), a3.gen.autocor))
```

## A general illustration:
# Take x as a sample set of observations for a feature

```
x <- c(0.349, 1.845, 2.287, 1.921, 0.803, 0.855, 2.368, 3.023, 2.102, 4.648)
```

# Generate three stochastic data series with the same autocorrelation properties as x

```
rand.x <- a3.gen.autocor(x, 3)
plot(x, type="l")
for(i in 1:3) lines(rand.x[[i]], lwd = 0.2)
```

a3.lm A3 for Linear Regressions

# Description

This convenience function calculates the A3 results specifically for linear regressions. It uses R’s
glm function and so supports logistic regressions and other link functions using the family argu-
ment. For other forms of models you may use the more general a3 function.
Usage
a3.lm(formula, data, family = gaussian, ...)
a3.r2 7

# Arguments

formula the regression formula.
data a data frame containing the data to be used in the model fit.
family the regression family. Typically ’gaussian’ for linear regressions.
... additional arguments passed to a3.base.

# Value

S3 A3 object; see a3.base for details

# Examples

## Standard linear regression results:

```
summary(lm(rating ~ ., attitude))
```

## A3 linear regression results:

# In practice, p.acc should be <= 0.01 in order
# to obtain fine grained p values.

```
a3.lm(rating ~ ., attitude, p.acc = 0.1)
```

# This is equivalent both to:

```
a3(rating ~ ., attitude, glm, model.args = list(family = gaussian), p.acc = 0.1)
```

# and also to:

a3(rating ~ ., attitude, lm, p.acc = 0.1)
a3.r2 Cross-Validated Rˆ2
Description
Applies cross validation to obtain the cross-validated R2 for a model: the fraction of the squared
error explained by the model compared to the null model (which is defined as the average response).
A pseudo R2 is implemented for classification.

# Usage

a3.r2(y, x, simulate.fn, cv.folds)
8 housing
Arguments
y a vector or responses.
x a matrix of features.
simulate.fn a function object that creates a model and predicts y.
cv.folds the cross-validation folds.
Value
A list comprising of the following elements:
R2 the cross-validated R2
predicted the predicted responses
observed the observed responses
housing Boston Housing Prices

# Description

A dataset containing the prices of houses in the Boston region and a number of features. The
dataset and the following description is based on that provided by UCI Machine Learning Reposi-
tory (http://archive.ics.uci.edu/ml/datasets/Housing).
Usage
data(housing)

# Details

• CRIME: Per capita crime rate by town
• ZN: Proportion of residential land zoned for lots over 25,000 sq.ft.
• INDUS: Proportion of non-retail business acres per town
• CHAS: Charles River dummy variable (= 1 if tract bounds river; 0 otherwise)
• NOX: Nitrogen oxides pollutant concentration (parts per 10 million)
• ROOMS: Average number of rooms per dwelling
• AGE: Proportion of owner-occupied units built prior to 1940
• DISTANCE: Weighted distances to five Boston employment centres
• HIGHWAY: Index of accessibility to radial highways
• TAX: Full-value property-tax rate per ten thousand dollar
• PUPIL.TEACHER: Pupil-teacher ratio by town
• MINORITY: 1000(Bk - 0.63)^2 where Bk is the proportion of blacks by town
• LSTAT: Percent lower status of the population
• MED.VALUE: Median value of owner-occupied homes in thousands of dollars
multifunctionality 9
References
Frank, A. & Asuncion, A. (2010). UCI Machine Learning Repository [http://archive.ics.uci.edu/ml].
Irvine, CA: University of California, School of Information and Computer Science.
Harrison, D. and Rubinfeld, D.L. Hedonic prices and the demand for clean air, J. Environ. Eco-
nomics & Management, vol.5, 81-102, 1978.
multifunctionality Ecosystem Multifunctionality

# Description

This dataset relates multifunctionality to a number of different biotic and abiotic features in a global
survey of drylands. The dataset was obtained from (http://www.sciencemag.org/content/335/
6065/214/suppl/DC1). The dataset contains the features listed below.
Usage
data(multifunctionality)
Details
• ELE: Elevation of the site
• LAT & LONG: Location of the site
• SLO: Site slope
• SAC: Soil sand content
• PCA_C1, PCA_C2, PCA_C3, PCA_C4: Principal components of a set of 21 climatic features
• SR: Species richness
• MUL: Multifunctionality
References
Maestre, F. T., Quero, J. L., Gotelli, N. J., Escudero, A., Ochoa, V., Delgado-Baquerizo, M., et al.
(2012). Plant Species Richness and Ecosystem Multifunctionality in Global Drylands. Science,
335(6065), 214-218. doi:10.1126/science.1215442
10 plotPredictions
plot.A3 Plot A3 Results
Description
Plots an ’A3’ object results. Displays predicted versus observed values for each observation along
with the distribution of slopes measured for each feature.

# Usage
## S3 method for class 'A3'
plot(x, ...)

# Arguments

x an A3 object.
... additional options provided to plotPredictions, plotSlopes and plot func-
tions.

# Examples

data(housing)
res <- a3.lm(MED.VALUE ~ NOX + ROOMS + AGE + HIGHWAY + PUPIL.TEACHER, housing, p.acc = NULL)
plot(res)
plotPredictions Plot Predicted versus Observed
# Description

Plots an ’A3’ object’s values showing the predicted versus observed values for each observation.
Usage
plotPredictions(x, show.equality = TRUE, xlab = "Observed Value",
ylab = "Predicted Value", main = "Predicted vs Observed", ...)

# Arguments

x an A3 object,
show.equality if true plot a line at 45-degrees.
xlab the x-axis label.
ylab the y-axis label.
main the plot title.
... additional options provided to the plot function.
plotSlopes 11

# Examples

```
data(multifunctionality)
```

```
x <- a3.lm(MUL ~ ., multifunctionality, p.acc = NULL, features = FALSE)
plotPredictions(x)
```

plotSlopes Plot Distribution of Slopes

# Description

Plots an ’A3’ object’s distribution of slopes for each feature and observation. Uses Kernel Density
Estimation to create an estimate of the distribution of slopes for a feature.

# Usage

```
plotSlopes(x, ...)
```

# Arguments

x an A3 object.
... additional options provided to the plot and density functions.

# Examples

```
require(randomForest)
data(housing)
```

```
x <- a3(MED.VALUE ~ NOX + PUPIL.TEACHER + ROOMS + AGE + HIGHWAY + 0,
housing, randomForest, p.acc = NULL, n.folds = 2)
plotSlopes(x)
```

print.A3 Print Fit Results

# Description

Prints an ’A3’ object results table.

# Usage

## S3 method for class 'A3'

```
print(x, ...)
```
12 xtable.A3
Arguments
x an A3 object.
... additional arguments passed to the print function.

# Examples

```
x <- a3.lm(rating ~ ., attitude, p.acc = NULL)
print(x)
```

xtable.A3 Nicely Formatted Fit Results
Description
Creates a LaTeX table of results. Depends on the xtable package.

# Usage

## S3 method for class 'A3'

```
xtable(x, ...)
```

# Arguments

x an A3 object.
... additional arguments passed to the print.xtable function.

# Examples

```
x <- a3.lm(rating ~ ., attitude, p.acc = NULL)
xtable(x)
```

Index
∗ datasets
housing, 8
multifunctionality, 9
a3, 2, 2, 4, 6
A3-package, 2
a3.base, 3, 4, 5, 7
a3.gen.autocor (a3.gen.default), 5
a3.gen.bootstrap (a3.gen.default), 5
a3.gen.default, 5
a3.gen.normal (a3.gen.default), 5
a3.gen.resample (a3.gen.default), 5
a3.lm, 2, 4, 6
a3.r2, 7
density, 11
glm, 6
housing, 8
multifunctionality, 9
plot, 10, 11
plot.A3, 2, 10
plotPredictions, 10, 10
plotSlopes, 10, 11
print, 12
print.A3, 2, 11
print.xtable, 12
xtable.A3, 12
13
## 🚀 Getting Started


2 a3
Index 13
A3-package A3 Error Metrics for Predictive Models

# Description

A package for the generation of accurate, accessible, and adaptable error metrics for developing
high quality predictions and inferences. The name A3 (pronounced "A-Cubed") comes from the
combination of the first letters of these three primary adjectives.

# Details

The overarching purpose of the outputs and tools in this package are to make the accurate assess-
ment of model errors more accessible to a wider audience. Furthermore, a standardized set of
reporting features are provided by this package which create consistent outputs for virtually any
predictive model. This makes it straightforward to compare, for instance, a linear regression model
to more exotic techniques such as Random forests or Support vector machines.
The standard outputs for each model fit provided by the A3 package include:
• Average Slope: Equivalent to a linear regression coefficient.
• Cross Validated R2: Robust calculation of R2 (percent of squared error explained by the
model compared to the null model) values adjusting for over-fitting.
• p Values: Robust calculation of p-values requiring no parametric assumptions other than in-
dependence between observations (which may be violated if compensated for).
The primary functions that will be used are a3 for arbitrary modeling functions and a3.lm for linear
models. This package also includes print.A3 and plot.A3 for outputting the A3 results.
Author(s)
Scott Fortmann-Roe <scottfr@berkeley.edu> http://Scott.Fortmann-Roe.com
a3 A3 Results for Arbitrary Model
Description
This function calculates the A3 results for an arbitrary model construction algorithm (e.g. Linear
Regressions, Support Vector Machines or Random Forests). For linear regression models, you may
use the a3.lm convenience function.

# Usage

```
a3(formula, data, model.fn, model.args = list(), ...)
a3 3
```

# Arguments

formula the regression formula.
data a data frame containing the data to be used in the model fit.
model.fn the function to be used to build the model.
model.args a list of arguments passed to model.fn.
... additional arguments passed to a3.base.

# Value

S3 A3 object; see a3.base for details
References
Scott Fortmann-Roe (2015). Consistent and Clear Reporting of Results from Diverse Modeling
Techniques: The A3 Method. Journal of Statistical Software, 66(7), 1-23. <http://www.jstatsoft.org/v66/i07/>

# Examples

## Standard linear regression results:

```
summary(lm(rating ~ ., attitude))
```

## A3 Results for a Linear Regression model:
# In practice, p.acc should be <= 0.01 in order
# to obtain finer grained p values.

```
a3(rating ~ ., attitude, lm, p.acc = 0.1)
```

## A3 Results for a Random Forest model:
# It is important to include the "+0" in the formula
# to eliminate the constant term.

require(randomForest)

```
a3(rating ~ .+0, attitude, randomForest, p.acc = 0.1)
```

# Set the ntrees argument of the randomForest function to 100

```
a3(rating ~ .+0, attitude, randomForest, p.acc = 0.1, model.args = list(ntree = 100))
```

# Speed up the calculation by doing 5-fold cross-validation.
# This is faster and more conservative (i.e. it should over-estimate error)

```
a3(rating ~ .+0, attitude, randomForest, n.folds = 5, p.acc = 0.1)
```
# Use Leave One Out Cross Validation. The least biased approach,
# but, for large data sets, potentially very slow.
# 4 a3.base

```
a3(rating ~ .+0, attitude, randomForest, n.folds = 0, p.acc = 0.1)
```

## Use a Support Vector Machine algorithm.
# Just calculate the slopes and R^2 values, do not calculate p values.

require(e1071)
a3(rating ~ .+0, attitude, svm, p.acc = NULL)

### 📋 Prerequisites

# Description

This function calculates the A3 results. Generally this function is not called directly. It is simpler
to use a3 (for arbitrary models) or a3.lm (specifically for linear regressions).

# Usage

```
a3.base(formula, data, model.fn, simulate.fn, n.folds = 10,
data.generating.fn = replicate(ncol(x), a3.gen.default), p.acc = 0.01,
features = TRUE, slope.sample = NULL, slope.displacement = 1)
```
# Arguments

formula the regression formula.
data a data frame containing the data to be used in the model fit.
model.fn function used to generate a model.
simulate.fn function used to create the model and generate predictions.
n.folds the number of folds used for cross-validation. Set to 0 to use Leave One Out
Cross Validation.
data.generating.fn
the function used to generate stochastic noise for calculation of exact p values.
p.acc the desired accuracy for the calculation of exact p values. The entire calculation
process will be repeated 1/p.acc times so this can have a dramatic affect on time
required. Set to NULL to disable the calculation of p values.
features whether to calculate the average slopes, added R2 and p values for each of the
features in addition to the overall model.
slope.sample if not NULL the sample size for use to calculate the average slopes (useful for
very large data sets).
slope.displacement
the amount of displacement to take in calculating the slopes. May be a single
number in which case the same slope is applied to all features. May also be a
named vector where there is a name for each feature.
a3.gen.default 5

# Value

S3 A3 object containing:
model.R2 The cross validated R2 for the entire model.
feature.R2 The cross validated R2’s for the features (if calculated).
model.p The p value for the entire model (if calculated).
feature.p The p value for the features (if calculated).
all.R2 The R2’s for the model features, and any stochastic simulations for calculating
exact p values.
observed The observed response for each observation.
predicted The predicted response for each observation.
slopes Average slopes for each of the features (if calculated).
all.slopes Slopes for each of the observations for each of the features (if calculated).
table The A3 results table.

```
Give examples
```

### 🔧 Installation

# Description

The stochastic data generators generate stochastic noise with (if specified correctly) the same prop-
erties as the observed data. By replicating the stochastic properties of the original data, we are able
to obtain the exact calculation of p values.

# Usage

a3.gen.default(x, n.reps)

# Arguments

x the original (observed) data series.
n.reps the number of stochastic repetitions to generate.

# Details

Generally these will not be called directly but will instead be passed to the data.generating.fn
argument of a3.base.
6 a3.lm

# Value

A list of of length n.reps of vectors of stochastic noise. There are a number of different 

# methods

of generating noise:
a3.gen.default The default data generator. Uses a3.gen.bootstrap.
a3.gen.resample
Reorders the original data series.
a3.gen.bootstrap
Resamples the original data series with replacement.
a3.gen.normal Calculates the mean and standard deviation of the original series and generates
a new series with that distribution.
a3.gen.autocor Assumesa first order autocorrelation of the original series and generates a new
series with the same properties.

# Examples

# Calculate the A3 results assuming an auto-correlated set of observations.
# In usage p.acc should be <=0.01 in order to obtain more accurate p values.

a3.lm(rating ~ ., attitude, p.acc = 0.1,
data.generating.fn = replicate(ncol(attitude), a3.gen.autocor))

## A general illustration:
# Take x as a sample set of observations for a feature

x <- c(0.349, 1.845, 2.287, 1.921, 0.803, 0.855, 2.368, 3.023, 2.102, 4.648)

# Generate three stochastic data series with the same autocorrelation properties as x

```
rand.x <- a3.gen.autocor(x, 3)
plot(x, type="l")
for(i in 1:3) lines(rand.x[[i]], lwd = 0.2)
```

```
Give examples
```

# Description

This convenience function calculates the A3 results specifically for linear regressions. It uses R’s
glm function and so supports logistic regressions and other link functions using the family argu-
ment. For other forms of models you may use the more general a3 function.
Usage
a3.lm(formula, data, family = gaussian, ...)
a3.r2 7

# Arguments

formula the regression formula.
data a data frame containing the data to be used in the model fit.
family the regression family. Typically ’gaussian’ for linear regressions.
... additional arguments passed to a3.base.

# Value

S3 A3 object; see a3.base for details

# Examples

## Standard linear regression results:

summary(lm(rating ~ ., attitude))

## A3 linear regression results:
# In practice, p.acc should be <= 0.01 in order
# to obtain fine grained p values.

a3.lm(rating ~ ., attitude, p.acc = 0.1)

# This is equivalent both to:

a3(rating ~ ., attitude, glm, model.args = list(family = gaussian), p.acc = 0.1)

# and also to:

a3(rating ~ ., attitude, lm, p.acc = 0.1)

```
Until finished
```

# Description

Applies cross validation to obtain the cross-validated R2 for a model: the fraction of the squared
error explained by the model compared to the null model (which is defined as the average response).
A pseudo R2 is implemented for classification.
Usage
a3.r2(y, x, simulate.fn, cv.folds)
8 housing
Arguments
y a vector or responses.
x a matrix of features.
simulate.fn a function object that creates a model and predicts y.
cv.folds the cross-validation folds.
Value
A list comprising of the following elements:
R2 the cross-validated R2
predicted the predicted responses
observed the observed responses

## ⚙️ Running the tests

# Description

A dataset containing the prices of houses in the Boston region and a number of features. The
dataset and the following description is based on that provided by UCI Machine Learning Reposi-
tory (http://archive.ics.uci.edu/ml/datasets/Housing).

# Usage

data(housing)
Details
• CRIME: Per capita crime rate by town
• ZN: Proportion of residential land zoned for lots over 25,000 sq.ft.
• INDUS: Proportion of non-retail business acres per town
• CHAS: Charles River dummy variable (= 1 if tract bounds river; 0 otherwise)
• NOX: Nitrogen oxides pollutant concentration (parts per 10 million)
• ROOMS: Average number of rooms per dwelling
• AGE: Proportion of owner-occupied units built prior to 1940
• DISTANCE: Weighted distances to five Boston employment centres
• HIGHWAY: Index of accessibility to radial highways
• TAX: Full-value property-tax rate per ten thousand dollar
• PUPIL.TEACHER: Pupil-teacher ratio by town
• MINORITY: 1000(Bk - 0.63)^2 where Bk is the proportion of blacks by town
• LSTAT: Percent lower status of the population
• MED.VALUE: Median value of owner-occupied homes in thousands of dollars
multifunctionality 9
References
Frank, A. & Asuncion, A. (2010). UCI Machine Learning Repository [http://archive.ics.uci.edu/ml].
Irvine, CA: University of California, School of Information and Computer Science.
Harrison, D. and Rubinfeld, D.L. Hedonic prices and the demand for clean air, J. Environ. Eco-
nomics & Management, vol.5, 81-102, 1978.


### 🔩 Analyze tests end-to-end

# Description

This dataset relates multifunctionality to a number of different biotic and abiotic features in a global
survey of drylands. The dataset was obtained from (http://www.sciencemag.org/content/335/
6065/214/suppl/DC1). The dataset contains the features listed below.

# Usage

data(multifunctionality)
Details
• ELE: Elevation of the site
• LAT & LONG: Location of the site
• SLO: Site slope
• SAC: Soil sand content
• PCA_C1, PCA_C2, PCA_C3, PCA_C4: Principal components of a set of 21 climatic features
• SR: Species richness
• MUL: Multifunctionality
References
Maestre, F. T., Quero, J. L., Gotelli, N. J., Escudero, A., Ochoa, V., Delgado-Baquerizo, M., et al.
(2012). Plant Species Richness and Ecosystem Multifunctionality in Global Drylands. Science,
335(6065), 214-218. doi:10.1126/science.1215442

```
Give examples
```

### ⌨️ And coding style tests

Description
Plots an ’A3’ object results. Displays predicted versus observed values for each observation along
with the distribution of slopes measured for each feature.

# Usage

## S3 method for class 'A3'

plot(x, ...)

# Arguments

x an A3 object.
... additional options provided to plotPredictions, plotSlopes and plot func-
tions.

# Examples

```
data(housing)
res <- a3.lm(MED.VALUE ~ NOX + ROOMS + AGE + HIGHWAY + PUPIL.TEACHER, housing, p.acc = NULL)
plot(res)
```

```
Give examples
```

## 📦 Implementation

# Description

Plots an ’A3’ object’s values showing the predicted versus observed values for each observation.

# Usage

```
plotPredictions(x, show.equality = TRUE, xlab = "Observed Value",
ylab = "Predicted Value", main = "Predicted vs Observed", ...)
```

# Arguments

```
x an A3 object,
show.equality if true plot a line at 45-degrees.
xlab the x-axis label.
ylab the y-axis label.
main the plot title.
... additional options provided to the plot function.
plotSlopes 11
```

# Examples

```
data(multifunctionality)
x <- a3.lm(MUL ~ ., multifunctionality, p.acc = NULL, features = FALSE)
plotPredictions(x)
```

## 🛠️ Built with

# Description

Plots an ’A3’ object’s distribution of slopes for each feature and observation. Uses Kernel Density
Estimation to create an estimate of the distribution of slopes for a feature.

# Usage

```
plotSlopes(x, ...)
Arguments
x an A3 object.
... additional options provided to the plot and density functions.
Examples
require(randomForest)
data(housing)
x <- a3(MED.VALUE ~ NOX + PUPIL.TEACHER + ROOMS + AGE + HIGHWAY + 0,
housing, randomForest, p.acc = NULL, n.folds = 2)
plotSlopes(x)
```

## 🖇️ Collaborating

Description
Prints an ’A3’ object results table.
Usage

## S3 method for class 'A3'

```
print(x, ...)
12 xtable.A3
Arguments
x an A3 object.
... additional arguments passed to the print function.
Examples
x <- a3.lm(rating ~ ., attitude, p.acc = NULL)
print(x)
```
## 📌 Version

r ('littler') version 0.3.15

using GNU R Version 4.1.2 (2021-11-01)

Copyright (C) 2006 - 2021  Jeffrey Horner and Dirk Eddelbuettel

r is free software and comes with ABSOLUTELY NO WARRANTY.
You are welcome to redistribute it under the terms of the
GNU General Public License.  For more information about
these matters, see http://www.gnu.org/copyleft/gpl.html.

## ✒️ Authors

admin


## 📄 License

GPL-Compatible Free Software Licenses (#GPLCompatibleLicenses)

The following licenses qualify as free software licenses, and are compatible with the GNU GPL.

GNU General Public License (GPL) version 3 (#GNUGPL) (#GNUGPLv3)

    This is the latest version of the GNU GPL: a free software license, and a copyleft license. We recommend it for most software packages.

    Please note that GPLv3 is not compatible with GPLv2 by itself. However, most software released under GPLv2 allows you to use the terms of later versions of the GPL as well. When this is the case, you can use the code under GPLv3 to make the desired combination. To learn more about compatibility between GNU licenses, please see our FAQ.
GNU General Public License (GPL) version 2 (#GPLv2)

    This is the previous version of the GNU GPL: a free software license, and a copyleft license. We recommend the latest version for most software.

    Please note that GPLv2 is, by itself, not compatible with GPLv3. However, most software released under GPLv2 allows you to use the terms of later versions of the GPL as well. When this is the case, you can use the code under GPLv3 to make the desired combination. To learn more about compatibility between GNU licenses, please see our FAQ.
GNU Lesser General Public License (LGPL) version 3 (#LGPL) (#LGPLv3)

    This is the latest version of the LGPL: a free software license, but not a strong copyleft license, because it permits linking with nonfree modules. It is compatible with GPLv3. We recommend it for special circumstances only.

    Please note that LGPLv3 is not compatible with GPLv2 by itself. However, most software released under GPLv2 allows you to use the terms of later versions of the GPL as well. When this is the case, you can use the code under GPLv3 to make the desired combination. To learn more about compatibility between GNU licenses, please see our FAQ.
GNU Lesser General Public License (LGPL) version 2.1 (#LGPLv2.1)

    This is the previous version of the LGPL: a free software license, but not a strong copyleft license, because it permits linking with nonfree modules. It is compatible with GPLv2 and GPLv3. We generally recommend the latest version of the LGPL, for special circumstances only. To learn more about how LGPLv2.1 is compatible with other GNU licenses, please see our FAQ.
GNU Affero General Public License (AGPL) version 3 (#AGPL) (#AGPLv3.0)

    This is a free software, copyleft license. Its terms effectively consist of the terms of GPLv3, with an additional paragraph in section 13 to allow users who interact with the licensed software over a network to receive the source for that program. We recommend that developers consider using the GNU AGPL for any software which will commonly be run over a network.

    Please note that the GNU AGPL is not compatible with GPLv2. It is also technically not compatible with GPLv3 in a strict sense: you cannot take code released under the GNU AGPL and convey or modify it however you like under the terms of GPLv3, or vice versa. However, you are allowed to combine separate modules or source files released under both of those licenses in a single project, which will provide many programmers with all the permission they need to make the programs they want. See section 13 of both licenses for details.
GNU All-Permissive License (#GNUAllPermissive)

    This is a lax, permissive free software license, compatible with the GNU GPL, which we recommend GNU packages use for README and other small supporting files. All developers can feel free to use it in similar situations.

    Older versions of this license did not have the second sentence with the express warranty disclaimer. This same analysis applies to both versions.
Apache License, Version 2.0 (#apache2)

    This is a free software license, compatible with version 3 of the GNU GPL.

    Please note that this license is not compatible with GPL version 2, because it has some requirements that are not in that GPL version. These include certain patent termination and indemnification provisions. The patent termination provision is a good thing, which is why we recommend the Apache 2.0 license for substantial programs over other lax permissive licenses.
Artistic License 2.0 (#ArtisticLicense2)

    This license is a free software license, compatible with the GPL thanks to the relicensing option in section 4(c)(ii).
Clarified Artistic License (#ClarifiedArtistic)

    This license is a free software license, compatible with the GPL. It is the minimal set of changes needed to correct the vagueness of the Artistic License 1.0.
Berkeley Database License (a.k.a. the Sleepycat Software Product License) (#BerkeleyDB)

    This is a free software license, compatible with the GNU GPL.
Boost Software License (#boost)

    This is a lax, permissive non-copyleft free software license, compatible with the GNU GPL.
Modified BSD license (#ModifiedBSD)

    This is the original BSD license, modified by removal of the advertising clause. It is a lax, permissive non-copyleft free software license, compatible with the GNU GPL.

    This license is sometimes referred to as the 3-clause BSD license.

    The modified BSD license is not bad, as lax permissive licenses go, though the Apache 2.0 license is preferable. However, it is risky to recommend use of “the BSD license”, even for special cases such as small programs, because confusion could easily occur and lead to use of the flawed original BSD license. To avoid this risk, you can suggest the X11 license instead. The X11 license and the modified BSD license are more or less equivalent.

    However, the Apache 2.0 license is better for substantial programs, since it prevents patent treachery.
CeCILL version 2 (#CeCILL)

    The CeCILL is a free software license, explicitly compatible with the GNU GPL.

    The text of the CeCILL uses a couple of biased terms that ought to be avoided: “intellectual property” and “protection”; this decision was unfortunate, because reading the license tends to spread the presuppositions of those terms. However, this does not cause any particular problem for the programs released under the CeCILL.

    Section 9.4 of the CeCILL commits the program's developers to certain forms of cooperation with the users, if someone attacks the program with a patent. You might look at that as a problem for the developer; however, if you are sure you would want to cooperate with the users in those ways anyway, then it isn't a problem for you.
The Clear BSD License (#clearbsd)

    This is a free software license, compatible with both GPLv2 and GPLv3. It is based on the modified BSD license, and adds a term expressly stating it does not grant you any patent licenses. Because of this, we encourage you to be careful about using software under this license; you should first consider whether the licensor might want to sue you for patent infringement. If the developer is refusing users patent licenses to set up a trap for you, it would be wise to avoid the program.
Cryptix General License (#CryptixGeneralLicense)

    This is a lax, permissive non-copyleft free software license, compatible with the GNU GPL. It is nearly identical to the FreeBSD (also called “2-clause BSD”) license.
eCos license version 2.0 (#eCos2.0)

    The eCos license version 2.0 is a GPL-compatible free software license. It consists of the GPL, plus an exception allowing linking to software not under the GPL. This license has the same disadvantages as the LGPL.
Educational Community License 2.0 (#ECL2.0)

    This is a free software license, and it is compatible with GPLv3. It is based on the Apache License 2.0; the scope of the patent license has changed so that when an organization's employee works on a project, the organization does not have to license all of its patents to recipients. This patent license and the indemnification clause in section 9 make this license incompatible with GPLv2.
Eiffel Forum License, version 2 (#Eiffel)

    This is a free software license, compatible with the GNU GPL. Previous releases of the Eiffel license are not compatible with the GPL.
EU DataGrid Software License (#EUDataGrid)

    This is a lax, permissive non-copyleft free software license, compatible with the GNU GPL.
Expat License (#Expat)

    This is a lax, permissive non-copyleft free software license, compatible with the GNU GPL.

    Some people call this license “the MIT License,” but that term is misleading, since MIT has used many licenses for software. It is also ambiguous, since the same people also call the X11 license “the MIT License,” failing to distinguish them. We recommend not using the term “MIT License.”

    The difference between the X11 license and the Expat license is that the X11 license contains an extra paragraph about using the X Consortium's name. It is not a big deal, but it is a real difference.

    For substantial programs it is better to use the Apache 2.0 license since it blocks patent treachery.
FreeBSD license (#FreeBSD)

    This is the original BSD license with the advertising clause and another clause removed. (It is also sometimes called the “2-clause BSD license”.) It is a lax, permissive non-copyleft free software license, compatible with the GNU GPL.

    Our comments about the Modified BSD license apply to this license too.
Freetype Project License (#freetype)

    This is a free software license, and compatible with GPLv3. It has some attribution requirements which make it incompatible with GPLv2.
Historical Permission Notice and Disclaimer (#HPND)

    This is a lax, permissive, and weak free software license that is compatible with the GPL. It is similar to the license of Python 1.6a2 and earlier versions.
License of the iMatix Standard Function Library (#iMatix)

    This is a free software license and is GPL compatible.
License of imlib2 (#imlib)

    This is a free software license, and GPL-compatible. The author has explained to us that the GPL's options for providing source all mean the source has been “made available publicly” in their words.
Independent JPEG Group License (#ijg)

    This is a free software license, and compatible with the GNU GPL. The authors have assured us that developers who document changes as required by the GPL will also comply with the similar requirement in this license.
Informal license (#informal)

    An “informal license” means a statement such as “do whatever you like with this” or “you can redistribute this code and change it.”

    In the United States, these licenses are supposed to be interpreted based on what the author seems to intend. So they probably mean what they appear to mean. That would make them non-copyleft free software licenses and compatible with the GNU GPL. However, an unlucky choice of wording could give it a different meaning.

    However, many other countries have a more rigid approach to copyright licenses. There is no telling what courts in those countries might decide an informal statement means. Courts might even decide that it is not a license at all.

    If you want your code to be free, don't invite gratuitous trouble for your users. Please choose and apply an established free software license. We offer recommendations that we suggest you follow.
Intel Open Source License (#intel)

    This is a free software license, compatible with the GNU GPL.
ISC License (#ISC)

    This license is sometimes also known as the OpenBSD License. It is a free software license, and compatible with the GNU GPL.

    This license had an unfortunate wording choice: it provided recipients with “Permission to use, copy, modify, and distribute this software…” This was the same language from the license of Pine that the University of Washington later claimed prohibited people from distributing modified versions of the software.

    ISC has told us they do not share the University of Washington's interpretation, and we have every reason to believe them. ISC also updated the license to read “Permission to use, copy, modify, and/or distribute this software…” While the inclusion of “and/or” doesn't completely solve the issue, there's no reason to avoid software released under this license. However, to help make sure this language cannot cause any trouble in the future, we encourage developers to choose a different license for their own works. The FreeBSD License is similarly permissive and brief. However, if you want a lax, weak license, we recommend using the Apache 2.0 license.
Mozilla Public License (MPL) version 2.0 (#MPL-2.0)

    This is a free software license. Section 3.3 provides indirect compatibility between this license and the GNU GPL version 2.0, the GNU LGPL version 2.1, the GNU AGPL version 3, and all later versions of those licenses. When you receive work under MPL 2.0, you may make a “Larger Work” that combines that work with work under those GNU licenses. When you do, section 3.3 gives you permission to distribute the MPL-covered work under the terms of the same GNU licenses, with one condition: you must make sure that the files that were originally under the MPL are still available under the MPL's terms as well. In other words, when you make a combination this way, the files that were originally under the MPL will be dual licensed under the MPL and the GNU license(s). The end result is that the Larger Work, as a whole, will be covered under the GNU license(s). People who receive that combination from you will have the option to use any files that were originally covered by the MPL under that license's terms, or distribute the Larger Work in whole or in part under the GNU licenses' terms with no further restrictions.

    It's important to understand that the condition to distribute files under the MPL's terms only applies to the party that first creates and distributes the Larger Work. If it applied to their recipients as well, it would be a further restriction and incompatible with the GPL and AGPL. That said, when you make contributions to an existing project, we usually recommend that you keep your changes under the same license, even when you're not required to do so. If you receive a work under a GNU license where some files are also under the MPL, you should only remove the MPL from those files when there's a strong reason to justify it.

    Check the license notices on the MPL-covered software before you make a Larger Work this way. Parties who release original work under MPL 2.0 may choose to opt out of this compatibility by including a sentence in the license notices that says that the work is “Incompatible With Secondary Licenses.” Any software that includes this notice is not compatible with the GPL or AGPL.

    Software under previous versions of the MPL can be upgraded to version 2.0, but any software that isn't already available under one of the listed GNU licenses must be marked as Incompatible With Secondary Licenses. This means that software that's only available under previous versions of the MPL is still incompatible with the GPL and AGPL.
NCSA/University of Illinois Open Source License (#NCSA)

    This license is based on the terms of the Expat and modified BSD licenses. It is a lax, permissive non-copyleft free software license, compatible with the GNU GPL.
License of Netscape JavaScript (#NetscapeJavaScript)

    This is the disjunction of the Netscape Public License and the GNU GPL. Because of that, it is a free software license, compatible with the GNU GPL, but not a strong copyleft.
OpenLDAP License, Version 2.7 (#newOpenLDAP)

    This is a permissive non-copyleft free software license that is compatible with the GNU GPL.
License of Perl 5 and below (#PerlLicense)

    This license is the disjunction of the Artistic License 1.0 and the GNU GPL—in other words, you can choose either of those two licenses. It qualifies as a free software license, but it may not be a real copyleft. It is compatible with the GNU GPL because the GNU GPL is one of the alternatives.

    We recommend you use this license for any Perl 4 or Perl 5 package you write, to promote coherence and uniformity in Perl programming. Outside of Perl, we urge you not to use this license; it is better to use just the GNU GPL.
Public Domain (#PublicDomain)

    Being in the public domain is not a license; rather, it means the material is not copyrighted and no license is needed. Practically speaking, though, if a work is in the public domain, it might as well have an all-permissive non-copyleft free software license. Public domain material is compatible with the GNU GPL.

    If you want to release your work to the public domain, we encourage you to use formal tools to do so. We ask people who make small contributions to GNU to sign a disclaimer form; that's one solution. If you're working on a project that doesn't have formal contribution policies like that, CC0 is a good tool that anyone can use. It formally dedicates your work to the public domain, and provides a fallback license for cases where that is not legally possible.
License of Python 2.0.1, 2.1.1, and newer versions (#Python)

    This is a free software license and is compatible with the GNU GPL. Please note, however, that intermediate versions of Python (1.6b1, through 2.0 and 2.1) are under a different license (see below).
License of Python 1.6a2 and earlier versions (#Python1.6a2)

    This is a free software license and is compatible with the GNU GPL. Please note, however, that newer versions of Python are under other licenses (see above and below).
License of Ruby (#Ruby)

    This is a free software license, compatible with the GPL via an explicit dual-licensing clause.
SGI Free Software License B, version 2.0 (#SGIFreeB)

    The SGI Free Software License B version 2.0 is a free software license. It is essentially identical to the X11 License, with an optional alternative way of providing license notices.

    Previous versions of the SGI Free Software License B were not free software licenses, despite their name. However, they all included clauses that allow you to upgrade to new versions of the license, if you choose to do so. As a result, if a piece of software was released under any version of the SGI Free License B, you can use it under the terms of this free version.
Standard ML of New Jersey Copyright License (#StandardMLofNJ)

    This is a lax, permissive non-copyleft free software license, compatible with the GNU GPL.
Unicode, Inc. License Agreement for Data Files and Software (#Unicode)

    This is a license that Unicode, Inc. has applied to the Unicode Character Database—various data files that developers can use to help implement the Unicode standard in their own programs. It is a lax permissive license, compatible with all versions of the GPL.

    If you want to use files covered by this License Agreement in your own software, that shouldn't be any problem, but we recommend that you also include a full copy of its text. Some of the files contain alternative license terms which are nonfree, or no licensing information at all, so including a copy of the License Agreement will help avoid confusion when others want to distribute your software. Of course, you'll also need to follow the conditions in this License Agreement for distributing the files, but those are very straightforward.

    Please take care to ensure that the files you are using are covered by this License Agreement. Other files published by Unicode, Inc. are covered by the Unicode Terms of Use, a different, nonfree license that appears on the same page but covers different files. A short explanation at the top of this License Agreement details which files it covers.

    Please do not use this License Agreement for your own software. If you want to use a lax permissive license for your project, please use the Expat license for a small program and the Apache 2.0 license for a substantial program. These are far more common, and widely recognized in the free software community.
Universal Permissive License (UPL) (#UPL)

    This is a lax, permissive non-copyleft free software license, compatible with the GNU GPL. The license does provide the ability to license patents along with the software work, however, we still recommend the Apache 2.0 license for avoiding patent treachery when choosing to put your work under a lax license. 
The Unlicense (#Unlicense)

    The Unlicense is a public domain dedication. A work released under the Unlicense is dedicated to the public domain to the fullest extent permitted by law, and also comes with an additional lax license that helps cover any cases where the dedication is inadequate. Both public domain works and the lax license provided by the Unlicense are compatible with the GNU GPL.

    If you want to release your work to the public domain, we recommend you use CC0. CC0 also provides a public domain dedication with a fallback license, and is more thorough and mature than the Unlicense.
License of Vim, Version 6.1 or later (#Vim)

    This is a free software license, partially copyleft but not really. It is compatible with the GPL, by an explicit conversion clause.
W3C Software Notice and License (#W3C)

    This is a free software license and is GPL compatible.
License of WebM (#WebM)

    Google's WebM implementation is covered by the Modified BSD License. Google also provides a separate patent license (confusingly called an “Additional IP Rights Grant”) for patents that Google owns or controls that are necessarily infringed by their implementation of WebM. GPL-covered software can be distributed in compliance with this license's terms: it allows distributors to exercise all of the rights granted by the GPL, while fulfilling all its conditions. Thus, all of WebM's license is free and GPL-compatible.
WTFPL, Version 2 (#WTFPL)

    This is a lax permissive non-copyleft free software license, compatible with the GNU GPL.

    We do not recommend this license. If you want a lax permissive license for a small program, we recommend the X11 license. A larger program usually ought to be copyleft; but if you are set on using a lax permissive license for one, we recommend the Apache 2.0 license since it protects users from patent treachery.
WxWidgets Library License (#Wx)

    The WxWidgets license is a GPL-compatible free software license. It consists of the GNU Lesser GPL 2.0 or any later version, plus an additional permission allowing binary distributions that use the library to be licensed under terms of the distributor's choice (including proprietary). It is a weak copyleft, even weaker than the LGPL, so we recommend it only in special circumstances.
WxWindows Library License (#Wxwind)

    An older name for the WxWidgets Library license.
X11 License (#X11License)

    This is a lax permissive non-copyleft free software license, compatible with the GNU GPL. Older versions of XFree86 used the same license, and some of the current variants of XFree86 also do. Later versions of XFree86 are distributed under the XFree86 1.1 license.

    Some people call this license “the MIT License,” but that term is misleading, since MIT has used many licenses for software. It is also ambiguous, since the same people also call the Expat license “the MIT License,” failing to distinguish them. We recommend not using the term “MIT License.”

    The difference between the X11 license and the Expat license is that the X11 license contains an extra paragraph about using the X Consortium's name. It is not a big deal, but it is a real difference.

    This is a fine license for a small program. A larger program usually ought to be copyleft; but if you are set on a lax permissive license for one, we recommend the Apache 2.0 license since it protects users from patent treachery.
XFree86 1.1 License (#XFree861.1License)

    This is a lax, permissive non-copyleft free software license, compatible with version 3 of the GPL.

    Please note that this license is incompatible with version 2 of the GPL, because of its requirements that apply to all documentation in the distribution that contain acknowledgements.

    There are currently several variants of XFree86, and only some of them use this license. Some continue to use the X11 license.
License of ZLib (#ZLib)

    This is a free software license, and compatible with the GPL.
Zope Public License, versions 2.0 and 2.1 (#Zope2.0)

    This is a lax, permissive non-copyleft free software license which is compatible with the GNU GPL.

GPL-Incompatible Free Software Licenses (#GPLIncompatibleLicenses)

The following licenses are free software licenses, but are not compatible with the GNU GPL.

Affero General Public License version 1 (#AGPLv1.0)

    The Affero General Public License is a free software license, copyleft, and incompatible with the GNU GPL. It consists of the GNU GPL version 2, with one additional section that Affero added with FSF approval. The new section, 2(d), covers the distribution of application programs through web services or computer networks.

    This license has been succeeded by the GNU Affero General Public License version 3; please use that instead.
Academic Free License, all versions through 3.0 (#AcademicFreeLicense)

    The Academic Free License is a free software license, not copyleft, and incompatible with the GNU GPL. Recent versions contain contract clauses similar to the Open Software License, and should be avoided for the same reasons.
Apache License, Version 1.1 (#apache1.1)

    This is a permissive non-copyleft free software license. It has a few requirements that render it incompatible with the GNU GPL, such as strong prohibitions on the use of Apache-related names.
Apache License, Version 1.0 (#apache1)

    This is a lax, permissive non-copyleft free software license with an advertising clause. This creates practical problems like those of the original BSD license, including incompatibility with the GNU GPL.
Apple Public Source License (APSL), version 2 (#apsl2)

    This is a free software license, incompatible with the GNU GPL. We recommend that you not use this license for new software that you write, but it is ok to use and improve the software released under this license. More explanation.
BitTorrent Open Source License (#bittorrent)

    This is a free software license, but incompatible with the GPL, for the same reasons as the Jabber Open Source License.
Original BSD license (#OriginalBSD)

    This license is also sometimes called the “4-clause BSD license”.

    This is a lax, permissive non-copyleft free software license with a serious flaw: the “obnoxious BSD advertising clause”. The flaw is not fatal; that is, it does not render the software nonfree. But it does cause practical problems, including incompatibility with the GNU GPL.

    We urge you not to use the original BSD license for software you write. If you want to use a lax, permissive non-copyleft free software license, it is much better to use the modified BSD license, the X11 license or the Expat license. Even better, for a substantial program, use the Apache 2.0 license since it takes action against patent treachery.

    However, there is no reason not to use programs that have been released under the original BSD license.
CeCILL-B version 1 (#CeCILL-B)

    The CeCILL-B is a free software license. It is incompatible with the GPL because it has requirements that are not present in the GPL. The credit requirements in section 5.3.4 exceed those of the GPL. It also has a strange requirement that you use your “best efforts” to get third parties to agree “to comply with the obligations set forth in this Article.”

    Please do not release software under this license.
CeCILL-C version 1 (#CeCILL-C)

    The CeCILL-C is a free software license with a weak copyleft somewhat like the GNU Lesser General Public License. It is incompatible with the GNU GPL because it does not contain the explicit GPL-compatibility clause of the basic CeCILL.

    Please do not release software under this license.
Common Development and Distribution License (CDDL), version 1.0 (#CDDL)

    This is a free software license. It has a weak per-file copyleft (like version 1 of the Mozilla Public License) which makes it incompatible with the GNU GPL. This means a module covered by the GPL and a module covered by the CDDL cannot legally be linked together. We urge you not to use the CDDL for this reason.

    For an illustrative example of why you should not combine CDDL-licensed works with the GPL-licensed works, see the FSF's statement, Interpreting, enforcing and changing the GNU GPL, as applied to combining Linux and ZFS.

    Also unfortunate in the CDDL is its use of the term “intellectual property”.
Common Public Attribution License 1.0 (CPAL) (#CPAL)

    This is a free software license. It is based on the Mozilla Public License version 1, and is incompatible with the GPL for the same reasons: it has several requirements for modified versions that do not exist in the GPL. It also requires you to publish the source of the program if you allow others to use it.
Common Public License Version 1.0 (#CommonPublicLicense10)

    This is a free software license. Unfortunately, its weak copyleft and choice of law clause make it incompatible with the GNU GPL.
Condor Public License (#Condor)

    Recent versions of Condor (from 6.9.5 on) are released under the Apache License 2.0. Only older versions of Condor use this license.

    The Condor Public License is a free software license. It has a couple of requirements that make it incompatible with the GNU GPL, including strong restrictions on the use of Condor-related names, and requires redistributors to “represent and warrant” that they will comply with United States export laws. (If it made compliance an actual condition of the license, it would not be a free software license.)
Eclipse Public License Version 1.0 (#EPL)

    The Eclipse Public License is similar to the Common Public License, and our comments on the CPL apply equally to the EPL. The only change is that the EPL removes the broader patent retaliation language regarding patent infringement suits specifically against Contributors to the EPL'd program.
Eclipse Public License Version 2.0 (#EPL2)

    In terms of GPL compatibility, the Eclipse Public License version 2.0 is essentially equivalent to version 1.0. The only change is that it explicitly offers the option of designating the GNU GPL version 2 or later as a “secondary license” for a certain piece of code.

    If an initial contributor releases a specific piece of code and designates GNU GPL version 2 or later as a secondary license, that provides explicit compatibility with those GPL versions for that code. (Doing so is roughly equivalent, for users, to releasing that piece of code under a dual license, EPL | GPL.) However, the EPL2 without this designation remains incompatible with the GPL.
European Union Public License (EUPL) version 1.1 (#EUPL-1.1)

    This is a free software license. By itself, it has a copyleft comparable to the GPL's, and incompatible with it. However, it gives recipients ways to relicense the work under the terms of other selected licenses, and some of those—the Eclipse Public License and the Common Public License in particular—only provide a weaker copyleft. Thus, developers can't rely on this license to provide a strong copyleft.

    The EUPL allows relicensing to GPLv2, because that is listed as one of the alternative licenses that users may convert to. It also, indirectly, allows relicensing to GPL version 3, because there is a way to relicense to the CeCILL v2, and the CeCILL v2 gives a way to relicense to any version of the GNU GPL.

    To do this two-step relicensing, you need to first write a piece of code which you can license under the CeCILL v2, or find a suitable module already available that way, and add it to the program. Adding that code to the EUPL-covered program provides grounds to relicense it to the CeCILL v2. Then you need to write a piece of code which you can license under the GPLv3+, or find a suitable module already available that way, and add it to the program. Adding that code to the CeCILL-covered program provides grounds to relicense it to GPLv3+.
European Union Public License (EUPL) version 1.2 (#EUPL-1.2)

    This is a free software license. By itself, it has a copyleft comparable to the GPL's, and incompatible with it. However, it gives recipients ways to relicense the work under the terms of other selected licenses, and some of those—the Eclipse Public License in particular—only provide a weaker copyleft. Thus, developers can't rely on this license to provide a strong copyleft.

    The EUPL allows relicensing to GPLv2 only and GPLv3 only, because those licenses are listed as two of the alternative licenses that users may convert to. It also, indirectly, allows relicensing to GPL version 3 or any later version, because there is a way to relicense to the CeCILL v2, and the CeCILL v2 gives a way to relicense to any version of the GNU GPL.

    To do this two-step relicensing, you need to first write a piece of code which you can license under the CeCILL v2, or find a suitable module already available that way, and add it to the program. Adding that code to the EUPL-covered program provides grounds to relicense it to the CeCILL v2. Then you need to write a piece of code which you can license under the GPLv3+, or find a suitable module already available that way, and add it to the program. Adding that code to the CeCILL-covered program provides grounds to relicense it to GPLv3+.
Fraunhofer FDK AAC license (#fdk)

    This is a free software license as far as it goes. It is incompatible with any version of the GNU GPL.

    It has a special danger in the form of a term expressly stating it does not grant you any patent licenses, with an invitation to buy some. Because of this, and because the license author is a known patent aggressor, we encourage you to be careful about using or redistributing software under this license: you should first consider whether the licensor might aim to lure you into patent infringement. If you conclude that the program is bait for a patent trap, it would be wise to avoid the program.

    It is possible that the pertinent patents have expired. Depending on whether Fraunhofer still has active patents covering the work, the software might be a trap now, or not. (Of course, any program is potentially threatened by patents, and the only way to end that is to change patent law to make software safe from patents.)
Gnuplot license (#gnuplot)

    This is a free software license, incompatible with the GNU GPL.
IBM Public License, Version 1.0 (#IBMPL)

    This is a free software license. Unfortunately, it has a choice of law clause which makes it incompatible with the GNU GPL.
Jabber Open Source License, Version 1.0 (#josl)

    The license is a free software license, incompatible with the GPL. It permits relicensing under a certain class of licenses, those which include all the requirements of the Jabber license. The GPL is not a member of that class, so the Jabber license does not permit relicensing under the GPL. Therefore, it is not compatible.
LaTeX Project Public License 1.3a (#LPPL-1.3a)

    We have not written a full analysis of this license, but it is a free software license, with less stringent requirements on distribution than LPPL 1.2 (described next). It is still incompatible with the GPL because some modified versions must include a copy of or pointer to an unmodified version.
LaTeX Project Public License 1.2 (#LPPL-1.2)

    This license is an incomplete statement of the distribution terms for LaTeX. As far as it goes, it is a free software license, but incompatible with the GPL because it has many requirements that are not in the GPL.

    This license contains complex and annoying restrictions on how to publish a modified version, including one requirement that falls just barely on the good side of the line of what is acceptable: that any modified file must have a new name.

    The reason this requirement is acceptable for LaTeX is that TeX has a facility to allow you to map file names, to specify “use file bar when file foo is requested”. With this facility, the requirement is merely annoying; without the facility, the same requirement would be a serious obstacle, and we would have to conclude it makes the program nonfree.

    This condition may cause trouble with some major modifications. For example, if you wanted to port an LPPL-covered work to another system that lacked a similar remapping facility, but still required users to request this file by name, you would need to implement a remapping facility too to keep this software free. That would be a nuisance, but the fact that a license would make code nonfree if transplanted into a very different context does not make it nonfree in the original context.

    The LPPL says that some files, in certain versions of LaTeX, may have additional restrictions, which could render them nonfree. For this reason, it may take some careful checking to produce a version of LaTeX that is free software.

    The LPPL makes the controversial claim that simply having files on a machine where a few other people could log in and access them in itself constitutes distribution. We believe courts would not uphold this claim, but it is not good for people to start making the claim.

    Please do not use this license for any other project.

    Note: These comments are for version 1.2 (3 Sep 1999) of the LPPL.
Lucent Public License Version 1.02 (Plan 9 license) (#lucent102)

    This is a free software license, but it is incompatible with the GNU GPL because of its choice of law clause. We recommend that you not use this license for new software that you write, but it is ok to use and improve Plan 9 under this license.
Microsoft Public License (Ms-PL) (#ms-pl)

    This is a free software license; it has a copyleft that is not strong, but incompatible with the GNU GPL. We urge you not to use the Ms-PL for this reason.
Microsoft Reciprocal License (Ms-RL) (#ms-rl)

    This is a free software license. It's based on the Microsoft Public License, and has an additional clause to make the copyleft just a little bit stronger. It's also incompatible with the GNU GPL, and we urge you not to use the Ms-RL for this reason.
Mozilla Public License (MPL) version 1.1 (#MPL)

    This is a free software license which is not a strong copyleft; unlike the X11 license, it has some complex restrictions that make it incompatible with the GNU GPL. That is, a module covered by the GPL and a module covered by the MPL cannot legally be linked together. We urge you not to use the MPL 1.1 for this reason.

    However, MPL 1.1 has a provision (section 13) that allows a program (or parts of it) to offer a choice of another license as well. If part of a program allows the GNU GPL as an alternate choice, or any other GPL-compatible license as an alternate choice, that part of the program has a GPL-compatible license.

    MPL version 2.0 has a number of improvements, including GPL-compatibility by default. See that entry for details.
Netizen Open Source License (NOSL), Version 1.0 (#NOSL)

    This is a free software license that is essentially the same as the Mozilla Public License version 1.1. Like the MPL, the NOSL has some complex restrictions that make it incompatible with the GNU GPL. That is, a module covered by the GPL and a module covered by the NOSL cannot legally be linked together. We urge you not to use the NOSL for this reason.
Netscape Public License (NPL), versions 1.0 and 1.1 (#NPL)

    This is a free software license, not a strong copyleft, and incompatible with the GNU GPL. It consists of the Mozilla Public License version 1.1 with an added clause that permits Netscape to use your added code even in their proprietary versions of the program. Of course, they do not give you permission to use their code in the analogous way. We urge you not to use the NPL. 
Nokia Open Source License (#Nokia)

    This is similar to the Mozilla Public License version 1: a free software license incompatible with the GNU GPL.
Old OpenLDAP License, Version 2.3 (#oldOpenLDAP)

    This is a permissive non-copyleft free software license with a few requirements (in sections 4 and 5) that render it incompatible with the GNU GPL. Note that the latest version of OpenLDAP has a different license that is compatible with the GNU GPL.

    We urge you not to use the older OpenLDAP license for software you write. However, there is no reason to avoid running programs that have been released under this license.
Open Software License, all versions through 3.0 (#OSL)

    The Open Software License is a free software license. It is incompatible with the GNU GPL in several ways.

    Recent versions of the Open Software License have a term which requires distributors to try to obtain explicit assent to the license. This means that distributing OSL software on ordinary FTP sites, sending patches to ordinary mailing lists, or storing the software in an ordinary version control system, is arguably a violation of the license and would subject you to possible termination of the license. Thus, the Open Software License makes it very difficult to develop software using the ordinary tools of free software development. For this reason, and because it is incompatible with the GPL, we recommend that no version of the OSL be used for any software.

    We urge you not to use the Open Software License for software you write. However, there is no reason to avoid running programs that have been released under this license.
OpenSSL license (#OpenSSL)

    Recent versions of OpenSSL (from 3.0.0 on) are released under the Apache License 2.0. Only older versions of OpenSSL use this license.

    The license of OpenSSL is a conjunction of two licenses, one called “OpenSSL License” and the other being the license of SSLeay. You must follow both. The combination results in a copyleft free software license that is incompatible with the GNU GPL. It also has an advertising clause like the original BSD license and the Apache 1 license.

    We recommend using GNUTLS instead of OpenSSL in software you write. However, there is no reason not to use OpenSSL and applications that work with OpenSSL.
Phorum License, Version 2.0 (#Phorum)

    This is a free software license but it is incompatible with the GPL. Section 5 makes the license incompatible with the GPL.
PHP License, Version 3.01 (#PHP-3.01)

    This license is used by most of PHP4. It is a non-copyleft free software license. It is incompatible with the GNU GPL because it includes strong restrictions on the use of “PHP” in the name of derived products.

    We recommend that you not use this license for anything except PHP add-ons.
License of Python 1.6b1 through 2.0 and 2.1 (#PythonOld)

    This is a free software license but is incompatible with the GNU GPL. The primary incompatibility is that this Python license is governed by the laws of the State of Virginia, in the USA, and the GPL does not permit this.
Q Public License (QPL), Version 1.0 (#QPL)

    This is a non-copyleft free software license which is incompatible with the GNU GPL. It also causes major practical inconvenience, because modified sources can only be distributed as patches.

    We recommend that you avoid using the QPL for anything that you write, and use QPL-covered software packages only when absolutely necessary. However, this avoidance no longer applies to Qt itself, since Qt is now also released under the GNU GPL.

    Since the QPL is incompatible with the GNU GPL, you cannot take a GPL-covered program and QPL-covered program and link them together, no matter how.

    However, if you have written a program that uses QPL-covered library (called FOO), and you want to release your program under the GNU GPL, you can easily do that. You can resolve the conflict for your program by adding a notice like this to it:

      As a special exception, you have permission to link this program
      with the FOO library and distribute executables, as long as you
      follow the requirements of the GNU GPL in regard to all of the
      software in the executable aside from FOO.

    You can do this, legally, if you are the copyright holder for the program. Add it in the source files, after the notice that says the program is covered by the GNU GPL.
RealNetworks Public Source License (RPSL), Version 1.0 (#RPSL)

    The RPSL is a free software license that is GPL-incompatible for a number of reasons: it requires that derivative works be licensed under the terms of the RPSL, and mandates that any litigation take place in Seattle, Washington.
Sun Industry Standards Source License 1.1 (#SISSL)

    This is a free software license, not a strong copyleft, which is incompatible with the GNU GPL because of details rather than any major policy.
Sun Public License (#SPL)

    This is essentially the same as the Mozilla Public License version 1: a free software license incompatible with the GNU GPL. Please do not confuse this with the Sun Community Source License, which is not a free software license.
License of xinetd (#xinetd)

    This is a copyleft free software license, incompatible with the GPL. It is incompatible because it places extra restrictions on redistribution of modified versions that contradict the redistribution requirements in the GPL.
Yahoo! Public License 1.1 (#Yahoo)

    This is a free software license. It has a copyleft similar to the one found in the Mozilla Public License. It also has a choice of law clause in section 7. These features both make the license GPL-incompatible. The license also unfortunately uses the term “intellectual property”.
Zend License, Version 2.0 (#Zend)

    This license is used by one part of PHP4. It is a non-copyleft free software license which is incompatible with the GNU GPL, and has practical problems like those of the original BSD license.

    We recommend that you not use this license for anything you write.
Zimbra Public License 1.3 (#Zimbra)

    This license is identical to the Yahoo! Public License 1.1, except that the license is provided by VMWare instead of Yahoo!. Our comments there apply here as well; this is a GPL-incompatible, partial copyleft free software license.
Zope Public License version 1 (#Zope)

    This is a lax, fairly permissive non-copyleft free software license with practical problems like those of the original BSD license, including incompatibility with the GNU GPL.

    We urge you not to use the ZPL version 1 for software you write. However, there is no reason to avoid running programs that have been released under this license, such as previous versions of Zope.

    Version 2.0 of the Zope Public License is GPL-compatible.

Nonfree Software Licenses (#NonFreeSoftwareLicenses)

The following licenses do not qualify as free software licenses. A nonfree license is automatically incompatible with the GNU GPL.

Of course, we urge you to avoid using nonfree software licenses, and to avoid nonfree software in general.

There is no way we could list all the known nonfree software licenses here; after all, every proprietary software company has its own. We focus here on licenses that are often mistaken for free software licenses but are, in fact, not free software licenses.

We have provided links to these licenses when we can do so without violating our general policy: that we do not make links to sites that promote, encourage or facilitate the use of nonfree software packages. The last thing we want to do is give any nonfree program some gratis publicity that might encourage more people to use it. For the same reason, we have avoided naming the programs for which a license is used, unless we think that for specific reasons it won't backfire.

No license (#NoLicense)

    If source code does not carry a license to give users the four essential freedoms, then unless it has been explicitly and validly placed in the public domain, it is not free software.

    Some developers think that code with no license is automatically in the public domain. That is not true under today's copyright law; rather, all copyrightable works are copyrighted by default. This includes programs. Absent a license to grant users freedom, they don't have any. In some countries, users that download code with no license may infringe copyright merely by compiling it or running it.

    In order for a program to be free, its copyright holders must explicitly grant users the four essential freedoms. The document with which they do so is called a free software license. This is what free software licenses are for.

    Some countries allow authors to put code in the public domain, but that requires explicit action. If you wish to do that, the method we recommend is to use CC0, which also works in other countries by putting on a license that is more or less equivalent to public domain. However, in most cases it is better to copyleft your code to assure that freedom reaches all users of the code.

    Code written by employees of the US government is a special exception, since US copyright law explicitly puts that in the public domain; but this does not apply to works that the US pays a company to write. It also does not apply to other countries, many of which do allow the state to have a copyright on government writings.
Aladdin Free Public License (#Aladdin)

    Despite its name, this is not a free software license because it does not allow charging for distribution, and largely prohibits simply packaging software licensed under it with anything for which a charge is made.
Anti-996 License (#Anti-996)

    This is not a free software license. It places restrictions on the freedom to use the program for any purpose.

    Please do not use this license for your own software. We will avoid using software under this license, as we do all other nonfree software.
Anti-Capitalist Software License (#anticapitalist)

    The Anti-Capitalist Software License is a nonfree license because it extends the four freedoms only to some kinds of organizations, not to all. Such a restriction in a software license, in the name of any cause whatsoever, imposes too much power over users. Please don't use this license, and we urge you to avoid any software that has been released under it.
Apple Public Source License (APSL), version 1.x (#apsl1)

    Versions 1.0, 1.1 and 1.2 are not free software licenses. Please don't use these licenses, and we urge you to avoid any software that has been released under them. Version 2.0 of the APSL is a free software license.
Artistic License 1.0 (#ArtisticLicense)

    We cannot say that this is a free software license because it is too vague; some passages are too clever for their own good, and their meaning is not clear. We urge you to avoid using it, except as part of the disjunctive license of Perl.
AT&T Public License (#ATTPublicLicense)

    The AT&T Public License is a nonfree license. It has several serious problems:

        The patent license is voided by any modification, no matter how small, of the pertinent code.
        You must demand a written agreement when you distribute the sources or patches.
        It requires notifying AT&T if you distribute a patch.
        Your license can be terminated through no fault of yours, under section 8/3.
        It makes compliance with export control laws a condition of the license.
        Some versions of the license require you to provide support.
        Some versions of the license say you cannot sell a copy of the software for more than the expense of distribution.

    The license has two other obnoxious features:

        It has a very broad reverse license to AT&T, which goes far beyond the use of your code, even your code modified.
        It asserts one needs a license from AT&T to make a link to their web site. This is not an immediate practical problem, since the license says it gives permission to make such a link. (Anyway, people shouldn't make links to sites about nonfree software.) But such a claim should not be made or propagated.

Code Project Open License, version 1.02 (#cpol)

    The Code Project Open License is not a free software license. Section 5.6 restricts how you can use the work. Section 5.4 prohibits commercial distribution of the software by itself—and depending on how you read section 3.4, you may not have permission to distribute the software by itself at all.
Commons Clause (#comclause)

    The “Commons Clause” is a nonfree license because it forbids selling copies of the program, and even running the program as part of implementing any commercial service. Adding insult to injury, it also twists the words “commons” and “sell.”

    We urge people to reject programs under this license and to develop free replacements. Where a previous version was available as free software, continuing development of that version is an option.
CNRI Digital Object Repository License Agreement (#DOR)

    This license is nonfree because of Article 3, which arguably includes a requirement not to violate the license of any program that the user runs—even proprietary programs.
eCos Public License, version 1.1 (#eCos11)

    This was the old license of eCos. It is not a free software license, because it requires sending every published modified version to a specific initial developer. There are also some other words in this license whose meaning we're not sure of that might also be problematic.

    Today eCos is available under the GNU GPL with additional permission for linking with nonfree programs.
The Hippocratic License 1.1 (#hippocratic)

    This is not a free software license, because it restricts what jobs users can use the software for. That denies freedom 0. This entry was previously listed as the First Do No Harm license.
GPL for Computer Programs of the Public Administration (#GPL-PA)

    The GPL-PA (whose original name in Portuguese is “Licença Pública Geral para Administração Pública”) is nonfree for several reasons:

        It permits use only in “normal circumstances”.
        It does not allow distribution of source code without binaries.
        Its permissions lapse after 50 years.

Hacktivismo Enhanced-Source Software License Agreement (HESSLA) (#HESSLA)

    This is not a free software license, because it restricts what jobs people can use the software for, and restricts in substantive ways what jobs modified versions of the program can do.
Jahia Community Source License (#Jahia)

    The Jahia Community Source License is not a free software license. Use of the source code is limited to research purposes.
The JSON License (#JSON)

    This is the license of the original implementation of the JSON data interchange format. This license uses the Expat license as a base, but adds a clause mandating: “The Software shall be used for Good, not Evil.” This is a restriction on usage and thus conflicts with freedom 0. The restriction might be unenforcible, but we cannot presume that. Thus, the license is nonfree.
Old license of ksh93 (#ksh93)

    ksh93 used to be shipped with an original license that was not a free software license. One reason for this is that it required that all changes be sent to the developer.
License of Lha (#Lha)

    The lha license must be considered nonfree because it is so vague that you cannot be sure what permissions you have.
Microsoft's Shared Source CLI, C#, and Jscript License (#Ms-SS)

    This license does not permit commercial distribution, and only allows commercial use under certain circumstances.

    Microsoft has other licenses which it describes as “Shared Source”, some of which have different restrictions.
NASA Open Source Agreement (#NASA)

    The NASA Open Source Agreement, version 1.3, is not a free software license because it includes a provision requiring changes to be your “original creation”. Free software development depends on combining code from third parties, and the NASA license doesn't permit this.

    We urge you not to use this license. In addition, if you are a United States citizen, please write to NASA and call for the use of a truly free software license.
Oculus Rift SDK License (#OculusRiftSDK)

    This is not a free software license; it has several fatal flaws.

        One can't redistribute anything less than the whole program libOVR.
        One's distribution rights can be terminated on vague conditions.
        Those who make modified versions are required to send them to Oculus on demand.
        Use is allowed only with their product.
        New license versions totally supplant old versions, which means that permissions already given can be withdrawn.

    There might be additional fatal flaws; after seeing this many, we stopped looking for more. 
Open Public License (#OpenPublicL)

    This is not a free software license, because it requires sending every published modified version to a specific initial developer. There are also some other words in this license whose meaning we're not sure of that might also be problematic.
Peer-Production License (#PPL)

    The Peer-Production License is not a free software license because it restricts who can redistribute the program and for what purpose. It also does not give anyone permission to run the program.

    The PPL has several provisions designed specifically for artistic performances, and we have nothing against its use for art works; however, people reportedly advocate its use for software too. The PPL should not be used for software, manuals, or other works that ought to be free.
Personal Public License Version 3a (#PPL3a)

    The Personal Public License Version 3a is a nonfree license because it denies some users (organizations, governments, businesses) the four freedoms.
License of PINE (#PINE)

    The license of PINE is not a free software license because it mostly prohibits the distribution of modified versions. It also restricts the media that can be used for selling copies.

    Please note that a successor to Pine, Alpine, is released under the Apache License, version 2.0.
Old Plan 9 license (#Plan9)

    This is not a free software license; it lacks essential freedoms such as the right to make and use private changes. Of course you should not use this license, and we urge you to avoid any software that has been released under it. A detailed discussion of this license is also available.

    In September 2002 it was observed that the published license for Plan 9 had been modified, adding more restrictions to it, although its date still said 09/20/00. However, a further license change in 2003 made Plan 9 free software.
Reciprocal Public License (#RPL)

    The Reciprocal Public License is a nonfree license because of three problems. 1. It puts limits on prices charged for an initial copy. 2. It requires notification of the original developer for publication of a modified version. 3. It requires publication of any modified version that an organization uses, even privately.
Scilab license (#Scilab)

    This is not a free software license because it does not allow commercial distribution of a modified version. Thankfully, starting from version 5.0.0, the Scilab software is free software, released under CeCILL version 2.
Scratch 1.4 license (#Scratch)

    This is not a free software license because it does not allow commercial redistribution. In addition, condition 4 substantively restricts the functionality of modified versions.

    Newer versions Scratch software are distributed under the GNU GPL, but some of those newer version we do not recommend, because they depend on the proprietary software, Adobe Air. 
Simple Machines License (#SML)

    Despite the name, this is a software license, and it's nonfree for several reasons:

        You must get the licensor's permission before distributing the software.
        You cannot sell copies of the software.
        It's possible that your license can be terminated if you received the software from someone who did not obey the license's terms.

Old Squeak license (#Squeak)

    The original Squeak license, as applied to software, is not a free software license because it requires all users in whatever country to obey US export control laws. As applied to fonts, it also does not permit modification.

    In addition, it has a requirement for users to indemnify the developer, which is enough to make many users think twice about using it at all.

    Recent versions of Squeak (from 4.0 on) are released under an Expat-style License with some portions of the code under the Apache License 2.0.
Sun Community Source License (#SunCommunitySourceLicense)

    This is not a free software license; it lacks essential freedoms such as publication of modified versions. Please don't use this license, and we urge you to avoid any software that has been released under it.
Sun Solaris Source Code (Foundation Release) License, Version 1.1 (#SunSolarisSourceCode)

    This is not a free software license. The license prohibits redistribution, prohibits commercial use of the software, and can be revoked.
Sybase Open Watcom Public License version 1.0 (#Watcom)

    This is not a free software license. It requires you to publish the source code publicly whenever you “Deploy” the covered software, and “Deploy” is defined to include many kinds of private use.
SystemC “Open Source” License, Version 3.0 (#SystemC-3.0)

    This license requires all recipients to proactively help the licensor enforce its trademarks. This is an unreasonable condition to place on users' rights, so the license is nonfree. It also has other practical problems: some of the requirements are vague, and it uses the term “intellectual property”.

    Despite the name, it is not clear whether this license would qualify as “open source”. However, our judgment of it is not based on that. 
Truecrypt license 3.0 (#Truecrypt-3.0)

    This license is nonfree for several reasons. It says that if you don't understand the license you may not use the program. It puts conditions on allowing others to run your copy. It puts conditions on separate programs that “depend on” Truecrypt. The trademark condition applies to “associated materials”.

    There are other points in the license which seem perhaps unacceptable, and in our uncertainty about them we delayed in posting our evaluation. We have posted it now to explain why we do not mourn the demise of Truecrypt. There are free programs that do the same job.
University of Utah Research Foundation Public License (#UtahPublicLicense)

    The University of Utah Research Foundation Public License is a nonfree license because it does not allow commercial redistribution. It also purports to restrict commercially running the software and even commercially giving consultation about it. Those restrictions are probably not legally enforceable under US copyright law, but they might be in some countries; even asserting them is outrageous.

    The use of this license by the University of Utah exemplifies a dangerous trend for universities to restrict knowledge rather than contributing it to the public.

    If a university tries to impose a license like this on the software you are writing, don't give up hope. With persistence and firmness, and some forethought, it is possible to prevail over money-grabbing university administrators.

    The earlier you raise the issue, the better.
YaST License (#YaST)

    This is not a free software license. The license prohibits distribution for a fee, and that makes it impossible for the software to be included in the many CD-ROM free software collections that are sold by companies and by organizations.

    There may be another problem in section 2a, but a word seems to be missing there, so it is hard to be sure what meaning is really intended.

    (The YaST software itself no longer uses this nonfree YaST license; happily, it is now free software, released under the GNU GPL.)

Licenses For Documentation
Free Documentation Licenses (#FreeDocumentationLicenses)

The following licenses qualify as free documentation licenses.

GNU Free Documentation License (#FDL)

    This is a license intended for use on copylefted free documentation. We plan to adopt it for all GNU manuals. It is also suitable for other kinds of useful works (such as textbooks and dictionaries, for instance). Its applicability is not limited to textual works (“books”).
FreeBSD Documentation License (#FreeBSDDL)

    This is a permissive non-copyleft free documentation license that is compatible with the GNU FDL.

Apple's Common Documentation License, Version 1.0 (#ACDL)

    This is a free documentation license that is incompatible with the GNU FDL. It is incompatible because Section (2c) says “You add no other terms or conditions to those of this License”, and the GNU FDL has additional terms not accounted for in the Common Documentation License.
Open Publication License, Version 1.0 (#OpenPublicationL)

    This license can be used as a free documentation license. It is a copyleft free documentation license provided the copyright holder does not exercise any of the “LICENSE OPTIONS” listed in Section VI of the license. But if either of the options is invoked, the license becomes nonfree. In any case, it is incompatible with the GNU FDL.

    This creates a practical pitfall in using or recommending this license: if you recommend “Use the Open Publication License, Version 1.0 but don't enable the options”, it would be easy for the second half of that recommendation to get forgotten; someone might use the license with the options, making a manual nonfree, and yet think he or she is following your advice.

    Likewise, if you use this license without either of the options to make your manual free, someone else might decide to imitate you, then change his or her mind about the options thinking that that is just a detail; the result would be that his or her manual is nonfree.

    Thus, while manuals published under this license do qualify as free documentation if neither license option was used, it is better to use the GNU Free Documentation License and avoid the risk of leading someone else astray.

    Please note that this license is not the same as the Open Content License. These two licenses are frequently confused, as the Open Content License is often referred to as the “OPL”. For clarity, it is better not to use the abbreviation “OPL” for either license. It is worth spelling their names in full to make sure people understand what you say.

Nonfree Documentation Licenses (#NonFreeDocumentationLicenses)

The following licenses do not qualify as free documentation licenses:

Open Content License, Version 1.0 (#OpenContentL)

    This license does not qualify as free, because there are restrictions on charging money for copies. We recommend you do not use this license.

    Please note that this license is not the same as the Open Publication License. The practice of abbreviating “Open Content License” as “OPL” leads to confusion between them. For clarity, it is better not to use the abbreviation “OPL” for either license. It is worth spelling their names in full to make sure people understand what you say.
Creative Commons NonCommercial, any version (#CC-BY-NC)

    This license does not qualify as free, because there are restrictions on charging money for copies. Thus, we recommend you do not use this license for documentation.

    In addition, it has a drawback for any sort of work: when a modified version has many authors, in practice getting permission for commercial use from all of them would become infeasible.
Creative Commons Noderivatives, any version (#CC-BY-ND)

    This license does not qualify as free, because there are restrictions on distributing modified versions. We recommend you do not use this license for documentation.

Licenses for Other Works
Licenses for Works of Practical Use besides Software and Documentation (#OtherLicenses)

GNU General Public License (#GPLOther)

    The GNU GPL can be used for general data which is not software, as long as one can determine what the definition of “source code” refers to in the particular case. As it turns out, the DSL (see below) also requires that you determine what the “source code” is, using approximately the same definition that the GPL uses.

GNU Free Documentation License (#FDLOther)

    The GNU FDL is recommended for textbooks and teaching materials for all topics. (“Documentation” simply means textbooks and other teaching materials for using equipment or software.) We also recommend the GNU FDL for dictionaries, encyclopedias, and any other works that provide information for practical use.

CC0 (#CC0)

    CC0 is a public domain dedication from Creative Commons. A work released under CC0 is dedicated to the public domain to the fullest extent permitted by law. If that is not possible for any reason, CC0 also provides a lax, permissive license as a fallback. Both public domain works and the lax license provided by CC0 are compatible with the GNU GPL.

    If you want to release your non-software work to the public domain, we recommend you use CC0. For works of software it is not recommended, as CC0 has a term expressly stating it does not grant you any patent licenses.

    Because of this lack of patent grant, we encourage you to be careful about using software under this license; you should first consider whether the licensor might want to sue you for patent infringement. If the developer is refusing users patent licenses, the program is in effect a trap for users and users should avoid the program.
Creative Commons Attribution 4.0 license (a.k.a. CC BY) (#ccby)

    This is a non-copyleft free license that is good for art and entertainment works, and educational works. It is compatible with all versions of the GNU GPL; however, like all CC licenses, it should not be used on software.

    (#which-cc) Creative Commons publishes many licenses which are very different. Therefore, to say that a work “uses a Creative Commons license” is to leave the principal questions about the work's licensing unanswered. When you see such a statement in a work, please ask the author to change the work to state clearly and visibly which of the Creative Commons license it uses. And if someone proposes to “use a Creative Commons license” for a certain work, it is vital to ask “Which Creative Commons license?” before proceeding any further.

Creative Commons Attribution-Sharealike 4.0 license (a.k.a. CC BY-SA) (#ccbysa)

    This is a copyleft free license that is good for artistic and entertainment works, and educational works. Like all CC licenses, it should not be used on software.

    CC BY-SA 4.0 is one-way compatible with the GNU GPL version 3: this means you may license your modified versions of CC BY-SA 4.0 materials under GNU GPL version 3, but you may not relicense GPL 3 licensed works under CC BY-SA 4.0.

    Because Creative Commons lists only version 3 of the GNU GPL on its compatible licenses list, it means that you can not license your adapted CC BY-SA works under the terms of “GNU GPL version 3, or (at your option) any later version.” However, Section 14 of the GNU GPL version 3 allows licensors to specify a proxy to determine whether future versions of the GNU GPL can be used. Therefore, if someone adapts a CC BY-SA 4.0 work and incorporates it into a GNU GPL version 3 licensed project, they can specify Creative Commons as their proxy (via http://creativecommons.org/compatiblelicenses) so that if and when Creative Commons determines that a future version of the GNU GPL is a compatible license, the adapted and combined work could be used under that later version of the GNU GPL.

    Please be specific about which Creative Commons license is being used.
Design Science License (DSL) (#dsl)

    This is a free and copyleft license meant for general data. Please don't use it for software or documentation, since it is incompatible with the GNU GPL and with the GNU FDL; however, it is fine to use for other kinds of data.
Free Art License (#FreeArt)

    This is a free and copyleft license meant for artistic works. It permits commercial distribution, as any free license must. It is a copyleft license because any larger work that includes part of the work you received must be released, as a whole, either under the same license or under a similar license that meets stated criteria. Please don't use it for software or documentation, since it is incompatible with the GNU GPL and with the GNU FDL.
Open Database license (#ODbl)

    This is a free and copyleft license meant for data. It is incompatible with the GNU GPL. Please don't use it for software or documentation, since it is incompatible with the GNU GPL and with the GNU FDL. It makes inconvenient requirements about signing contracts which try to create an effect like copyleft for data that is not copyrightable, so we don't recommend using it; however, there is no reason to avoid using data released this way.

Licenses for Fonts (#Fonts)

The licenses below apply to an instantiation of a design in a computer file, not the artistic design. As far as we know, an implementation of a design is always copyrightable. The legal status of the artistic design is complex, and varies by jurisdiction.

GNU General Public License (#GPLFonts)

    The GNU GPL can be used for fonts. However, note that it does not permit embedding the font in a document unless that document is also licensed under the GPL. If you want to allow this, use the font exception. See also this explanatory essay about the GPL Font Exception.

Arphic Public License (#Arphic)

    This is a copyleft free software license, incompatible with the GPL. Its normal use is for fonts, and in that use, the incompatibility does not cause a problem.
License of the ec fonts for LaTeX (#ecfonts)

    This license covers the European Computer Modern Fonts and Text Companion Fonts, commonly used with LaTeX. Depending on how it is used, it may be free or not. If the package says that some fonts in the package may not be modified, then the package is nonfree. Otherwise the package is free. The original fonts have no restrictions on modification, so they are free.

    Much like the LaTeX Project Public License 1.2, this license requires modified versions of the work to use a name that's different from the name of any prior version. This is acceptable for work meant to be used with LaTeX, since TeX allows you to create filename mappings for your programs, but it's very annoying and could be overly burdensome in other contexts.
IPA Font License (#IPAFONT)

    This is a copyleft free software license, incompatible with the GPL. It has an unfortunate condition requiring that derivative works not use or include the name of the original work as a program name, font name or file name. This is acceptable for fonts as fonts can be aliased or renamed using free software tools, but it's very annoying and could be overly burdensome in other contexts.
SIL Open Font License 1.1 (#SILOFL)

    The Open Font License (including its original release, version 1.0) is a free copyleft license for fonts. Its only unusual requirement is that when selling the font, you must redistribute it bundled with some software, rather than alone. Since a simple Hello World program will satisfy the requirement, it is harmless. Neither we nor SIL recommend the use of this license for anything other than fonts.

Licenses for Works stating a Viewpoint (e.g., Opinion or Testimony) (#OpinionLicenses)

Works that express someone's opinion—memoirs, editorials, and so on—serve a fundamentally different purpose than works for practical use like software and documentation. Because of this, we expect them to provide recipients with a different set of permissions: just the permission to copy and distribute the work verbatim. Richard Stallman discusses this frequently in his speeches.

Because so many licenses meet these criteria, we cannot list them all. If you are looking for one to use yourself, however, there are two that we recommend:

GNU Verbatim Copying License (#GNUVerbatim)

    This was the license used throughout the GNU web site for many years. It is very simple, and especially well-suited to written works.
Creative Commons Attribution-NoDerivs 4.0 license (a.k.a. CC BY-ND) (#ccbynd)

    This is the license used throughout the GNU and FSF web sites. This license provides much the same permissions as our verbatim copying license, but it's much more detailed. We particularly recommend it for audio and/or video works of opinion. Previous versions of this license are also OK to use, but we do recommend upgrading to this version if you can. Please be specific about which Creative Commons license is being used.

Licenses for Designs for Physical Objects (#Designs)

Circuits are meant for practical use, so circuit designs should carry a free license. We recommend releasing them under the GNU General Public License, version 3 or later. Version 3 was designed for such use.

3D-printer plans for objects meant for practical use should also be free. We recommend the GNU GPL or one of the Creative Commons licenses that are free: CC-BY, CC-BY-SA, or CC0.

3D-printer plans for decorative objects are artistic works; any of the Creative Commons licenses is ok for them.

## 🎁 Expressions of gratitude

* Tell other people about this project 📢;
* Invite someone from the team for a soda 🍺;
* A public thank you 🫂;
* etc.


---
