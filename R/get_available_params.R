#' @rdname doApiQuery
#' @export
#'
get_available_params <- function(api,
                                 operation,
                                 cfg = config::get(file = system.file("config.yml",
                                                                      package = "hubeau"))) {
  if (is.null(cfg$apis[[api]])) {
    stop("The API '", api, "' is not available on Hub'eau, or is not implemented in the package")
  }
  if (is.null(cfg$apis[[api]]$operations[[operation]])) {
    stop("The operation '", operation, "' is not available for this API, or is not implemented in the package")
  }
  cfg$apis[[api]]$operations[[operation]]$fields
}
