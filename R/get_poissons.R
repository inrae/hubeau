#' Retrieve data from API "Poisson"
#'
#' @description
#' Available endpoints are:
#'
#' - `get_poisson_observations` retrieves operation
#' - other endpoints should soon be added
#'
#' See the API documentation for available filter parameters: \url{https://hubeau.eaufrance.fr/page/api-poisson}
#'
#' @template param_get_common
#'
#' @export
#'
#' @examples
#' # Retrieve the river fish sampled in Brest
#' get_poisson_observations(list(code_commune = "29019"))
#'
get_poisson_observations <- function(params,
                                     cfg = config::get(file = system.file("config.yml",
                                                                          package = "hubeau")))

  {

  l <- doApiQuery(api = "etat_piscicole",
                  endpoint = "observations",
                  params = params,
                  cfg = cfg)

  convert_list_to_tibble(l)
}


