#' @param params a [list] the list of parameters of the queries and their values in the format `list(ParamName = "Param value", ...)`, use the function [get_available_params] for a list of the available filter parameters for a given operation in an API and see the API documentation for their description
#' @param cfg a [config] object describing the configuration of the APIs. Use the internal package configuration by default
#'        configuration
#'
#' @return a [tibble::tibble] with all available parameters in columns.
#'
#' @seealso [doApiQuery] for more details on the API querying process.
