#' Main internal functions for querying the Hub'eau API endpoints
#'
#' The function `doQueryApi` is called by all the function querying the API endpoints and return the raw data sent by the endpoint.
#' Pagination of the queries is handled automatically and the returned [list] is the concatenation of all the results sent by the API.
#'
#' @details The functions `get_[api]_[endpoint]` call the function `doQueryApi` and convert the response in a convenient format for the user ([data.frame] or [tibble::tibble])
#'
#' @param api a [character] name of the API (e.g.: "indicateurs_services", "prelevements"...), see example for available APIs
#' @param endpoint a [character] name of the endpoint, see example for available endpoints in an API
#' @param params a [list] the list of parameters of the queries and their values in the format `list(ParamName = "Param value", ...)`, use the function [list_params] for a list of the available filter parameters for a given API endpoint and see the API documentation for their description
#'
#' @return A [list] with the concatenated results returned by the API.
#' @export
#' @rdname doApiQuery
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
#' # To query the endpoint "chroniques" of the API "prelevements"
#' # on all devices in the commune of Romilly-sur-Seine in 2018
#' doApiQuery(api = "prelevements",
#'            endpoint = "chroniques",
#'            params = list(code_commune_insee = "10323", annee = "2018"))
doApiQuery <- function(api,
                       endpoint,
                       params) {
  availableParams <- list_params(api, endpoint)

  query <-
    file.path(.cfg$api_url, .cfg$apis[[api]]$path, .cfg$apis[[api]]$endpoints[[endpoint]]$path)
  for (paramName in names(params)) {
    if (!paramName %in% .cfg$apis[[api]]$endpoints[[endpoint]]$fields) {
      stop(
        sprintf(
          "The parameter '%s' is not available for this query. ",
          paramName
        ),
        "\n",
        sprintf(
          "Run `hubeau::list_params(\"%s\", \"%s\")` to get available parameters.",
          api,
          endpoint
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
        stop(
          "The request reach the API limitation of 20000 records.\n",
          "Use filter arguments to reduce the number of records of your query."
        )
      } else if(as.numeric(l$count) == 0) {
        return(NULL)
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


#' Convert list provided by the APIs into a tibble
#'
#' @param l a [list] provided by the API (See [doApiQuery])
#'
#' @details
#' This function is used internally by all the retrieving data functions for
#' converting data after the call to [doApiQuery].
#'
#' @return a [tibble::tibble] with one row by list item and one column by list sub-item
#'
#' @export
#'
convert_list_to_tibble <- function(l) {
  l <-
    lapply(l, function(row) {
      lapply(row, function(cell) {
        if (is.null(unlist(cell)))
          NA
        else
          unlist(cell)
      })
    })
  return(purrr::map_df(l, tibble::as_tibble))
}
