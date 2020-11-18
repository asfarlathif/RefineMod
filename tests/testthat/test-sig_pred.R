test_that("Function returns a character vector",{
  expect_type(sig_pred(ggplot2::diamonds, res = "price", verbose = F), "character")
})

test_that("Funtion doesn't run when responce variable is non numeric", {
  expect_error(sig_pred(datateachr::cancer_sample, res = "diagnosis"), "Responce Variable must be numeric")
})
