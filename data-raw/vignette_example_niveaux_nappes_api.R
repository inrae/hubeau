## code to prepare `vignette_example_niveaux_nappes_api` dataset goes here
library(hubeau)

my_water_table_code <- "GG063"

stations <- get_niveaux_nappes_stations(
  codes_masse_eau_edl = my_water_table_code
)

water_table_level <- map_df(.x = stations$code_bss,
                            .f = function(x) get_niveaux_nappes_chroniques(code_bss = x,
                                                                           date_debut_mesure = "2015-01-01"))

water_table_level <- water_table_level %>%
  mutate(date_mesure = lubridate::ymd(date_mesure),
         year = lubridate::year(date_mesure),
         month = lubridate::month(date_mesure))


vignette_example_niveaux_nappes_api <- list(
  stations = stations,
  water_table_level = water_table_level
)

save(stations,
     water_table_level,
     file = "inst/vignettes/example_niveaux_nappes_api.RData")
