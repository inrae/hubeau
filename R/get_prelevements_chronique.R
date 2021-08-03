#' Retrieve time series of withdrawals from Hub'Eau API
#'
#' See the API documentation for available filter parameters: \url{https://hubeau.eaufrance.fr/page/api-prelevements-eau#/prelevements/chronique}
#'
#' @param params [list] where the keys are the names of the filtered parameters and the values are the values of the filters. See the API documentation for the complete list of available filter parameters
#' @param cfg a [config] object Configuration of the communication. Use by default the internal package
#'        configuration
#'
#' @return a [tibble::tibble] with all available parameters in columns and one row by device, year and usage.
#' @export
#'
#' @examples
#' # For retrieving the withdrawal time series of the devices located in Romilly-sur-Seine
#' get_prelevements_chronique(list(code_commune_insee = "10323"))
#'
get_prelevements_chronique <- function(params, cfg = config::get(file = system.file("config.yml",
                                                                       package = "hubeau"))) {
  l <- doApiQuery(cfg$api_prelevements$chronique, params)
  l <- lapply(l, function(x) {
    x$geometry <- NULL
    x
  })
  l <- lapply(l, function(row) {lapply(row, function(cell) { if(is.null(unlist(cell))) NA else unlist(cell) })})
  return(purrr::map_df(l, tibble::as_tibble))
}
