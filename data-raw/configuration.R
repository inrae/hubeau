## code to prepare `.cfg` dataset

update.packages("config")
.cfg <- config::get(file = "data-raw/config.yml")

usethis::use_data(.cfg, overwrite = TRUE, internal = TRUE)
