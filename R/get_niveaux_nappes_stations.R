#' Retrieve piezometric stations from API "Piézométrie"
#'
#' See the API documentation for available filter parameters: \url{https://hubeau.eaufrance.fr/page/api-piezometrie}
#'
#' @template param_get_common
#'
#' @return a [tibble::tibble] with all available parameters in columns and one row by station.
#' @export
#'
#' @examples
#' # For retrieving the hydrometric stations in the department of Aube
#' get_niveaux_nappes_stations(list(code_departement = "10"))
#'
get_niveaux_nappes_stations  <- function(params, cfg = config::get(file = system.file("config.yml",
                                                                                      package = "hubeau"))) {
  l <- doApiQuery(api = "niveaux_nappes",
                  operation = "stations",
                  params = params,
                  cfg = cfg)
  l <- lapply(l, function(x) {
    x$geometry <- NULL
    x
  })
  convert_list_to_tibble(l)
}
