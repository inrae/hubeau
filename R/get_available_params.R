#' List available query parameters of an API endpoint
#'
#' @inheritParams doApiQuery
#'
#' @return A [character] vector with available query parameters for the requested API/endpoint
#'
#' @export
#' @inherit doApiQuery examples
#'
get_available_params <- function(api,
                                 endpoint,
                                 cfg = config::get(file = system.file("config.yml",
                                                                      package = "hubeau"))) {
  if (is.null(cfg$apis[[api]])) {
    stop("The API '", api, "' is not available on Hub'eau, or is not implemented in the package")
  }
  if (is.null(cfg$apis[[api]]$endpoints[[endpoint]])) {
    stop("The endpoint '", endpoint, "' is not available for this API, or is not implemented in the package")
  }
  cfg$apis[[api]]$endpoints[[endpoint]]$fields
}
