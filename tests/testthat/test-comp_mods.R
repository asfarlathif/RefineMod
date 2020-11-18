test_that("Function returns a data frame ",{

  mod1 <- lm(mpg~wt, mtcars)
  mod2 <- lm(mpg~cyl, mtcars)
  mod3 <- lm(mpg~wt+cyl, mtcars)
  mod4 <- lm(mpg~carb, mtcars)
  expect_s3_class(comp_mods(mod1, mod2, mod3, mod4), "data.frame")

})
