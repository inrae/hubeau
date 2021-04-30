#' Get cookie from the BNPE website in order to be able to do requests
#'
#' By default it is automatically called at each request but this function
#' can be used once to store a unique cookie and avoiding asking a cookie for each request (See example).
#'
#' @param cfg a [config] object Configuration of the communication. Use by default the internal package
#'        configuration stored at location `system.file("config.yml", package = "bnpe")`
#'
#' @return a named [character] [vector] with the values of the cookies
#' @export
#'
#' @examples
#' cookie <- getCookie()
#' getTimeSeriesDep("08", cookie = cookie)
#' getTimeSeriesCom("08105", cookie = cookie)
getCookie <- function(cfg = config::get(file = system.file("config.yml", package = "bnpe"))) {
  URL1 <- paste0(urltools::scheme(cfg$url), "://", urltools::domain(cfg$url))
  userAgent <- httr::user_agent(cfg$user_agent)
  resp <- httr::GET(URL1, userAgent)
  ck <- httr::cookies(resp)$value
  names(ck) <- httr::cookies(resp)$name
  return(ck)
}
