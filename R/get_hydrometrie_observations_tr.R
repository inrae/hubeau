#' Retrieve hydrometric "real time" observations from API "Hydrométrie"
#'
#' See the API documentation for available filter parameters: \url{https://hubeau.eaufrance.fr/page/api-hydrometrie}
#'
#' @template param_get_common
#' @param entities 1-[character] string filtering the rows of the returned value, possible values are: "station" for filtering on station rows, "site" for filtering on site rows, "both" for keeping all the rows
#'
#' @return a [tibble::tibble] with all available parameters in columns and one row by time step and by station.
#' @export
#'
#' @examples
#' # Retrieve the hydrometric last real time observed discharge at station 'H020302002'
#' get_hydrometrie_observations_tr(list(code_entite = "H0203020", grandeur_hydro = "Q"))
#'
get_hydrometrie_observations_tr  <- function(params,
                                             entities = "station",
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
    if (entities == "station") {
      if (is.null(x$code_station)) {
        return(NULL)
      }
    } else if (entities == "site") {
      if (!is.null(x$code_station)) {
        return(NULL)
      }
    } else if (entities != "both") {
      stop("Argument 'entities' must be one of these values: 'station', 'site', 'both'")
    }
    return(x)
  })
  l[sapply(l, is.null)] <- NULL
  convert_list_to_tibble(l)
}
