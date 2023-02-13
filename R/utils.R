#' Selected the non-list elements in a nested list
#'
#' @param my_list A nested list
#'
#' @return The initial nested list omitting its list-class slots
#' @noRd
#' @importFrom purrr map map_df
#' @rdname utils
#'
#' @examples
#' \dontrun{
#' l <- doApiQuery(api = "hydrobio",
#'                 endpoint = "stations_hydrobio",
#'                 params = list(code_region = 52))
#'
#' select_non_nested(l) %>%
#'   select(-code_commune,
#'          -libelle_departement,
#'          -(libelle_region:longitude)) %>%
#'   distinct()
#' }
select_non_nested <- function(my_list)

{
  lists <- my_list[[1]] %>%
    map(.f = is.list) %>%
    unlist()

  my_vars <- my_list[[1]][!lists] %>%
    names()

  map_df(.x = my_list,
         .f = function(liste) liste[my_vars])

}
