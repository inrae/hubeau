test_that("convert_ellipsis_to_params works", {
  expect_equal(convert_ellipsis_to_params(toto = 1, tata = 2), list(toto = 1, tata = 2))
  expect_equal(convert_ellipsis_to_params(list(toto = 1, tata = 2)), list(toto = 1, tata = 2))
  expect_error(convert_ellipsis_to_params(toto = 1, 2))
})
