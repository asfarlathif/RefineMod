test_that("Function returns lm object as a list",{
  expect_type(lm_significant(ggplot2::diamonds, res = "price", verbose = F, all = T), "list")
})

test_that("Result matches lm() call with only significant predictors", {
  m1 <- lm_significant(mtcars, res = "mpg", verbose = F) #predictor Optimization
  m2 <- lm(mpg ~ cyl+wt, mtcars) #lm() call with only significant predictors
  expect_equal(coef(m1), coef(m2))
})

test_that("Funtion doesn't run when responce variable is non numeric", {
  expect_error(lm_significant(datateachr::cancer_sample, res = "diagnosis"), "Responce Variable must be numeric")
})
