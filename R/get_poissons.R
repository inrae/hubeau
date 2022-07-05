#' Retrieve data from API "Poisson"
#'
#' @description
#' Available endpoints are:
#'
#' - `get_poisson_observations` retrieves operation
#'
#' See the API documentation for available filter parameters: \url{https://hubeau.eaufrance.fr/page/api-poisson}
#'
#' @template param_get_common
#'
#' @export
#'
#' @examples
#' # Retrieve the withdrawal points located in Romilly-sur-Seine
#' get_prelevements_points_prelevement(list(code_commune_insee = "10323"))
#'
#' # Retrieve the withdrawal devices located in Romilly-sur-Seine
#' get_prelevements_ouvrages(list(code_commune_insee = "10323"))
#'
#' # Retrieve the withdrawal time series of the devices located in Romilly-sur-Seine
#' get_prelevements_chroniques(list(code_commune_insee = "10323"))
#'
get_poisson_observations <- function(params,
                                     cfg = config::get(file = system.file("config.yml", package = "hubeau")))

  {

  l <- doApiQuery(api = "etat_piscicole",
                  endpoint = "observations",
                  params = params,
                  cfg = cfg)

  convert_list_to_tibble(l)
}


