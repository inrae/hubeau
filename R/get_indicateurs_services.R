#' Retrieve performance indicators from drinking water supply and sanitation services at commune level
#'
#' @description
#' Available endpoints are:
#'
#' -
#'
#' See [get_available_params] and the API documentation for available filter parameters: \url{https://hubeau.eaufrance.fr/page/api-indicateurs-services}
#'
#' @template param_get_common
#'
#' @details
#' `get_indicateurs_services_communes` returns a [tibble::tibble] with one row by commune, by service and by year and the following columns:
#'
#' - "code_commune_insee": [character] identifier of the commune
#' - "nom_commune": [character] name of the commune
#' - "codes_service": [integer] identifier of the drinking water supply and/or sanitation service
#' - "annee": [integer] year of the data
#' - The following columns are the performance indicators flagged by their respective codes. The documentation of these codes can be found at this URL: \url{https://www.services.eaufrance.fr/indicateurs/indicateurs}.
#'
#' a [tibble::tibble] with one row by commune, by service and by year and the following columns:
#'
#' - "code_commune_insee": [character] identifier of the commune
#' - "nom_commune": [character] name of the commune
#' - "codes_service": [integer] identifier of the drinking water supply and/or sanitation service
#' - "annee": [integer] year of the data
#' - The following columns are the performance indicators flagged by their respective codes. The documentation of these codes can be found at this URL: \url{https://www.services.eaufrance.fr/indicateurs/indicateurs}.
#'
#' `get_indicateurs_services_indicateurs` returns a [tibble::tibble] with one row by service and by year and the following columns:
#'
#' - "code_service": [character] identifier of the service
#' - "nom_service": [character] name of the service
#' - "numero_siren ": [character] SIREN identifier of the service
#' - "type_collectivite": [character] kind of collectivity
#' - "mode_gestion": [character] management mechanism of the service
#' - "annee": [integer] year of the data
#' - "indicateur": value of the indicator
#' - "uri_indicateur": the link to the indicator documentation
#'
#' `get_indicateurs_services_services` returns a [tibble::tibble] with one row by commune, by service and by year and the following columns:
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
#' @rdname get_indicateurs_services
#'
#' @examples
#' # Retrieve performance indicator time series in the commune of Romilly-sur-Seine
#' get_indicateurs_services_communes(list(code_commune = "10323"))
#'
#' # Retrieve the drinking water withdrawal indicators of the year 2012 for all services
#' get_indicateurs_services_indicateurs(list(code_indicateur = "D102.0", annee = "2012"))
#'
#' # Retrieve performance indicator time series of Romilly-sur-Seine with service details
#' get_indicateurs_services_services(list(code_commune = "10323"))
#'
get_indicateurs_services_communes <- function(params,
                                              cfg = config::get(file = system.file("config.yml",
                                                                                   package = "hubeau"))) {

  l <- doApiQuery(api = "indicateurs_services",
                  endpoint = "communes",
                  params = params,
                  cfg = cfg)

  l <- lapply(l, function(x) {
    x <- c(x, x$indicateurs)
    x$indicateurs <- NULL
    x
  })
  convert_list_to_tibble(l)
}

#' @export
#' @rdname get_indicateurs_services
get_indicateurs_services_indicateurs <- function(params,
                                                cfg = config::get(file = system.file("config.yml",
                                                                                     package = "hubeau"))) {
  l <- doApiQuery(api = "indicateurs_services",
                  endpoint = "indicateurs",
                  params = params,
                  cfg = cfg)

  l <- lapply(l, function(x) {
    x$codes_commune <- NULL
    x$noms_commune <- NULL
    x
  })
  convert_list_to_tibble(l)
}

#' @export
#' @rdname get_indicateurs_services
get_indicateurs_services_services <- function(params,
                                              cfg = config::get(file = system.file("config.yml",
                                                                                   package = "hubeau"))) {

  l <- doApiQuery(api = "indicateurs_services",
                  endpoint = "services",
                  params = params,
                  cfg = cfg)

  l <- lapply(l, function(x) {
    x <- c(x, x$indicateurs)
    x$indicateurs <- NULL
    x
  })
  convert_list_to_tibble(l)
}
