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
#' # Get the query parameters for the requested API/endpoint
#' list_params(api = "poisson",
#'                      endpoint = "observations")
#'
#' # Retrieve selected fields on a river fish sampled in Brest
#' library(dplyr)
#' fields <- paste("code_operation",
#'                 "date_operation",
#'                 "libelle_point_prelevement_aspe",
#'                 "effectif_lot",
#'                 "code_alternatif_taxon",
#'                 sep = ",")
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
get_poisson_observations <- function(params) {

  l <- doApiQuery(api = "poisson",
                  endpoint = "observations",
                  params = params)

  convert_list_to_tibble(l)
}
