#' Retrieve data from API "Ecoulement des cours d'eau"
#'
#' @description
#' The data originate from the "ONDE" river low waters monitoring network.
#' Available endpoints are:
#'
#' - `get_ecoulement_stations` retrieves site data and locations
#' - `get_ecoulement_observations` retrieves flow information
#' - `get_ecoulement_campagnes` retrieves annual surveys
#'
#' See the API documentation for available filter parameters: \url{https://hubeau.eaufrance.fr/page/api-ecoulement}
#'
#' @inheritParams doApiQuery
#'
#' @export
#' @rdname get_ecoulement
#' @examples
#' # Retrieve 2022 observation campaigns in the Jura French department
#' get_ecoulement_campagnes(
#'   list(code_departement = "39",
#'        date_campagne_min = "2022-01-01",
#'        date_campagne_max = "2022-12-31")
#' )
#'
#' # Retrieve river stations
#' stations_39 <- get_ecoulement_stations(
#'   list(code_departement = "39",
#'        fields = "code_station,libelle_cours_eau,libelle_commune")
#' )
#' stations_39
#'
#' # Get the query parameters for the requested API/endpoint
#' list_params(api = "ecoulement",
#'                      endpoint = "observations")
#'
#' # Retrieve the river flow data in the Jura departement in 2022 with
#' # a selection of the fields
#' onde_39 <- get_ecoulement_observations(
#'   list(code_departement = "39",
#'        date_observation_min = "2022-01-01",
#'        date_observation_max = "2022-12-31",
#'        fields = "code_station,libelle_station,date_observation,libelle_ecoulement")
#' )
#' onde_39
#'
get_ecoulement_stations <- function(params)
{
  l <- doApiQuery(
    api = "ecoulement",
    endpoint = "stations",
    params = params
  )

  convert_list_to_tibble(l)
}


#' @rdname get_ecoulement
#' @export
get_ecoulement_observations <- function(params)
{
  l <- doApiQuery(
    api = "ecoulement",
    endpoint = "observations",
    params = params
  )

  convert_list_to_tibble(l)
}


#' @rdname get_ecoulement
#' @export
get_ecoulement_campagnes <- function(params)
{
  l <- doApiQuery(
    api = "ecoulement",
    endpoint = "campagnes",
    params = params
  )

  convert_list_to_tibble(l)
}
