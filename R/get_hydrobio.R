#' Retrieve data from API "Hydrobiologie"
#'
#' @description
#' The data originate from the "NAIADES" database.
#' Available endpoints are:
#'
#' - `get_hydrobio_stations_hydrobio` retrieves site data and locations
#' - `get_hydrobio_indices` retrieves bioassessment indices values
#' - `get_hydrobio_taxons` retrieves taxa data
#'
#' See the API documentation for available filter parameters: \url{https://hubeau.eaufrance.fr/page/api-hydrobiologie}
#'
#' @inheritParams doApiQuery
#' @inherit convert_list_to_tibble return return
#'
#' @importFrom magrittr %>%
#' @importFrom dplyr select distinct
#' @export
#' @rdname get_hydrobio
#' @examples
#' if(interactive()) {
#' # Retrieve the hydrobiology monitoring sites in the Pays-de-Loire region
#' list_params(api = "hydrobio",
#'             endpoint = "stations_hydrobio")
#'
#' stations_pdl <- get_hydrobio_stations_hydrobio(
#'  list(code_region = 52))
#'
#' # Retrieve the hydrobiological bioassessment indices in the city of Rennes
#' list_params(api = "hydrobio",
#' endpoint = "indices")
#'
#' indices_rennes <- get_hydrobio_indices(
#'  list(code_commune = 35051))
#'
#' # species records in the city of Rennes
#' list_params(api = "hydrobio",
#'             endpoint = "taxons")
#'
#' taxons_rennes <- hubeau::get_hydrobio_taxons(
#'  list(code_commune = 35051))
#' }
get_hydrobio_stations_hydrobio <- function(params)
{
  l <- doApiQuery(api = "hydrobio",
                  endpoint = "stations_hydrobio",
                  params = params)

  select_non_nested(l) %>%
    select(-code_commune,
           -libelle_departement,
           -(libelle_region:longitude)) %>%
    distinct()
}


#' @rdname get_hydrobio
#' @export
get_hydrobio_indices <- function(params)
{
  l <- doApiQuery(api = "hydrobio",
                  endpoint = "indices",
                  params = params)

  convert_list_to_tibble(l)
}


#' @rdname get_hydrobio
#' @export
get_hydrobio_taxons <- function(params)
{
  l <- doApiQuery(api = "hydrobio",
                  endpoint = "taxons",
                  params = params)

  select_non_nested(l)
}
