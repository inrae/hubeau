## code to prepare `vignette_example_ecoulement_api` dataset goes here
library(hubeau)

my_dept <- "35"

stations <- get_ecoulement_stations(
  code_departement = my_dept,
  fields = param_stations
)

surveys <- get_ecoulement_campagnes(
  code_departement = my_dept, # department id
  date_campagne_min = "2012-01-01" # start date
)

observations <-
  get_ecoulement_observations(
    code_departement = my_dept,
    date_observation_min = "2012-01-01",
    fields = param_obs
  )

vignette_example_ecoulement_api <- list(
  stations = stations,
  surveys = surveys,
  observations = observations
)

save(stations, surveys, observations, file = "inst/vignettes/example_ecoulement_api.RData")
