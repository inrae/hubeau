## code to prepare `vignette_example_ecoulement_api` dataset goes here

library(hubeau)
library(dplyr)
library(lubridate)

station_21 <- get_qualite_rivieres_station(code_departement = "21")

nitrates_21_raw <- get_qualite_rivieres_analyse(code_departement = "21",
                                            date_debut_prelevement = "2000-01-01",
                                            date_fin_prelevement = "2000-12-31",
                                            code_parametre = "1340")

nitrates_21 <- get_qualite_rivieres_analyse(
  code_departement = "21",
  date_debut_prelevement = "2000-01-01",
  date_fin_prelevement = "2022-12-31",
  code_parametre = "1340",
  fields = c("code_station", "libelle_station", "libelle_fraction", "date_prelevement", "resultat", "symbole_unite")
)

save(station_21, nitrates_21_raw, nitrates_21, file = "inst/vignettes/data_extraction_naiades.RData")
