skip_on_cran()
test_that("A query of more than 20000 records", {
  expect_error(doApiQuery("indicateurs_services", "communes"),
               regexp = "The request reach the API limitation of 20000 records")
  expect_error(suppressWarnings(
    doApiQuery("indicateurs_services", "communes", code_commune = 34001, params = list())),
               regexp = "used together")
  expect_warning(doApiQuery("indicateurs_services", "communes", params = list(code_commune = 34001)),
                 regexp = "deprecated")
})
