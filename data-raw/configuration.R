## code to prepare `.cfg` dataset

update.packages("config")
library(httr)

.cfg <- config::get(file = "data-raw/config.yml")

defineApis <- function(api, cfg) {
  message("Processing API: ", api$path)
  query <- file.path(cfg$api_url, cfg$api_path, api$path, cfg$api_docs)
  d <- content(GET(query), as = "parsed")
  sapply(c("swagger", "openapi"), function(fmt) {
    if (!is.null(d[[fmt]])) {
      message(fmt, " ", d[[fmt]])
    }
  })
  path_endpoints <- names(d$paths)
  path_endpoints <- path_endpoints[!grepl("\\.(csv|xml)$", path_endpoints)]
  endpoints <- basename(path_endpoints)
  fields <- lapply(path_endpoints, function(ep) {
    if(!is.null(d$paths[[ep]]$get$parameters)) {
      sapply(d$paths[[ep]]$get$parameters, "[[", "name")
    }
  })
  l <- lapply(seq_along(endpoints), function(i) {
    path <- file.path(d$basePath, path_endpoints[i])
    path <- gsub("^/+", "", path)
    path <- gsub("//", "/", path)
    list(path = path,
         fields = fields[[i]])
  })
  names(l) <- endpoints
  return(list(path = api$path, endpoints = l))
}

.cfg$apis <- lapply(.cfg$apis, defineApis, cfg = .cfg)

# Fix issue https://github.com/BRGM/hubeau/issues/127
ecoulement_ep <- names(.cfg$apis$ecoulement$endpoints)
for (ep in ecoulement_ep) {
  for (f in c("page", "fields")) {
    which_fields <- which(grepl(f, .cfg$apis$ecoulement$endpoints[[ep]]$fields))
    .cfg$apis$ecoulement$endpoints[[ep]]$fields[which_fields] <- f
  }
}

usethis::use_data(.cfg, overwrite = TRUE, internal = TRUE)
