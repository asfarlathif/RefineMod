% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/sig_pred.R
\name{sig_pred}
\alias{sig_pred}
\title{Significant Predictors in an lm model}
\usage{
sig_pred(data, res, preds = NULL, p = 0.01, verbose = FALSE, ...)
}
\arguments{
\item{data}{a data frame object containing the variables to be used as response and predictors in the model.}

\item{res}{a character vector of length 1 that matches the name of the response variable column in data. Response variable in the data must be of numeric type.}

\item{preds}{a character vector of predictor variables in the data. When not specified function will take all variables in data other than response variable as input predictors to start with. A default of NULL is given to this argument to provide the flexibility of using either user defined predictor variables or all but response variable as predictors from the data.}

\item{p}{a numeric value that denotes the threshold for selecting the predictors based on their statistical significance in building the model. Default p-value threshold is 0.01.}

\item{verbose}{a logical value denoting whether or not to print progress messages as the function is being run. Default is TRUE}

\item{...}{additional arguments to be passed to the inner lm() function calls. Refer to the documentation of lm() for more details on those arguments}
}
\value{
A character vector with the names of all the significant predictors from the original lm call.
}
\description{
This function finds all the predictor variables that are significant to a linear regression model from the input predictors
}
\examples{
#cancer_sample data from datateachr package
library(datateachr)

sig_mod <- sig_pred(cancer_sample[,-2], res = "radius_mean")

}
