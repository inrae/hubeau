params <- list(
  bbox = "1.6,47.79,1.8,47.99",
  date_debut_obs = format(Sys.Date() - 3),
  grandeur_hydro = "Q"
)

test_that("entities not in ('station', 'site', 'both') should throw an error", {
  expect_error(
    df <- get_hydrometrie_observations_tr(params, entities = "wrong value"),
    regexp = "must be one of these values"
  )
})

skip_on_cran()

test_that("`entities = 'station'` => 'code_station' must be always not NA", {
  df <- get_hydrometrie_observations_tr(params, entities = "station")
  expect_true(all(!is.na(df$code_station)))
})

test_that("`entities = 'site'` => 'code_station' must be always NA", {
  df <- get_hydrometrie_observations_tr(params, entities = "site")
  expect_true(all(is.na(df$code_station)))
})

test_that("grandeur_hydro_elab =\"QmJ\" should raise a warning", {
  expect_warning(get_hydrometrie_obs_elab(
    code_entite = "H0203020",
    date_debut_obs_elab = format(Sys.Date() - 30, "%Y-%m-%d"),
    grandeur_hydro_elab = "QmJ"
  ))
})
