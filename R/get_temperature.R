#' Retrieve data from API "Température des cours d'eau"
#'
#' @description
#'
#' Available endpoints are:
#'
#' - `get_temperature_stations` retrieves temperature stations
#' - `get_temperature_chronique` retrieves temperature time series
#'
#' See the API documentation of each endpoint for available filter parameters:
#' \url{https://hubeau.eaufrance.fr/page/api-temperature-continu}
#'
#' @inheritParams doApiQuery
#' @inherit convert_list_to_tibble return return
#'
#' @export
#' @rdname get_temperature
#' @examples
#' if(interactive()) {
#' # Retrieve the temperature stations in the department of Loiret
#' get_temperature_stations(list(code_departement = "45"))
#'
#' # Retrieve the temperature from 2012-01-01 to 2012-01-05 at site 04051125
#'
#' get_temperature_chronique(list(
#'   code_station = "04051125",
#'   date_debut_mesure = "2012-01-01",
#'   date_fin_mesure="2012-01-05",
#'   fields = paste("code_station,date_mesure_temp,heure_mesure_temp,resultat,symbole_unite")
#' ))
#'
#' }
#'
get_temperature_stations  <- function(params)
  {
  l <- doApiQuery(api = "temperature",
                  endpoint = "station",
                  params = params)

    convert_list_to_tibble(l)
}

#' @rdname get_temperature
#' @export
get_temperature_chronique <- function(params) {
  l <- doApiQuery(api = "temperature",
                  endpoint = "chronique",
                  params = params)
  l <- lapply(l, function(x) {
    x$geometry <- NULL
    x
  })
  convert_list_to_tibble(l)
}
