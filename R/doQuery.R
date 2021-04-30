#' Internal function for doing the queries for the bnpe package
#'
#' @param url_path the end of the URL path
#' @param params A list containing the parameters sent in the query
#' @inheritParams getCookie
#' @param cookie a named [character] [vector] with the values of the cookies (See [getCookie])
#'
#' @return a [httr::response] object from a [httr::GET]
#' @export
#'
doQuery <- function(url_path,
                    params = list(code_usage = NULL,
                                  code_type_eau = NULL,
                                  commune_adj = NULL,
                                  ecrasant = "false"),
                    cfg = config::get(file = system.file("config.yml", package = "bnpe")),
                    cookie = getCookie(cfg)) {

  paramsDef <- list(code_usage = NULL,
                    code_type_eau = NULL,
                    commune_adj = NULL,
                    ecrasant = "false")
  params <- utils::modifyList(paramsDef, as.list(params))

  # Building URL query https://website/?param1=value1&param2=value2...
  query <- file.path(cfg$url, url_path)
  for (paramName in names(params)) {
    if (!is.null(params[[paramName]])) {
      query <- urltools::param_set(query,
                                   key = paramName,
                                   value = params[[paramName]])
    }
  }

  # Request
  resp <- httr::GET(query,
                    httr::user_agent(cfg$user_agent),
                    httr::set_cookies(.cookies = cookie))
  if(length(grep("<title>Request Rejected</title>", httr::content(resp, "text"))) > 0) {
    stop("The following URL request has been rejected: ", query)
  }
  return(resp)
}
