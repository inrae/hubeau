#' Retrieve performance indicators from drinking water supply and sanitation services at commune level
#'
#' See the API documentation for available filter parameters: \url{https://hubeau.eaufrance.fr/page/api-indicateurs-services}
#'
#' @template param_get_common
#'
#' @return a [tibble::tibble] with one row by commune, by service and by year and the following columns:
#'
#' - "code_service": [character] identifier of the service
#' - "nom_service": [character] name of the service
#' - "code_commune_insee": [character] identifier of the commune
#' - "nom_commune": [character] name of the commune
#' - "numero_siren ": [character] SIREN identifier of the service
#' - "type_collectivite": [character] kind of collectivity
#' - "mode_gestion": [character] management mechanism of the service
#' - "annee": [integer] year of the data
#' - The following columns are the performance indicators flagged by their respective codes. The documentation of these codes can be found at this URL: \url{https://www.services.eaufrance.fr/indicateurs/indicateurs}.
#'
#' @export
#'
#' @examples
#' # Retrieve performance indicator time series of the services in Romilly-sur-Seine
#' get_indicateurs_services_services(list(code_commune = "10323"))
#'
get_indicateurs_services_services <- function(params,
                                              cfg = config::get(file = system.file("config.yml",
                                                                                   package = "hubeau"))) {

  l <- doApiQuery(api = "indicateurs_services",
                  operation = "services",
                  params = params,
                  cfg = cfg)

  l <- lapply(l, function(x) {
    x <- c(x, x$indicateurs)
    x$indicateurs <- NULL
    x
  })
  convert_list_to_tibble(l)
}
