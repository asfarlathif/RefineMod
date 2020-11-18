#' Model Optimization to significant predictors
#'
#' lm_significant is used to optimize a multiple linear regression model to only those predictor variables that are statistically significant for building that model. The function currently only supports additive model linear regressions.
#'
#' @param data a data frame object containing the variables to be used as response and predictors in the model.
#' @param res a character vector of length 1 that matches the name of the response variable column in data. Response variable in the data must be of numeric type.
#' @param preds a character vector of predictor variables in the data. When not specified function will take all variables in data other than response variable as input predictors to start with. A default of NULL is given to this argument to provide the flexibility of using either user defined predictor variables or all but response variable as predictors from the data.
#' @param p a numeric value that denotes the threshold for selecting the predictors based on their statistical significance in building the model. Default p-value threshold is 0.01.
#' @param verbose a logical value denoting whether or not to print progress messages as the function is being run. Default is TRUE
#' @param all if TRUE, the function will return a list with two lm model objects. The first one is the original call with all the input predictors and the second is the model with only the significant predictors. The default is FALSE which returns a single lm object with only the significant predictors
#' @param ... additional arguments to be passed to the inner lm() function calls. Refer to the documentation of lm() for more details on those arguments
#'
#' @return
#' The function will return a list with two lm model objects is all = TRUE. The first one is the original call with all the input predictors and the second is the model with only the significant predictors.
#'
#' If all = FALSE the function returns a single lm object with only the significant predictors
#'
#'
#' @export
#'
#' @examples
#' #cancer_sample data from datateachr package
#'
#' library(datateachr)
#'
#' sig_mod1 <- lm_significant(cancer_sample[,-2], res = "radius_mean")
#'
#' #Both the original model and optimized model
#'
#' sig_mod2 <- lm_significant(mtcars, res = "mpg", all = TRUE)
#'
lm_significant <- function(data, res, preds = NULL, p = 0.01, verbose = TRUE, all = FALSE, ...){

  #CHECKING IF THE RESPONSE VARIABLE IS NUMERIC -- ERROR MESSAGE IS PRODUCED FOR NON NUMERIC RESPONSE VARIABLE USING stop()
  if(!is.numeric(data[[res]]))
    stop("Responce Variable must be numeric")

  #USER DEFINED PEDICTORS OR ALL PREDICTORS FROM THE DATA
  if(!is.null(preds))
  {
    predictors <- preds
  }

  else
  {
    variables <- names(data)

    predictors <- variables[variables != res]
  }

  modelFit <- list()

  #LINAER MODEL WITH ALL INPUT PREDICTORS

  x <- paste0(predictors,collapse = "+")

  form <- stats::as.formula(paste(res, "~", x))

  modelFit$`All Predictors` <- stats::lm(formula = form, data = data, ...)

  #LINEAR MODEL WITH ONLY THE OPTIMIZED PREDICTORS

  predictors <- sig_pred(data = data, res = res, preds = preds, p = p, verbose = verbose, ...)

  x1 <- paste0(predictors,collapse = "+")

  form1 <- stats::as.formula(paste(res, "~", x1))

  modelFit$`Opt Predictors` <- stats::lm(formula = form1, data = data, ...)

  if(verbose) cat("\n\nFinal Optimized Predictors:", predictors, "\n")

  if(all)
    modelFit
  else
    modelFit$`Opt Predictors`
}
