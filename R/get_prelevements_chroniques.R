#' Retrieve time series of withdrawals from API "Prélèvements en eau"
#'
#' See the API documentation for available filter parameters: \url{https://hubeau.eaufrance.fr/page/api-prelevements-eau}
#'
#' @template param_get_common
#'
#' @return a [tibble::tibble] with all available parameters in columns and one row by device, year and usage.
#' @export
#'
#' @examples
#' # For retrieving the withdrawal time series of the devices located in Romilly-sur-Seine
#' get_prelevements_chroniques(list(code_commune_insee = "10323"))
#'
get_prelevements_chroniques <- function(params, cfg = config::get(file = system.file("config.yml",
                                                                       package = "hubeau"))) {
  l <- doApiQuery(api = "prelevements",
                  operation = "chroniques",
                  params = params,
                  cfg = cfg)
  l <- lapply(l, function(x) {
    x$geometry <- NULL
    x
  })
  l <- lapply(l, function(row) {lapply(row, function(cell) { if(is.null(unlist(cell))) NA else unlist(cell) })})
  return(purrr::map_df(l, tibble::as_tibble))
}
