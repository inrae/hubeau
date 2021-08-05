#' Retrieve hydrometric stations from API "Hydrométrie"
#'
#' See the API documentation for available filter parameters: \url{https://hubeau.eaufrance.fr/page/api-hydrometrie}
#'
#' @template param_get_common
#' @param code_sandre_reseau_station optional [logical] indicating if `code_sandre_reseau_station` field is included in the result; if so, one line is added by item and other fields are repeated
#'
#' @return a [tibble::tibble] with all available parameters in columns and one row by device, year and usage.
#' @export
#'
#' @examples
#' # For retrieving the hydrometric stations in the department of Aube
#' get_hydrometrie_stations(list(code_departement = "10"))
#'
get_hydrometrie_stations  <- function(params, code_sandre_reseau_station = FALSE, cfg = config::get(file = system.file("config.yml",
                                                                                      package = "hubeau"))) {
  l <- doApiQuery(api = "hydrometrie",
                  operation = "stations",
                  params = params,
                  cfg = cfg)
  l <- lapply(l, function(x) {
    if (!code_sandre_reseau_station) {
      x$code_sandre_reseau_station <- NULL
    }
    x$geometry <- NULL
    x
  })
  convert_list_to_tibble(l)
}
