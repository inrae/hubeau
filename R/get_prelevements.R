#' Retrieve data from API "Prélèvements en eau"
#'
#' @description
#' Available endpoints are:
#'
#' - `get_prelevements_points_prelevement` retrieves withdrawal points
#' - `get_prelevements_ouvrages` retrieves withdrawal devices
#' - `get_prelevements_chroniques` retrieves time series of withdrawals
#'
#' See the API documentation for available filter parameters: \url{https://hubeau.eaufrance.fr/page/api-prelevements-eau}
#'
#' @inheritParams doApiQuery
#'
#' @rdname get_prelevements
#' @export
#'
#' @examples
#' # Retrieve the withdrawal points located in Romilly-sur-Seine
#' get_prelevements_points_prelevement(list(code_commune_insee = "10323"))
#'
#' # Retrieve the withdrawal devices located in Romilly-sur-Seine
#' get_prelevements_ouvrages(list(code_commune_insee = "10323"))
#'
#' # Retrieve the withdrawal time series of the devices located in Romilly-sur-Seine
#' get_prelevements_chroniques(list(code_commune_insee = "10323"))
#'
get_prelevements_points_prelevement <- function(params) {
  l <- doApiQuery(api = "prelevements",
                  endpoint = "points_prelevement",
                  params = params)

  convert_list_to_tibble(l)
}

#' @rdname get_prelevements
#' @export
get_prelevements_ouvrages <- function(params) {
  l <- doApiQuery(api = "prelevements",
                  endpoint = "ouvrages",
                  params = params)
  l <- lapply(l, function(x) {
    x$geometry <- NULL
    x$codes_points_prelevements <- NULL
    x
  })

  convert_list_to_tibble(l)
}

#' @rdname get_prelevements
#' @export
get_prelevements_chroniques <- function(params) {
  l <- doApiQuery(api = "prelevements",
                  endpoint = "chroniques",
                  params = params)
  l <- lapply(l, function(x) {
    x$geometry <- NULL
    x
  })
  convert_list_to_tibble(l)
}
