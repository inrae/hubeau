#' Retrieve data from API "Qualité des nappes d'eau souterraines"
#'
#' @description
#' The data originate from the "ADES" database (\url{https://ades.eaufrance.fr/}).
#' Available endpoints are:
#'
#' - `get_qualite_nappes_analyses` retrieves the result analysis of quality measurement
#' - `get_qualite_eau_potable_resultats_dis` retrieves measuring stations for groundwater quality
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
#' # List of stations available in 2019 in Hérault department
#' get_qualite_nappes_stations(list(num_departement = 34,
#'                                  date_min_maj = "2019-01-01",
#'                                  date_max_maj = "2019-12-31"))
#'
#' # List of available filter parameters on 'get_qualite_eau_potable_resultats_dis'
#' list_params("qualite_nappes", "analyses")
#'
#' # Get results of analysis realised at Grabels in 2019
#' get_qualite_nappes_analyses(
#'   list(bss_id = "BSS002GNSA",
#'        date_debut_prelevement = "2019-11-12")
#' )
#' }
get_qualite_nappes_analyses <- function(params) {
  l <- doApiQuery(api = "qualite_nappes",
                  endpoint = "analyses",
                  params = params)

  convert_list_to_tibble(l)
}


#' @export
#' @rdname get_qualite_nappe
get_qualite_nappes_stations <- function(params) {
  l <- doApiQuery(api = "qualite_nappes",
                  endpoint = "stations",
                  params = params)
  select_non_nested(l)
}
