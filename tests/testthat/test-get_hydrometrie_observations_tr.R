params <- list(code_entite = "H0203020",
               date_debut_obs = format(Sys.Date()-3),
               grandeur_hydro = "Q")

test_that("entities not in ('station', 'site', 'both') should throw an error", {
  expect_error(
    df <- get_hydrometrie_observations_tr(params, entities = "wrong value"),
    regexp = "must be one of these values"
  )
})


test_that("`entities = 'station'` => 'code_station' must be always not NA", {
  skip_on_cran()
  df <- get_hydrometrie_observations_tr(params, entities = "station")
  expect_true(all(!is.na(df$code_station)))
})

test_that("`entities = 'site'` => 'code_station' must be always NA", {
  skip_on_cran()
  df <- get_hydrometrie_observations_tr(params, entities = "site")
  expect_true(all(is.na(df$code_station)))
})

