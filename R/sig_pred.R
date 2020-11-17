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
