#' Retrieve hydrometric sites from API "Hydrométrie"
#'
#' See the API documentation for available filter parameters: \url{https://hubeau.eaufrance.fr/page/api-hydrometrie}
#'
#' @template param_get_common
#' @param unique_site optional [logical], if set to `FALSE` sites with several different locations produce one row by different location otherwise the first location found is used for fields `code_commune_site`, `libelle_commune`, `code_departement`, `code_region`, `libelle_region`, `libelle_departement`
#'
#' @return a [tibble::tibble] with all available parameters in columns and one row by device, year and usage.
#' @export
#'
#' @examples
#' # For retrieving the hydrometric sites in the department of Aube
#' get_hydrometrie_sites(list(code_departement = "10"))
#'
#' # The same operation returning 2 rows for the site 'H0203020' which has 2 different locations
#' get_hydrometrie_sites(list(code_departement = "10"), unique_site = FALSE)
#'
get_hydrometrie_sites  <- function(params,
                                   unique_site = TRUE,
                                   cfg = config::get(file = system.file("config.yml",
                                                        package = "hubeau"))) {
  l <- doApiQuery(
    api = "hydrometrie",
    operation = "sites",
    params = params,
    cfg = cfg
  )
  l <- lapply(l, function(x) {
    fields <-
      c(
        "code_commune_site",
        "libelle_commune",
        "code_departement",
        "code_region",
        "libelle_region",
        "libelle_departement"
      )
    bFirst <- TRUE
    for (field in fields) {
      if (!is.null(x[[field]])) {
        fieldValue <- unique(unlist(x[[field]]))
        if (unique_site && length(fieldValue) > 1) {
          if(bFirst) {
            warning(
              "The site '",
              x$code_site,
              "' has ",
              length(fieldValue),
              " different locations, only the first one is returned",
              call. = FALSE
            )
            bFirst <- FALSE
          }
          fieldValue <- x[[field]][[1]]
        }
        x[[field]] <- fieldValue
      }
    }
    x$geometry <- NULL
    x
  })
  convert_list_to_tibble(l)
}
