#' Retrieve withdrawal points from Hub'Eau API
#'
#' See the API documentation for available filter parameters: \url{https://hubeau.eaufrance.fr/page/api-prelevements-eau#/prelevements/prelevement}
#'
#' @template param_get_common
#'
#' @return a [tibble::tibble] with all available parameters in columns and one row by device.
#' @export
#'
#' @examples
#' # For retrieving the withdrawal points located in Romilly-sur-Seine
#' get_prelevements_points_prelevement(list(code_commune_insee = "10323"))
#'
get_prelevements_points_prelevement <- function(params, cfg = config::get(file = system.file("config.yml",
                                                                        package = "hubeau"))) {
  l <- doApiQuery(api = "prelevements",
                  operation = "points_prelevement",
                  params = params,
                  cfg = cfg)

  l <- lapply(l, function(row) {lapply(row, function(cell) { if(is.null(unlist(cell))) NA else unlist(cell) })})
  return(purrr::map_df(l, tibble::as_tibble))
}
