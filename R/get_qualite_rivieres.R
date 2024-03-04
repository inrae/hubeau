#' Retrieve data from API "Qualité physico-chimique des cours d'eau"
#'
#' @description
#' The "Quality of rivers" API data comes from the Naïades database.
#' Available for the whole of France (including the French overseas departments
#' and territories), they relate to the results of measurements of the
#' physico-chemical quality of rivers and water bodies transmitted by the Water
#' Agencies.
#'
#' Available endpoints are:
#'
#' - `get_qualite_rivieres_station` retrieves physico-chemical measuring stations
#' - `get_qualite_rivieres_operation` retrieves physico-chemical operations
#' - `get_qualite_rivieres_analyse` retrieves physico-chemical analyses
#' - `get_qualite_rivieres_condition_environnementale` retrieves physico-chemical
#' environmental conditions for analyses (please note that pagination is based
#' on the number of analyses)
#'
#' See the API documentation for available filter parameters: \url{https://hubeau.eaufrance.fr/page/api-qualite-cours-deau}
#'
#' @details
#' Endpoints ending by `_pc` are aliases of the functions without the suffix `_pc`.
#'
#' @inheritParams doApiQuery
#' @inherit convert_list_to_tibble return return
#'
#' @export
#' @rdname get_qualite_rivieres
#'
#' @examples
#' \dontrun{
#' # Tutorial provided by https://hubeau.eaufrance.fr/page/api-qualite-cours-deau-tuto
#'
#' # List of stations in Longuyon
#' get_qualite_rivieres_station(libelle_commune="Longuyon")
#' # ... with field selection
#' get_qualite_rivieres_station(
#'   libelle_commune = "Longuyon",
#'   fields = c("code_station",
#'              "libelle_station",
#'              "localisation_precise",
#'              "code_commune",
#'              "libelle_commune",
#'              "code_cours_eau",
#'              "nom_cours_eau")
#' )
#'
#' # Query results of nitrate analyses at the station since 2013
#' get_qualite_rivieres_analyse(
#'   code_station = "02115725",
#'   libelle_parametre = "Nitrates",
#'   date_debut_prelevement = "2013-01-01",
#'   code_qualification = 1,
#'   fields = c("code_station",
#'              "libelle_station",
#'              "code_parametre",
#'              "libelle_parametre",
#'              "date_prelevement",
#'              "resultat",
#'              "symbole_unite",
#'              "code_remarque",
#'              "mnemo_remarque",
#'              "code_statut",
#'              "mnemo_statut",
#'              "code_qualification",
#'              "libelle_qualification")
#' )
#'
#' # dates sorted from most recent to oldest
#' get_qualite_rivieres_analyse(
#'   code_station = "02115725",
#'   libelle_parametre = "Nitrates",
#'   date_debut_prelevement = "2013-01-01",
#'   code_qualification = 1,
#'   fields = c("code_station",
#'              "libelle_station",
#'              "code_parametre",
#'              "libelle_parametre",
#'              "date_prelevement",
#'              "resultat",
#'              "symbole_unite",
#'              "code_remarque",
#'              "mnemo_remarque",
#'              "code_statut",
#'              "mnemo_statut",
#'              "code_qualification",
#'              "libelle_qualification"),
#'  sort = "desc"
#' )
#'
#' # Nitrate analysis results since 1 August 2016 for 5 stations
#' get_qualite_rivieres_analyse(
#'   code_station = c("02115725",
#'                    "02115650",
#'                    "02115685",
#'                    "02115700",
#'                    "02115715"),
#'   libelle_parametre = "Nitrates",
#'   date_debut_prelevement = "2016-08-01",
#'   code_qualification = 1,
#'   fields = c("code_station",
#'              "libelle_station",
#'              "libelle_parametre",
#'              "date_prelevement",
#'              "resultat",
#'              "symbole_unite",
#'              "code_remarque"),
#'  sort = "desc"
#' )
#'
#' # Geographical search by distance
#' get_qualite_rivieres_station(longitude = 5.62,
#'                              latitude = 49.44,
#'                              distance = 8,
#'                              fields = c("code_station", "libelle_station"))
#'
#' }
get_qualite_rivieres_analyse <- function(...) {
  l <- doApiQuery(api = "qualite_rivieres",
                  endpoint = "analyse_pc",
                  ...)
  convert_list_to_tibble(l) %>% fix_encoding_libelle_station
}

#' @export
#' @rdname get_qualite_rivieres
get_qualite_rivieres_analyse_pc <- get_qualite_rivieres_analyse

#' @export
#' @rdname get_qualite_rivieres
get_qualite_rivieres_condition_environnementale <- function(...) {
  l <- doApiQuery(api = "qualite_rivieres",
                  endpoint = "condition_environnementale_pc",
                  ...)
  convert_list_to_tibble(l) %>% fix_encoding_libelle_station
}

#' @export
#' @rdname get_qualite_rivieres
get_qualite_rivieres_condition_environnementale_pc <- get_qualite_rivieres_condition_environnementale

#' @export
#' @rdname get_qualite_rivieres
get_qualite_rivieres_operation <- function(...) {
  l <- doApiQuery(api = "qualite_rivieres",
                  endpoint = "operation_pc",
                  ...)
  convert_list_to_tibble(l) %>% fix_encoding_libelle_station
}

#' @export
#' @rdname get_qualite_rivieres
get_qualite_rivieres_operation_pc <- get_qualite_rivieres_operation

#' @export
#' @rdname get_qualite_rivieres
get_qualite_rivieres_station <- function(...) {
  l <- doApiQuery(api = "qualite_rivieres",
                  endpoint = "station_pc",
                  ...)
  convert_list_to_tibble(l) %>% fix_encoding_libelle_station
}

#' @export
#' @rdname get_qualite_rivieres
get_qualite_rivieres_station_pc <- get_qualite_rivieres_station

fix_encoding_libelle_station <- function(df) {
  if ("libelle_station" %in% names(df)) {
    return(df %>% mutate(libelle_station = iconv(libelle_station, to = "iso8859-1", from = "utf8")))
  }
  return(df)
}
