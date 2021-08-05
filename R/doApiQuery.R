#' Main internal functions for querying the Hub'eau APIs
#'
#' The function `doQueryApi` is called by all the function querying the APIs and return the raw data sent by the API.
#' Pagination of the queries is handled automatically and the returned [list] is the concatenation of all the results sent by the API.
#'
#' The function `get_available_params` returns the list of available query parameters for a given operation in an API.
#'
#' @details The functions `get_[api]_[operation]` call the function `doQueryApi` and convert the response in a convenient format for the user ([data.frame] or [tibble::tibble])
#'
#' @param api a [character] name of the API (e.g.: "indicateurs_services", "prelevements"...), see example for available APIs
#' @param operation a [character] name of the operation, see example for available operations in an API
#' @template param_get_common
#'
#' @return A [list] with the concatenated results returned by the API.
#' @export
#' @rdname doApiQuery
#'
#' @examples
#' # To get the available APIs in the package
#' cfg <- config::get(file = system.file("config.yml", package = "hubeau"))
#' names(cfg$apis)
#'
#' # To get the available operation in an API
#' names(cfg$apis[["prelevements"]]$operations)
#'
#' # To get available parameters in operation "chroniques" of the API "prelevements"
#' get_available_params(api = "prelevements", operation = "chroniques")
#'
#' # To query the operation "chroniques" of the API "prelevements"
#' # on all devices in the commune of Romilly-sur-Seine in 2018
#' doApiQuery(api = "prelevements",
#'            operation = "chroniques",
#'            params = list(code_commune_insee = "10323", annee = "2018"))
doApiQuery <- function(api,
                       operation,
                       params,
                       cfg = config::get(file = system.file("config.yml", package = "hubeau"))) {
  availableParams <- get_available_params(api, operation, cfg)

  query <-
    file.path(cfg$api_url, cfg$apis[[api]]$path, cfg$apis[[api]]$operations[[operation]]$path)
  for (paramName in names(params)) {
    if (!paramName %in% cfg$apis[[api]]$operations[[operation]]$fields) {
      stop(
        sprintf(
          "The parameter '%s' is not available for this query. ",
          paramName
        ),
        "\n",
        sprintf(
          "Run `hubeau::get_available_params(\"%s\", \"%s\")` to get available parameters.",
          api,
          operation
        )
      )
    }
    if (!is.null(params[[paramName]])) {
      query <- urltools::param_set(query,
                                   key = paramName,
                                   value = params[[paramName]])
    }
  }
  data <- list()

  repeat {
    resp <- httr::GET(query)
    if (resp$status_code >= 400) {
      l <- NULL
      try(l <- httr::content(resp, "parsed"), TRUE)
      if (is.null(l$field_errors)) {
        stop("Error ", resp$status_code, " on query: ", query)
      } else {
        field_errors <-
          sapply(l$field_errors, function(x) {
            paste(x$field, x$message)
          })
        stop(
          "Error ",
          resp$status_code,
          " on query: ",
          query,
          "\n Error on parameters:\n",
          paste(field_errors, collapse = "\n")
        )
      }
    } else {
      l <- httr::content(resp, "parsed")
      if (as.numeric(l$count) > 20000) {
        stop("The request reach the API limitation of 20000 records.\n",
             "Use filter arguments to reduce the number of records of your request.")
      }
      data <- c(data, l$data)
      if (resp$status_code == 206) {
        query <- l$`next`
        if (is.null(query)) {
          # Bug https://github.com/BRGM/hubeau/issues/72
          break
        }
      }
      if (resp$status_code == 200) {
        break
      }
    }
  }
  return(data)
}
