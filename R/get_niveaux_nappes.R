#' Retrieve data from API "Piézométrie"
#'
#' @description
#' The available endpoints are:
#'
#' - `get_niveaux_nappes_stations` retrieves list of piezometric stations
#' - `get_nappes_chroniques` retrieves piezometric archived time series
#' - `get_nappes_chroniques_tr` retrieves piezometric "real time" data
#'
#' See the API documentation for available filter parameters: \url{https://hubeau.eaufrance.fr/page/api-piezometrie}
#'
#' @inheritParams doApiQuery
#' @inherit convert_list_to_tibble return return
#'
#' @rdname get_niveaux_nappes
#' @export
#'
#' @examples
#' \dontrun{
#' # Retrieve the hydrometric stations in the department of Aube
#' get_niveaux_nappes_stations(list(code_departement = "10"))
#'
#' # Retrieve the archived observed piezometric level at station '07548X0009/F' (old BSS identifier)
#' # for the year 2020
#' df <- get_niveaux_nappes_chroniques(list(code_bss = "07548X0009/F",
#'                                       date_debut_mesure = "2020-01-01",
#'                                       date_fin_mesure = "2020-12-31"))
#'
#' # Plot the water elevation (NGF)
#' plot(as.POSIXct(df$date_mesure), df$niveau_nappe_eau, type = "l")
#'
#' # For retrieving the last real time observed piezometric level
#' # at station 'BSS001VZGZ' (new BSS identifier)
#' df <- get_niveaux_nappes_chroniques_tr(list(bss_id = "BSS001VZGZ"))
#'
#' # Plot the water elevation (NGF)
#' plot(as.POSIXct(df$date_mesure), df$niveau_eau_ngf, type = "l")
#' }
get_niveaux_nappes_stations  <- function(...) {
  l <- doApiQuery(api = "niveaux_nappes",
                  endpoint = "stations",
                  ...)
  convert_list_to_tibble(l)
}

#' @rdname get_niveaux_nappes
#' @export
get_niveaux_nappes_chroniques  <- function(...) {
  l <- doApiQuery(
    api = "niveaux_nappes",
    endpoint = "chroniques",
    ...
  )
  convert_list_to_tibble(l)
}

#' @rdname get_niveaux_nappes
#' @export
get_niveaux_nappes_chroniques_tr  <- function(...) {
  l <- doApiQuery(
    api = "niveaux_nappes",
    endpoint = "chroniques_tr",
    ...
  )
  convert_list_to_tibble(l)
}
