#' Retrieve hydrometric "real time" observations from API "Hydrométrie"
#'
#' See the API documentation for available filter parameters: \url{https://hubeau.eaufrance.fr/page/api-hydrometrie}
#'
#' @template param_get_common
#'
#' @return a [tibble::tibble] with all available parameters in columns and one row by time step and by station.
#' @export
#'
#' @examples
#' # For retrieving the hydrometric last real time observed discharge at station 'H020302002'
#' get_hydrometrie_observations_tr(list(code_entite = "H0203020", grandeur_hydro = "Q"))
#'
get_hydrometrie_observations_tr  <- function(params,
                                   unique_site = TRUE,
                                   cfg = config::get(file = system.file("config.yml",
                                                        package = "hubeau"))) {
  l <- doApiQuery(
    api = "hydrometrie",
    operation = "observations_tr",
    params = params,
    cfg = cfg
  )
  l <- lapply(l, function(x) {
    x$geometry <- NULL
    if (is.null(x$code_station)) {
      # See bug https://github.com/BRGM/hubeau/issues/73
      NULL
    } else {
      x
    }
  })
  l[sapply(l, is.null)] <- NULL
  convert_list_to_tibble(l)
}
