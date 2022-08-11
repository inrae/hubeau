#' @rdname lists
#' @export
list_endpoints <- function(api) {
  names(.cfg$apis[[api]]$endpoints)
}
