test_that("A query of more than 20000 records", {
  expect_error(doApiQuery("indicateurs_services", "communes", params = list()),
               regexp = "The request reach the API limitation of 20000 records")
})
