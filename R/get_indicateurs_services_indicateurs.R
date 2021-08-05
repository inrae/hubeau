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
#' # For retrieving the withdrawal time series of the devices located in Romilly-sur-Seine
#' get_indicateurs_services_indicateurs(list(code_indicateur = "D102.0", annee = "2012"))
#'
get_indicateurs_services_indicateurs <- function(params,
                                                cfg = config::get(file = system.file("config.yml",
                                                                                     package = "hubeau"))) {
  l <- doApiQuery(api = "indicateurs_services",
                  operation = "indicateurs",
                  params = params,
                  cfg = cfg)

  l <- lapply(l, function(x) {
    x$codes_commune <- NULL
    x$noms_commune <- NULL
    x
  })
  convert_list_to_tibble(l)
}
