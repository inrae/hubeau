#' Retrieve data from API "Hydrométrie"
#'
#' @description
#'
#' Available endpoints are:
#'
#' - `get_hydrometrie_obs_elab` retrieves hydrometric elaborate observations (daily/monthly mean flow)
#' - `get_hydrometrie_observations_tr` retrieves hydrometric "real time" observations ()
#' - `get_hydrometrie_sites` retrieves hydrometric sites
#' - `get_hydrometrie_stations` retrieves hydrometric stations
#'
#' See the API documentation of each endpoint for available filter parameters:
#' \url{https://hubeau.eaufrance.fr/page/api-hydrometrie}
#'
#' @inheritParams doApiQuery
#' @inherit convert_list_to_tibble return return
#'
#' @export
#' @rdname get_hydrometrie
#' @examples
#' \dontrun{
#' # Retrieve the hydrometric sites in the department of Aube
#' get_hydrometrie_sites(code_departement = "10")
#'
#' # The same operation returning 2 rows for the site 'H0203020' which has 2 different locations
#' get_hydrometrie_sites(code_departement = "10", unique_site = FALSE)
#'
#' # Retrieve the hydrometric stations in the department of Aube
#' get_hydrometrie_stations(code_departement = "10")
#'
#' # Which parameters are available for endpoint "obs_elab" of API "hydrometrie"?
#' list_params("hydrometrie", "obs_elab")
#'
#' # Retrieve the hydrometric monthly mean flow at site 'H0203020'
#' get_hydrometrie_obs_elab(code_entite = "H0203020", grandeur_hydro_elab = "QmM")
#'
#' # Retrieve the hydrometric daily mean flow at site 'H0203020' of the last 30 days
#' get_hydrometrie_obs_elab(code_entite = "H0203020",
#'                          date_debut_obs_elab = format(Sys.Date() -30, "%Y-%m-%d"),
#'                          grandeur_hydro_elab = "QmJ")
#' }
get_hydrometrie_obs_elab <- function(...) {
  l <- doApiQuery(
    api = "hydrometrie",
    endpoint = "obs_elab",
    ...
  )
  convert_list_to_tibble(l)
}


#' @param entities 1-length [character] string filtering the rows of the returned value, possible values are: "station" for filtering on station rows, "site" for filtering on site rows, "both" for keeping all the rows
#' @rdname get_hydrometrie
#' @export
get_hydrometrie_observations_tr  <- function(...,
                                             entities = "station") {
  # Checks
  if(!entities %in% c("station", "site", "both")) {
    stop("Argument 'entities' must be one of these values: 'station', 'site', 'both'")
  }

  l <- doApiQuery(
    api = "hydrometrie",
    endpoint = "observations_tr",
    ...
  )
  if(!is.null(l)) {
    l <- lapply(l, function(x) {
      if (entities == "station") {
        if (is.null(x$code_station)) {
          return(NULL)
        }
      } else if (entities == "site") {
        if (!is.null(x$code_station)) {
          return(NULL)
        }
      }
      return(x)
    })
    l[sapply(l, is.null)] <- NULL
    l <- convert_list_to_tibble(l)
  }
  return(l)
}


#' @param unique_site optional [logical], if set to `FALSE` sites with several different locations produce one row by different location otherwise the first location found is used for fields `code_commune_site`, `libelle_commune`, `code_departement`, `code_region`, `libelle_region`, `libelle_departement`
#' @rdname get_hydrometrie
#' @export
get_hydrometrie_sites  <- function(...,
                                   unique_site = TRUE) {
  l <- doApiQuery(
    api = "hydrometrie",
    endpoint = "sites",
    ...
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
    x
  })
  convert_list_to_tibble(l)
}


#' @param code_sandre_reseau_station optional [logical] indicating
#'        if `code_sandre_reseau_station` field is included in the result;
#'        if so, one line is added by item and other fields are repeated
#' @rdname get_hydrometrie
#' @export
get_hydrometrie_stations  <- function(..., code_sandre_reseau_station = FALSE) {
  l <- doApiQuery(api = "hydrometrie",
                  endpoint = "stations",
                  ...)
  l <- lapply(l, function(x) {
    if (!code_sandre_reseau_station) {
      x$code_sandre_reseau_station <- NULL
    }
    x
  })
  convert_list_to_tibble(l)
}
