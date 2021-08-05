#' Retrieve performance indicators from drinking water supply and sanitation services at commune level
#'
#' See the API documentation for available filter parameters: \url{https://hubeau.eaufrance.fr/page/api-indicateurs-services}
#'
#' @template param_get_common
#'
#' @return a [tibble::tibble] with one row by commune, by service and by year and the following columns:
#'
#' - "code_commune_insee": [character] identifier of the commune
#' - "nom_commune": [character] name of the commune
#' - "codes_service": [integer] identifier of the drinking water supply and/or sanitation service
#' - "annee": [integer] year of the data
#' - The following columns are the performance indicators flagged by their respective codes. The documentation of these codes can be found at this URL: \url{https://www.services.eaufrance.fr/indicateurs/indicateurs}.
#'
#' @export
#'
#' @examples
#' # For retrieving performance indicator time series of the services in Romilly-sur-Seine
#' get_indicateurs_services_communes(list(code_commune = "10323"))
#'
get_indicateurs_services_communes <- function(params,
                                              cfg = config::get(file = system.file("config.yml",
                                                                                   package = "hubeau"))) {

  l <- doApiQuery(api = "indicateurs_services",
                  operation = "communes",
                  params = params,
                  cfg = cfg)

  l <- lapply(l, function(x) {
    x <- c(x, x$indicateurs)
    x$indicateurs <- NULL
    x
  })
  l <- lapply(l, function(row) {lapply(row, function(cell) { if(is.null(unlist(cell))) NA else unlist(cell) })})
  return(purrr::map_df(l, tibble::as_tibble))
}
