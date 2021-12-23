#' Retrieve hydrometric elaborate observations from API "Hydrométrie"
#'
#' See the API documentation for available filter parameters: \url{https://hubeau.eaufrance.fr/page/api-hydrometrie#operations-hydrometrie-observationsElaborees}
#'
#' @template param_get_common
#'
#' @return a [tibble::tibble] with all available parameters in columns and one row by time step and by station.
#' @export
#'
#' @examples
#' # Retrieve the hydrometric last real time observed discharge at station 'H020302002'
#' get_hydrometrie_obs_elab(list(code_entite = "H0203020", grandeur_hydro_elab = "QmM"))
get_hydrometrie_obs_elab <- function(params,
                                     cfg = config::get(file = system.file("config.yml",
                                                                          package = "hubeau"))) {
  l <- doApiQuery(
    api = "hydrometrie",
    operation = "obs_elab",
    params = params,
    cfg = cfg
  )
  convert_list_to_tibble(l)
}
