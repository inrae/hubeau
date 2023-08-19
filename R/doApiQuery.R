#' Main internal functions for querying the Hub'Eau API endpoints
#'
#' The function `doQueryApi` is called by all the function querying the API
#' endpoints and return the raw data sent by the endpoint.
#'
#' Pagination of the queries is handled automatically and the returned [list] is
#' the concatenation of all the results sent by the API.
#'
#' @details The functions `get_[api]_[endpoint]` call the function `doQueryApi`
#' and parse the response in a [tibble::tibble] format for the user (See [convert_list_to_tibble]).
#'
#' By default the user agent used for the query is "`r .cfg$user_agent`".
#' You can redefined the user agent with the global option
#' "hubeau.user_agent": `options(hubeau.user_agent = "My user agent")`.
#'
#' @param api a [character] name of the API (e.g.: "indicateurs_services", "prelevements"...), see example for available APIs
#' @param endpoint a [character] name of the endpoint, see example for available endpoints in an API
#' @param ... parameters of the queries and their values in the format
#'        `Param1_Name = "Param1 value", Param2_Name = "Param2 value"`, use the
#'        function [list_params] for a list of the available filter parameters
#'        for a given API endpoint and see the API documentation for their description
#' @param params (deprecated) a [list] the list of parameters of the queries and their
#'        values in the format `list(ParamName = "Param value", ...)`. This parameter
#'        is replaced by the parameter `...`
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
#' \dontrun{
#' resp <- doApiQuery(api = "prelevements",
#'                    endpoint = "chroniques",
#'                    code_commune_insee = "10323",
#'                    annee = "2018")
#' convert_list_to_tibble(resp)
#' }
doApiQuery <- function(api,
                       endpoint,
                       ..., params) {

  if (!missing(...)) {
    p_ellipsis <- convert_ellipsis_to_params(...)
  }
  if (!missing(params)) {
    warning("The use of the parameter `params` is deprecated and can be removed ",
            "in a future version. Please use the argument `...` instead.")
    if (!missing(...)) {
      stop("Parameters `...` and `params` can't be used together")
    }
  }
  if (!missing(...)) params <- p_ellipsis
  if (missing(params)) params <- list()

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
      if (length(params[[paramName]]) > 1) {
        params[[paramName]] <- paste(params[[paramName]], collapse = ",")
      }
      query <- urltools::param_set(query,
                                   key = paramName,
                                   value = params[[paramName]])
    }
  }
  user_agent <- options("hubeau.user_agent")[[1]]
  if(is.null(user_agent)) user_agent <- .cfg$user_agent
  user_agent <- httr::user_agent(user_agent)

  data <- list()

  repeat {
    resp <- httr::GET(query, user_agent)
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
        data <- list()
        break
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
  attr(data, "query") <- query
  return(data)
}

convert_ellipsis_to_params <- function(...) {
  params <- list(...)
  if (length(params) == 1 && is.null(names(params))) {
    params <- params[[1]]
  }
  if (any(names(params) == "")) {
    stop("All filter parameters have to be named.\n",
         "For example:\n",
         "`get_qualite_nappes_stations(code_commune = 34116)` is correct\n",
         "`get_qualite_nappes_stations(34116)` is wrong\n")
  }
  return(params)
}


#' Convert list provided by the APIs into a tibble
#'
#' @param l a [list] provided by the API (See [doApiQuery])
#'
#' @details
#' This function is used internally by all the retrieving data functions for
#' converting data after the call to [doApiQuery].
#'
#' @return A [tibble::tibble] with one row by record and one column by field.
#'
#' @export
#' @import dplyr
#'
#' @inherit doApiQuery return examples
#'
convert_list_to_tibble <- function(l) {
  query <- attr(l, "query")
  l <-
    lapply(l, function(row) {
      l_row <- lapply(row, function(cell) {
        if (is.null(unlist(cell))) {
          NA
        } else {
          cell
        }
      })
      list.flatten(l_row)
    })
  df <- purrr::map_df(l, tibble::as_tibble)
  attr(df, "query") <- query
  return(df)
}

#' Flatten a nested list to a one-level list
#'
#' @details
#' This function is part of the rlist package \url{https://cran.r-project.org/package=rlist}
#' as it existed the 2023-02-14.
#'
#' The function is essentially a slightly modified version of \code{flatten2}
#' provided by Tommy at \href{https://stackoverflow.com/a/8139959/2906900}{stackoverflow.com} who
#' has full credit of the implementation of this function.
#'
#' @param x \code{list}
#' @param use.names \code{logical}. Should the names of \code{x} be kept?
#' @param classes A character vector of class names, or "ANY" to match any class.
#' @author \href{https://stackoverflow.com/users/662787/tommy}{Tommy}
#' @noRd
#' @examples
#' p <- list(a=1,b=list(b1=2,b2=3),c=list(c1=list(c11='a',c12='x'),c2=3))
#' list.flatten(p)
#'
#' p <- list(a=1,b=list(x="a",y="b",z=10))
#' list.flatten(p, classes = "numeric")
#' list.flatten(p, classes = "character")
list.flatten <- function(x, use.names = TRUE, classes = "ANY") {
  len <- sum(rapply(x, function(x) 1L, classes = classes))
  y <- vector("list", len)
  i <- 0L
  items <- rapply(x, function(x) {
    i <<- i + 1L
    y[[i]] <<- x
    TRUE
  }, classes = classes)
  if (use.names && !is.null(nm <- names(items)))
    names(y) <- nm
  y
}

