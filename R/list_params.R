#' @rdname lists
#' @export
list_params <- function(api,
                        endpoint) {
  if (is.null(.cfg$apis[[api]])) {
    stop("The API '", api, "' is not available on Hub'eau, or is not implemented in the package")
  }
  if (is.null(.cfg$apis[[api]]$endpoints[[endpoint]])) {
    stop("The endpoint '", endpoint, "' is not available for this API, or is not implemented in the package")
  }
  .cfg$apis[[api]]$endpoints[[endpoint]]$fields
}
