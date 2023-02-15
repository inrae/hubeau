#' Retrieve data from API "Qualité des nappes d'eau souterraines"
#'
#' @description
#' The data originate from the "ADES" database (\url{https://ades.eaufrance.fr/}).
#' Available endpoints are:
#'
#' - `get_qualite_nappes_stations` retrieves measuring stations for groundwater quality
#' - `get_qualite_nappes_analyses` retrieves the result analysis of quality measurement
#'
#' See the API documentation for available filter parameters: \url{https://hubeau.eaufrance.fr/page/api-qualite-nappes}
#'
#' @inheritParams doApiQuery
#' @inherit convert_list_to_tibble return return
#'
#' @export
#' @rdname get_qualite_nappe
#'
#' @examples
#' \dontrun{
#' # List of available filter parameters on 'get_qualite_nappe_stations'
#' list_params("qualite_nappes", "stations")
#'
#' # List of stations available in Hérault department
#' get_qualite_nappes_stations(code_commune = 34116)
#'
#' # List of available filter parameters on 'get_qualite_eau_potable_resultats_dis'
#' list_params("qualite_nappes", "analyses")
#'
#' # Get results of analysis realised at Grabels in 2019
#' get_qualite_nappes_analyses(bss_id = "BSS002GNSA",
#'                             date_debut_prelevement = "2019-11-12")
#' }
get_qualite_nappes_analyses <- function(...) {
  l <- doApiQuery(api = "qualite_nappes",
                  endpoint = "analyses",
                  ...)

  convert_list_to_tibble(l)
}


#' @export
#' @rdname get_qualite_nappe
get_qualite_nappes_stations <- function(...) {
  l <- doApiQuery(api = "qualite_nappes",
                  endpoint = "stations",
                  ...)
  convert_list_to_tibble(l)
}

