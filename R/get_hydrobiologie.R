#' Retrieve data from API "Hyrdobiologie"
#'
#' @description
#' Available endpoint:
#'
#' - `get_hydrobiologie_taxons` retrieves data of aquatic macroinvertebrates,
#' diatoms, macrophytes and fish
#' - `get_hydrobiologie_indices` retrieves biological indexes
#' - `get_hydrobiologie_stations_hydrobio` retrieves hydrobiological stations
#'
#' See the API documentation for available filter parameters: \url{https://hubeau.eaufrance.fr/page/api-hydrobiologie#/}
#'
#' @inheritParams doApiQuery
#' @inherit convert_list_to_tibble return return
#'
#' @export
#' @rdname get_hydrobiologie
#'
#' @examples
#' if(interactive()) {
#' # Get the query parameters for the requested API/endpoint
#' list_params(api = "hydrobiologie",
#'                      endpoint = "taxons")
#'
#' # Retrieve selected fields on a river fish sampled in Brest
#' library(dplyr)
#' fields <- paste("code_operation",
#'                 "date_operation",
#'                 "libelle_point_prelevement_aspe",
#'                 "effectif_lot",
#'                 "code_alternatif_taxon",
#'                 sep = ",")
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
get_hydrobiologie_stations_hydrobio <- function(params)

{

  l <- doApiQuery(api = "hydrobiologie",
                  endpoint = "stations_hyrdobio",
                  params = params)

  convert_list_to_tibble(l)
}

get_hydrobiologie_indices <- function(params)

{

  l <- doApiQuery(api = "hydrobiologie",
                  endpoint = "indices",
                  params = params)

  convert_list_to_tibble(l)
}


get_hydrobiologie_taxons <- function(params)

{

  l <- doApiQuery(api = "hydrobiologie",
                  endpoint = "taxons",
                  params = params)

  convert_list_to_tibble(l)
}
