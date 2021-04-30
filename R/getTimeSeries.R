#' Get withdrawal time series for a geographical entity
#' @param insee_com a [character] of length 5 representing the INSEE code of the commune
#' @template param_get_common
#'
#' @return a [data.frame] with one year by row and the following columns:
#'         - "volume" the withdrawal annual volume in cubic meters
#'         - "annee" the year
#'         - "peuplement" a unknown code
#' @export
#' @rdname getTimeSeries
#'
#' @examples
#' # Withdrawal time series for Ardennes department
#' getTimeSeriesDep("08")
#'
#' # Withdrawal time series for the commune of Charleville-Mézières
#' getTimeSeriesCom("08105")
#'
getTimeSeriesCom <- function(insee_com,
                             code_usage = NULL,
                             code_type_eau = NULL,
                             cfg = config::get(file = system.file("config.yml", package = "bnpe")),
                             cookie = getCookie(cfg)) {
    getTimeSeries(level = "commune",
                  id_name = "insee_com",
                  id_value = insee_com,
                  commune_adj = "false",
                  cfg = cfg,
                  cookie = cookie)
  }

#' @param insee_dep a [character] of length 2 representing the INSEE code of the commune
#' @rdname getTimeSeries
#' @export
getTimeSeriesDep <- function(insee_dep,
                             code_usage = NULL,
                             code_type_eau = NULL,
                             cfg = config::get(file = system.file("config.yml", package = "bnpe")),
                             cookie = getCookie(cfg)) {
  getTimeSeries(level ="departement",
                id_name = "code_dep",
                id_value = insee_dep,
                code_usage = code_usage,
                code_type_eau = code_type_eau,
                cfg = cfg,
                cookie = cookie)
}


#' @param level [character] geographical level ("commune", "departement", ...)
#' @param id_name geographical identifier name ("insee_com", "code_dep", ...)
#' @param id_value geographical identifier value ("08105", "08", ...)
#' @inherit getTimeSeries
#' @noRd
getTimeSeries <-
  function(level,
           id_name,
           id_value,
           code_usage = NULL,
           code_type_eau = NULL,
           commune_adj = NULL,
           cfg = config::get(file = system.file("config.yml", package = "bnpe")),
           cookie = getCookie(cfg)) {

    params <- list(
      id = id_value,
      code_usage = code_usage,
      code_type_eau = code_type_eau,
      commune_adj = commune_adj
    )
    names(params)[names(params) == "id"] <- id_name

    resp <- doQuery(url_path = paste(cfg$url_time_series, level, sep = "_"),
                    params = params, cfg = cfg, cookie = cookie)

    # return a data.frame
    do.call(rbind, httr::content(resp, "parsed"))
  }
