#' Retrieve piezometric archived time series from API "Piézométrie"
#'
#' See the API documentation for available filter parameters: \url{https://hubeau.eaufrance.fr/page/api-piezometrie}
#'
#' @template param_get_common
#'
#' @return a [tibble::tibble] with all available parameters in columns and one row by time step and by station.
#' @export
#'
#' @examples
#' # Retrieve the archived observed piezometric level at station '07548X0009/F' (old BSS identifier)
#' # for the year 2020
#' df <- get_niveaux_nappes_chroniques(list(code_bss = "07548X0009/F",
#'                                       date_debut_mesure = "2020-01-01",
#'                                       date_fin_mesure = "2020-12-31"))
#'
#' # Plot the water elevation (NGF)
#' plot(as.POSIXct(df$date_mesure), df$niveau_nappe_eau, type = "l")
#'
get_niveaux_nappes_chroniques  <- function(params,
                                   cfg = config::get(file = system.file("config.yml",
                                                        package = "hubeau"))) {
  l <- doApiQuery(
    api = "niveaux_nappes",
    operation = "chroniques",
    params = params,
    cfg = cfg
  )
  convert_list_to_tibble(l)
}
