#' Retrieve data from API "Ecoulement des cours d'eau"
#'
#' @description
#' The data originate from the "ONDE" river low waters monitoring network.
#' Available endpoints are:
#'
#' - `get_poisson_stations` retrieves sites data and location
#' - `get_poisson_observations` retrieves flow information
#' - `get_poisson_campagnes` retrieves annual surveys
#'
#' See the API documentation for available filter parameters: \url{https://hubeau.eaufrance.fr/page/api-ecoulement}
#'
#' @template param_get_common
#'
#' @export
#' @rdname get_ecoulement
#' @examples
#' # Get the query parameters for the requested API/endpoint
#' get_available_params(api = "ecoulement",
#'                      endpoint = "observations")
#'
#' # Retrieve the river flow data in the Jura since 2021
#' onde_39 <- get_ecoulement_observations(list(code_departement = "39",
#'                                             date_observation_min = "2021-01-01"))
#'
get_ecoulement_stations <- function(params,
                                    cfg = config::get(file = system.file("config.yml",
                                                                         package = "hubeau")))

{
  l <- doApiQuery(
    api = "ecoulement",
    endpoint = "stations",
    params = params,
    cfg = cfg
  )

  convert_list_to_tibble(l)
}
#' @rdname get_ecoulement
#' @export
get_ecoulement_observations <- function(params,
                                        cfg = config::get(file = system.file("config.yml",
                                                                             package = "hubeau")))

{
  l <- doApiQuery(
    api = "ecoulement",
    endpoint = "observations",
    params = params,
    cfg = cfg
  )

  convert_list_to_tibble(l)
}
#' @rdname get_ecoulement
#' @export
get_ecoulement_campagnes <- function(params,
                                     cfg = config::get(file = system.file("config.yml",
                                                                          package = "hubeau")))

{
  l <- doApiQuery(
    api = "ecoulement",
    endpoint = "campagnes",
    params = params,
    cfg = cfg
  )

  convert_list_to_tibble(l)
}


