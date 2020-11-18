#' Significant Predictors in an lm model
#'
#' This function finds all the predictor variables that are significant to a linear regression model from the input predictors
#'
#' @param data a data frame object containing the variables to be used as response and predictors in the model.
#' @param res a character vector of length 1 that matches the name of the response variable column in data. Response variable in the data must be of numeric type.
#' @param preds a character vector of predictor variables in the data. When not specified function will take all variables in data other than response variable as input predictors to start with. A default of NULL is given to this argument to provide the flexibility of using either user defined predictor variables or all but response variable as predictors from the data.
#' @param p a numeric value that denotes the threshold for selecting the predictors based on their statistical significance in building the model. Default p-value threshold is 0.01.
#' @param verbose a logical value denoting whether or not to print progress messages as the function is being run. Default is TRUE
#' @param ... additional arguments to be passed to the inner lm() function calls. Refer to the documentation of lm() for more details on those arguments
#'
#' @return
#'
#' A character vector with the names of all the significant predictors from the original lm call.
#'
#' @export
#'
#' @examples
#' #cancer_sample data from datateachr package
#'
#' sig_mod <- sig_pred(cancer_sample[,-2], res = "radius_mean")
#'
sig_pred <- function(data, res, preds = NULL, p = 0.01, verbose = FALSE, ...)
{
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

  if(verbose) {
    cat("\nResponse Variable:", res,"\n")
    cat("\nInput Predictors:", predictors,"\n")

    cat("\nFitting a linear model \n")
    cat("\nOptimization of Predictors\n")
  }

  #OPTIMIZATION LOOP
  while(TRUE)
  {
    #FORMULA FOR FITTING THE LINEAR MODEL
    x1 <- paste0(predictors,collapse = "+")

    form <- as.formula(paste(res, "~", x1))

    #FITTING THE LINEAR MODEL
    modelFit <- stats::lm(formula = form, data = data, ...)

    #ANOVA OF THE FIRTTED MODEL TO IDENTIFY SIGNIFICANT VARIABLES
    anov <- stats::anova(modelFit)

    #SORTING THE PREDICTORS BASED ON P-VALUE AND FILTERING ONLY THOSE BELOW SPECIFIED THRESHOLD
    predictors <- anov %>%
      dplyr::arrange(`Pr(>F)`) %>%
      dplyr::filter(`Pr(>F)` < p) %>%
      row.names()

    #ONLY PASSES WHEN ALL VARIABLES IN ANOVA HAS P-VALUE LOWER THAN THRESHOLD
    if(length(predictors) == (nrow(anov)-1))
      break

    if(verbose) cat(".")
  }

  if(verbose) cat("\n\nFinal Optimization...\n")

  #MODEL FITTING BY DROPPING TERMS FROM MODEL AND EVALUATING THIER SIGNIFICANCE
  sigf <- stats::drop1(modelFit, test = "F")

  #FINAL PREDICTORS SELECTION BASED ON THE RESULT FROM drop1()
  predictors <- sigf %>%
    dplyr::filter(`Pr(>F)` < p) %>%
    row.names()

  predictors

}
