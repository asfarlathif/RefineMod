#' Title
#'
#' @param mod1
#' @param ...
#' @param newdata
#'
#' @return
#' @export
#'
#' @examples
comp_mods <- function(mod1, ..., newdata = NULL){

  modList <- list(mod1, ...)

  obs <- purrr::map(modList, ~ .x$model[[1]])

  predictions <- purrr::map(modList, broom::augment, newdata = newdata)

  predictions <- purrr::map(predictions, ~ .x$.fitted)

  obs_pred <- purrr::map2(obs, predictions, ~ data.frame ("obs" = .x, "pred" = .y))

  analytics <- purrr::map(obs_pred, caret::defaultSummary)

  names(analytics) <- paste("model", 1:length(analytics), sep = "")

  t(data.frame(analytics))

}
