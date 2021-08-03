doApiQuery <- function(url_path,
                       params,
                       cfg = config::get(file = system.file("config.yml", package = "hubeau"))) {
  query <- file.path(cfg$api$url, url_path)
  for (paramName in names(params)) {
    if (!is.null(params[[paramName]])) {
      query <- urltools::param_set(query,
                                   key = paramName,
                                   value = params[[paramName]])
    }
  }
  data <- list()
  repeat {
    resp <- httr::GET(query)
    if (resp$status_code >= 300) {
      stop("Error", resp$status_code, " on query: ", query)
    } else {
      l <- httr::content(resp, "parsed")
      data <- c(data, l$data)
      if (resp$status_code == 206) {
        query <- l$`next`
      }
      if (resp$status_code == 200) {
        break
      }
    }
  }
  return(data)
}
