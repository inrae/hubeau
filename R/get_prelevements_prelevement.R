#' Retrieve withdrawal points from Hub'Eau API
#'
#' See the API documentation for available filter parameters: \url{https://hubeau.eaufrance.fr/page/api-prelevements-eau#/prelevements/prelevement}
#'
#' @param params [list] where the keys are the names of the filtered parameters and the values are the values of the filters. See the API documentation for the complete list of available filter parameters
#' @param cfg a [config] object Configuration of the communication. Use by default the internal package
#'        configuration
#'
#' @return a [tibble::tibble] with all available parameters in columns and one row by device.
#' @export
#'
#' @examples
#' # For retrieving the withdrawal points located in Romilly-sur-Seine
#' get_prelevements_prelevement(list(code_commune_insee = "10323"))
#'
get_prelevements_prelevement <- function(params, cfg = config::get(file = system.file("config.yml",
                                                                        package = "hubeau"))) {
  l <- doApiQuery(cfg$api_prelevements$points_prelevement, params)
  l <- lapply(l, function(row) {lapply(row, function(cell) { if(is.null(unlist(cell))) NA else unlist(cell) })})
  return(purrr::map_df(l, tibble::as_tibble))
}
