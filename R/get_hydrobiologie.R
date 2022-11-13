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
#' # Retrieve hyrdrobiological stations with selected fields in the region Pays
#' de la Loire
#'
#' fields <- paste("code_station_hydrobio",
#'                 "coordonnee_x",
#'                 "coordonnee_y",
#'                 "libelle_cours_eau",
#'                 sep = ",")
#' stations_pdl <- get_poisson_observations(
#'   list(
#'     code_region = 52,
#'     fields = fields
#'     )
#'  )
#'
#' stations_pdl
#'
#' # Retrive hydrobiological indexes with selected fields in Nantes
#'
#' fields <- paste("code_indice",
#'                 "libelle_indice",
#'                 "date_prelevement",
#'                 "resultat_indice",
#'                 sep = ",")
#'
#'  nantes_indices <- get_hydrobiologie_indices(
#'  list(
#'    code_commune = "44109",
#'    fields = fields
#'    )
#'  )
#'
#' # Retrieve taxons collected in Nantes with selected fields
#'
#' fields <- paste("code_station_hydrobio",
#'                 "date_prelevement",
#'                 "libelle_appel_taxon",
#'                 "libelle_type_resultat",
#'                 "resultat_taxon",
#'                 sep = ",")
#'
#' nantes_taxons <- get_hydrobiologie_taxons(
#' list(
#'  code_commune = "44109",
#'  fields = fields
#' )
#' )
#'
#' }
get_hydrobiologie_stations_hydrobio <- function(params)

{

  l <- doApiQuery(api = "hydrobiologie",
                  endpoint = "stations_hydrobio",
                  params = params)

  l <- lapply(l, function(x) {
    x <- c(x, x$codes_reseaux, x$libelles_reseaux, x$codes_supports,
           x$libelles_supports, x$codes_appel_taxons, x$libelles_appel_taxons,
           x$codes_indices, x$libelles_indices, x$geometry
           )
    x$codes_reseaux <- NULL
    x$libelles_reseaux <- NULL
    x$codes_supports <- NULL
    x$libelles_supports <- NULL
    x$codes_appel_taxons <- NULL
    x$libelles_appel_taxons <- NULL
    x$codes_indices <- NULL
    x$libelles_indices <- NULL
    x$geometry <- NULL
    x[-c(27:length(x))]

  })

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

  l <- lapply(l, function(x) {
    x <- c(x, x$codes_taxons_parents, x$libelles_taxons_parents, x$geometry,
           x$codes_indices_operation, x$crs, x$coordinates)
    x$codes_taxons_parents <- NULL
    x$libelles_taxons_parents <- NULL
    x$geometry <- NULL
    x$codes_indices_operation <- NULL
    x$crs <- NULL
    x$coordinates <- NULL
    x[-c(44:length(x))]

  })

  convert_list_to_tibble(l)
}
