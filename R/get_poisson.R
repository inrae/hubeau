#' Retrieve data from API "Poisson"
#'
#' @description
#' Available endpoint:
#'
#' - `get_poisson_observations` retrieves data of scientific fishery operations
#'
#' See the API documentation for available filter parameters: \url{https://hubeau.eaufrance.fr/page/api-poisson}
#'
#' @inheritParams doApiQuery
#' @inherit convert_list_to_tibble return return
#'
#' @export
#' @rdname get_poisson
#'
#' @examples
#' \dontrun{
#' # Get the endpoints available for the API "Poisson"
#' list_endpoints(api = "poisson")
#'
#' # List the stations available in Brest
#' get_poisson_stations(libelle_commune = "Brest")
#'
#' # List the operations available in Brest
#' get_poisson_operations(libelle_commune = "Brest")
#'
#' # List the indicators available in Brest
#' get_poisson_indicateurs(libelle_commune = "Brest")
#'
#' # Get the query parameters for the requested API/endpoint
#' list_params(api = "poisson",
#'                      endpoint = "observations")
#'
#' # Retrieve selected fields on a river fish sampled in Brest
#' library(dplyr)
#' fields <- c("code_operation",
#'                 "date_operation",
#'                 "libelle_point_prelevement_aspe",
#'                 "effectif_lot",
#'                 "code_alternatif_taxon")
#'
#' brest_fishes <- get_poisson_observations(
#'   list(
#'     libelle_commune = "Brest",
#'     fields = fields
#'     )
#'  ) %>%
#'  group_by_at(vars(-effectif_lot)) %>%
#'    summarise(nb_individals = sum(effectif_lot))
#'
#' brest_fishes
#' }
get_poisson_observations <- function(...) {

  l <- doApiQuery(api = "poisson",
                  endpoint = "observations",
                  ...)

  convert_list_to_tibble(l)
}

#' @export
#' @rdname get_poisson
get_poisson_indicateurs <- function(...) {

  l <- doApiQuery(api = "poisson",
                  endpoint = "indicateurs",
                  ...)

  convert_list_to_tibble(l)
}

#' @export
#' @rdname get_poisson
get_poisson_operations <- function(...) {

  l <- doApiQuery(api = "poisson",
                  endpoint = "operations",
                  ...)

  convert_list_to_tibble(l)
}

#' @export
#' @rdname get_poisson
get_poisson_stations <- function(...) {

  l <- doApiQuery(api = "poisson",
                  endpoint = "stations",
                  ...)

  convert_list_to_tibble(l)
}

