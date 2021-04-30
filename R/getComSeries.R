#' Retrieve data by commune for one departement and one year
#'
#' @param code_dep [character] of length 2
#' @param year [numeric] Year of the data to retrieve
#' @template param_get_common
#'
#' @return [data.frame] with one row by commune and two columns: "insee_com" and "volume"
#' @export
#'
#' @examples
#' getComSeriesDep("08", 2016, code_usage = "AEP", code_type_eau = "CONT")
getComSeriesDep <- function(code_dep,
                            year,
                            code_usage = NULL,
                            code_type_eau = NULL,
                            cfg = config::get(file = system.file("config.yml", package = "bnpe")),
                            cookie = getCookie(cfg)) {
  params <- list(
    code_dep = code_dep,
    annee = year,
    code_usage = code_usage,
    code_type_eau = code_type_eau
  )

  resp <- doQuery(url_path = cfg$url_com_series,
                  params = params,
                  cfg = cfg,
                  cookie = cookie)
  l <- httr::content(resp, "parsed")
  codesInsee <- sapply(l$features, function(x) { x$properties$codeInsee })
  hasVolume <- sapply(l$features, function(x) { !is.null(x$properties$volume) })
  volumes <- unlist(sapply(l$features, function(x) { x$properties$volume }))
  data.frame(insee_com = codesInsee[hasVolume], volume = volumes)
}
