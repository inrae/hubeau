#' Retrieve data by device ("ouvrage") (metadata and yearly)
#'
#' @param code_sandre [character] Sandre identifier of the device
#' @param cookie a named [character] [vector] with the values of the cookies (See [getCookie])
#' @inheritParams getCookie
#'
#' @return [list] compiling data of the device with the following items:
#' - `id`: BNPE identifier
#' - `code`: code Sandre
#' - `codeCommune`: insee code of the commune
#' - `codePrecision`: ???
#' - `codeStatut`: ???
#' - `codeTypeEau`: the withdrawal source which can take the following values:
#'        - "CONT" for continental surface
#'        - "SOUT" for subsurface
#'        - "LIT" for littoral
#' - `codeUsage`: a numeric code related to water destination: energy, canals, turbined, AEP, industry or irrigation
#' - `commentaire`: comment
#' - `exploitationDebut`: start date of the
#'
#' @export
#'
#' @examples
#' getOuvrageSeries("OPR0000200109")
getOuvrageSeries <- function(code_sandre,
                            cfg = config::get(file = system.file("config.yml",
                                                                 package = "bnpe")),
                            cookie = getCookie(cfg)) {
  params <- list(
    code = code_sandre
  )

  resp <- doQuery(url_path = cfg$url_ouvrage,
                  params = params,
                  cfg = cfg,
                  cookie = cookie)
  l <- httr::content(resp, "parsed")[[1]]

  l$exploitationDebut <- as.Date(
    format(
      as.POSIXct(l$exploitationDebut / 1000, origin = "1970-01-01", tz = "CET")
    )
  )

  params <- list(
    code_ouvrage = code_sandre,
    ecrasant = "false"
  )

  resp <- doQuery(url_path = cfg$url_ouv_series,
                  params = params,
                  cfg = cfg,
                  cookie = cookie)
  lTS <- httr::content(resp, "parsed")
  hasVolume <- sapply(lTS, function(x) { !is.null(x$volume) })
  annees <- sapply(lTS, "[[", "annee")
  volumes <- unlist(sapply(lTS, "[[", "volume"))
  peuplements <- unlist(sapply(lTS, "[[", "peuplement"))
  l$TS <- data.frame(annee = annees[hasVolume],
                     volume = volumes,
                     peuplement = peuplements[hasVolume])
  return(l)
}
