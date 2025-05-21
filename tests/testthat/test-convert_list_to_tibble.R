test_that("Nested list works (Issue #51)", {
  l <- doApiQuery(
    api = "qualite_eau_potable",
    endpoint = "resultats_dis",
    code_reseau = "068006583",
    date_min_prelevement = "2025-01-01",
    date_max_prelevement = "2025-12-31"
  )
  df <- convert_list_to_tibble(l)
  expect_s3_class(df, "tbl_df")
  column_names <- names(l[[1]])
  column_names <- column_names[column_names != "reseaux"]
  expect_contains(names(df), column_names)
})
