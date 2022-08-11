#' List available Hub'Eau APIs, endpoints and filter parameters
#'
#' @description
#' `list_apis()` returns the list of available APIs in the package.
#'
#' `list_endpoints()` returns the list of available endpoints for an API.
#'
#' `list_params()` returns the list of available parameters for an API endpoint.
#'
#' @inheritParams doApiQuery
#'
#' @details
#' The listed APIs correspond to the term `[API]` used in the name of the
#' functions `get_[API]_[endpoint]` used for querying the APIs.
#'
#' @return [character] [vector] of APIs, endpoints or filter parameters
#' @export
#' @rdname lists
#'
#' @examples
#' # To get the available APIs in the package
#' list_apis()
#'
#' # To get the available endpoints in an API
#' list_endpoints("prelevements")
#'
#' # To get available parameters in endpoint "chroniques" of the API "prelevements"
#' list_params(api = "prelevements", endpoint = "chroniques")
#'
list_apis <- function() {
  names(.cfg$apis)
}
