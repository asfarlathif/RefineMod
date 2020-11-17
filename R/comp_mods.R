comp_mods <- function(mod1, ..., newdata = NULL){

  modList <- list(mod1, ...)

  obs <- map(modList, ~ .x$model[[1]])

  predictions <- map(modList, broom::augment, newdata = newdata)

  predictions <- map(predictions, ~ .x$.fitted)

  obs_pred <- map2(obs, predictions, ~ data.frame ("obs" = .x, "pred" = .y))

  analytics <- map(obs_pred, caret::defaultSummary)

  analytics

}
