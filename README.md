
<!-- README.md is generated from README.Rmd. Please edit that file -->

# RefineMod

<!-- badges: start -->

[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![packageversion](https://img.shields.io/badge/Package%20version-0.1.0-blue.svg?style=flat-square)](commits/master)

<!-- badges: end -->

The goal of RefineMod is to provide functions to refine and optimize
linear regression models. Models can be refined to only those predictors
that are statistically significant in explaining the response variable.
Linear regression models can also be compared on the basis of their
performance like RMSE, R2 and MAE. Package website
[RefineMod](https://asfarlathif.github.io/RefineMod/)

## Package Development

This package was developed as an assignment for **STAT545B** at UBC
using `devtools` and `usethis` packages.

The codes and pipeline used to create this package is as follows

``` r
usethis::create_package(path = "RefineMod") #To initiate the package project locally

usethis::use_git() #To create a git repository of the package locally
```

This local repo is then linked to an empty github repository created
with the same name `RefineMod`

    git remote add origin https://github.com/asfarlathif/RefineMod.git
    git branch -M main
    git push -u origin main

``` r
usethis::use_r("function name") #To create script files of the functions in this package

#All the functions were documented using the roxygen skeleton

devtools::document() #To record the documentation files and update NAMESPACE

usethis::use_readme_rmd() #README file initiation

usethis::use_mit_license() #LICENSE file

usethis::use_code_of_conduct() #CODE OF CONDUCT file

usethis::use_testthat() #To Create tests to include test scripts for the functions
usethis::use_test("function name") #intialize Funstion specific test scripts

usethis::use_package("package name") #To include package dependencies in the DESCRIPTION file

usethis::use_vignette("vignette name") #Initialize vignette RMD file

usethis::use_news_md() #Adding Changelogs

#PACKAGE DIAGNOSIS

devtools::test() #Run all testthat files
devtools::check() #Head to Toe evaluation of the package
```

## Installation

The development version of RefineMod can be installed from
[GitHub](https://github.com/) with:

``` r
devtools::install_github("asfarlathif/RefineMod")
```

## Example

### Refining a linear regression model with only its significant predictors

`cancer_sample` data set from `datateachr` package

`radius_mean` as response variable and all (except `diagnosis`) as input
predictors

``` r
library(RefineMod)
library(datateachr)

mod <- lm(radius_mean ~ ., cancer_sample[,-2]) #lm() call without any predictor selection

summary(mod)
#> 
#> Call:
#> lm(formula = radius_mean ~ ., data = cancer_sample[, -2])
#> 
#> Residuals:
#>      Min       1Q   Median       3Q      Max 
#> -0.34069 -0.02957  0.00027  0.02509  0.23880 
#> 
#> Coefficients:
#>                           Estimate Std. Error t value Pr(>|t|)    
#> (Intercept)              4.076e-01  1.049e-01   3.886 0.000115 ***
#> ID                      -4.588e-12  2.064e-11  -0.222 0.824201    
#> texture_mean             4.605e-04  1.975e-03   0.233 0.815756    
#> perimeter_mean           1.339e-01  2.359e-03  56.748  < 2e-16 ***
#> area_mean                9.010e-04  1.246e-04   7.230 1.67e-12 ***
#> smoothness_mean          1.835e+00  4.950e-01   3.706 0.000232 ***
#> compactness_mean        -3.810e+00  2.879e-01 -13.233  < 2e-16 ***
#> concavity_mean          -1.567e+00  2.510e-01  -6.244 8.64e-10 ***
#> concave_points_mean      1.836e-01  4.918e-01   0.373 0.708981    
#> symmetry_mean            2.726e-01  1.842e-01   1.480 0.139370    
#> fractal_dimension_mean   2.274e+00  1.381e+00   1.646 0.100249    
#> radius_se                1.228e-01  7.706e-02   1.594 0.111590    
#> texture_se               1.449e-02  9.148e-03   1.584 0.113744    
#> perimeter_se            -4.591e-02  1.002e-02  -4.580 5.78e-06 ***
#> area_se                  3.497e-04  3.492e-04   1.001 0.317079    
#> smoothness_se            1.970e+00  1.649e+00   1.195 0.232579    
#> compactness_se          -5.029e-01  5.388e-01  -0.933 0.351066    
#> concavity_se             1.283e+00  3.185e-01   4.029 6.42e-05 ***
#> concave_points_se        3.246e+00  1.352e+00   2.401 0.016669 *  
#> symmetry_se              4.777e-02  6.780e-01   0.070 0.943859    
#> fractal_dimension_se    -2.915e+00  2.900e+00  -1.005 0.315145    
#> radius_worst             1.598e-01  1.265e-02  12.633  < 2e-16 ***
#> texture_worst           -1.627e-03  1.725e-03  -0.943 0.346078    
#> perimeter_worst         -9.250e-03  1.420e-03  -6.515 1.68e-10 ***
#> area_worst              -5.744e-04  7.548e-05  -7.610 1.24e-13 ***
#> smoothness_worst        -1.108e+00  3.533e-01  -3.137 0.001799 ** 
#> compactness_worst        3.505e-01  9.401e-02   3.729 0.000213 ***
#> concavity_worst          1.275e-02  6.674e-02   0.191 0.848587    
#> concave_points_worst     1.892e-02  2.272e-01   0.083 0.933684    
#> symmetry_worst          -8.857e-02  1.228e-01  -0.721 0.471035    
#> fractal_dimension_worst -4.446e-01  5.919e-01  -0.751 0.452838    
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
#> 
#> Residual standard error: 0.05869 on 538 degrees of freedom
#> Multiple R-squared:  0.9997, Adjusted R-squared:  0.9997 
#> F-statistic: 6.824e+04 on 30 and 538 DF,  p-value: < 2.2e-16
```

Above is the model built using all the input predictors as the
independent variables while building the model. Many of these variables
don’t show any statistical significance (in terms of their p-value) to
be included in the model.

``` r

sig_mod <- lm_significant(cancer_sample[,-2], res = "radius_mean") #model with optimized predictors
#> 
#> Response Variable: radius_mean 
#> 
#> Input Predictors: ID texture_mean perimeter_mean area_mean smoothness_mean compactness_mean concavity_mean concave_points_mean symmetry_mean fractal_dimension_mean radius_se texture_se perimeter_se area_se smoothness_se compactness_se concavity_se concave_points_se symmetry_se fractal_dimension_se radius_worst texture_worst perimeter_worst area_worst smoothness_worst compactness_worst concavity_worst concave_points_worst symmetry_worst fractal_dimension_worst 
#> 
#> Fitting a linear model 
#> 
#> Optimization of Predictors
#> ....
#> 
#> Final Optimization...
#> 
#> 
#> Final Optimized Predictors: perimeter_mean compactness_mean radius_worst area_worst concavity_mean perimeter_worst compactness_worst

summary(sig_mod)
#> 
#> Call:
#> stats::lm(formula = form1, data = data)
#> 
#> Residuals:
#>      Min       1Q   Median       3Q      Max 
#> -0.43905 -0.03010 -0.00420  0.03113  0.27932 
#> 
#> Coefficients:
#>                     Estimate Std. Error t value Pr(>|t|)    
#> (Intercept)        4.401e-01  3.107e-02  14.166  < 2e-16 ***
#> perimeter_mean     1.487e-01  5.931e-04 250.709  < 2e-16 ***
#> compactness_mean  -3.926e+00  1.559e-01 -25.182  < 2e-16 ***
#> radius_worst       1.462e-01  7.390e-03  19.778  < 2e-16 ***
#> area_worst        -1.897e-04  3.205e-05  -5.918 5.68e-09 ***
#> concavity_mean    -6.334e-01  9.568e-02  -6.620 8.39e-11 ***
#> perimeter_worst   -1.671e-02  1.020e-03 -16.381  < 2e-16 ***
#> compactness_worst  2.310e-01  4.123e-02   5.602 3.32e-08 ***
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
#> 
#> Residual standard error: 0.06754 on 561 degrees of freedom
#> Multiple R-squared:  0.9996, Adjusted R-squared:  0.9996 
#> F-statistic: 2.208e+05 on 7 and 561 DF,  p-value: < 2.2e-16
```

`perimeter_mean`, `compactness_mean`, `radius_worst`, `area_worst`,
`concavity_mean`, `perimeter_worst` and `compactness_worst` are the
predictors that were found to be statistically significant while
building a model for the response variable `radius_mean`.

### Comparing Model Performance between one or more lm models

``` r

train <- mtcars[1:20,]
test <- mtcars[21:30,]

mod1 <- lm(mpg~wt, train)
mod2 <- lm(mpg~cyl, train)
mod3 <- lm(mpg~wt+cyl, train)
mod4 <- lm(mpg~carb, train)

comp_mods(mod1, mod2, mod3, mod4, newdata = test)
#>            RMSE     Rsquared      MAE
#> model1 7.558188 0.0276731943 6.090093
#> model2 8.893606 0.0006549141 7.565000
#> model3 8.315105 0.0044296323 6.741422
#> model4 9.741102 0.1946252582 7.860596
```

## Code of Conduct

Please note that the RefineMod project is released with a [Contributor
Code of
Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
