#' @param params a [list] the list of parameters of the queries and their values in the format `list(ParamName = "Param value", ...)`, use the function [get_available_params] for a list of the available query parameters for a given API endpoint and see the API documentation for their descriptions
#' @param cfg a [config] object describing the configuration of the APIs. Use the internal package configuration by default
#'        configuration
#'
#' @return a [tibble::tibble] with all available parameters in columns.
#'
#' @seealso [doApiQuery] for more details on the API querying process.
