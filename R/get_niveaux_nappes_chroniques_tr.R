#' Retrieve piezometric "real time" chroniques from API "Piézométrie"
#'
#' See the API documentation for available filter parameters: \url{https://hubeau.eaufrance.fr/page/api-piezometrie}
#'
#' @template param_get_common
#'
#' @return a [tibble::tibble] with all available parameters in columns and one row by time step and by station.
#' @export
#'
#' @examples
#' # For retrieving the last real time observed piezometric level at station 'BSS001VZGZ' (new BSS identifier)
#' df <- get_niveaux_nappes_chroniques_tr(list(bss_id = "BSS001VZGZ"))
#'
#' # Plot the water elevation (NGF)
#' plot(as.POSIXct(df$date_mesure), df$niveau_eau_ngf, type = "l")
get_niveaux_nappes_chroniques_tr  <- function(params,
                                   cfg = config::get(file = system.file("config.yml",
                                                        package = "hubeau"))) {
  l <- doApiQuery(
    api = "niveaux_nappes",
    operation = "chroniques_tr",
    params = params,
    cfg = cfg
  )
  convert_list_to_tibble(l)
}
