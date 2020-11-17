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

  form <- as.formula(paste(res, "~", x))

  modelFit$`All Predictors` <- stats::lm(formula = form, data = data, ...)

  #LINEAR MODEL WITH ONLY THE OPTIMIZED PREDICTORS

  predictors <- sig_pred(data = data, res = res, preds = preds, p = p, verbose = verbose, ...)

  x1 <- paste0(predictors,collapse = "+")

  form1 <- as.formula(paste(res, "~", x1))

  modelFit$`Opt Predictors` <- stats::lm(formula = form1, data = data, ...)

  if(verbose) cat("\n\nFinal Optimized Predictors:", predictors, "\n")

  if(all)
    modelFit
  else
    modelFit$`Opt Predictors`
}
