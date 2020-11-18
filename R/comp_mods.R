#' Model Performace Comparison
#'
#' This function takes in one or more linear regression models and compares the RMSE, R2 and MAE of those models with or without a new input data.
#'
#' @param mod1 an object containing results returned by lm function
#' @param ... additional lm model object
#' @param newdata newdata than used for training the model. By default NULL and the function evaluated model performance based on training data
#'
#' @return a dataframe with each row representing an input model and three columns of model performance evaluation criteria (RMSE, R2 and MAE)
#' @export
#'
#' @examples
#' train <- mtcars[1:20,]
#' test <- mtcars[21:30,]
#'
#' mod1 <- lm(mpg~wt, train)
#' mod2 <- lm(mpg~cyl, train)
#' mod3 <- lm(mpg~wt+cyl, train)
#' mod4 <- lm(mpg~carb, train)
#'
#' comp_mods(mod1, mod2, mod3, mod4, newdata = test)
#'
comp_mods <- function(mod1, ..., newdata = NULL){

  modList <- list(mod1, ...)

  obs <- purrr::map(modList, ~ .x$model[[1]])

  predictions <- purrr::map(modList, broom::augment, newdata = newdata)

  predictions <- purrr::map(predictions, ~ .x$.fitted)

  obs_pred <- purrr::map2(obs, predictions, ~ data.frame ("obs" = .x, "pred" = .y))

  analytics <- purrr::map(obs_pred, caret::defaultSummary)

  names(analytics) <- paste("model", 1:length(analytics), sep = "")

  data.frame(t(data.frame(analytics)))

}
