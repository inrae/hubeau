#' Retrieve data from API "Qualité de l'eau potable"
#'
#' @description
#' The data originate from the "NAIADES" database.
#' Available endpoints are:
#'
#' - `get_qualite_eau_potable_communes_udi` retrieves links between "UDI"
#'   (Distribution units or networks) and communes
#' - `get_qualite_eau_potable_resultats_dis` retrieves Samples, analysis results
#'   and sanitary conclusions from the sanitary control of the distributed water
#'   commune by commune
#'
#' See the API documentation for available filter parameters: \url{https://hubeau.eaufrance.fr/page/api-qualite-eau-potable}
#'
#' @inheritParams doApiQuery
#' @inherit convert_list_to_tibble return return
#'
#' @export
#' @rdname get_qualite_eau_potable
#'
#' @examples
#' # List of available filter parameters on 'get_qualite_eau_potable_communes_udi'
#' list_params("qualite_eau_potable", "communes_udi")
#'
#' # List of UDIs available in 2022 at Grabels (INSEE code 34116)
#' get_qualite_eau_potable_communes_udi(list(annee = 2022, code_commune = 34116))
#'
#' # List of available filter parameters on 'get_qualite_eau_potable_resultats_dis'
#' list_params("qualite_eau_potable", "resultats_dis")
#'
#' # Get results of analysis realised at Grabels in 2022
#' get_qualite_eau_potable_resultats_dis(
#'   list(code_commune = 34116,
#'        date_min_prelevement = "2000-01-01",
#'        date_max_prelevement = "2022-12-31")
#' )
#'
get_qualite_eau_potable_communes_udi <- function(params) {
  l <- doApiQuery(api = "qualite_eau_potable",
                  endpoint = "communes_udi",
                  params = params)

  convert_list_to_tibble(l)
}


#' @export
#' @rdname get_qualite_eau_potable
get_qualite_eau_potable_resultats_dis <- function(params) {
  l <- doApiQuery(api = "qualite_eau_potable",
                  endpoint = "resultats_dis",
                  params = params)

  convert_list_to_tibble(l)
}
