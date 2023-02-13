skip_on_cran()
package <- "hubeau"

with_warnings <- c("get_hydrometrie_obs_elab")

db <- tools::Rd_db(package)

lapply(db, function(Rd_fun) {
  tags <- tools:::RdTags(Rd_fun)
  which_ex <- which(tags=="\\examples")
  name <- unlist(Rd_fun[tags == "\\name"])
  if (length(which_ex) > 0) {
    ex <- unlist(Rd_fun[which_ex])
    ex <- gsub("\n", "", ex)
    ex <- c("interactive <- function() TRUE", ex)
    file <- file.path(tempdir(), paste0(name, ".R"))
    writeLines(ex, file)
    test_that(paste("Examples", name, "run without error"), {
      if (name %in% with_warnings) {
        suppressWarnings(source(file))
      } else {
        source(file)
      }
      expect_equal(TRUE, TRUE)
    })
  }
})


