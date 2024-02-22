## code to prepare `vignette_example_niveaux_nappes_api` dataset goes here
library(hubeau)
library(dplyr)

my_water_table_code <- "GG063"

stations <- get_niveaux_nappes_stations(
  codes_masse_eau_edl = my_water_table_code
)

water_table_level <- purrr::map_df(
  .x = stations$code_bss,
  .f = function(x)
    get_niveaux_nappes_chroniques(code_bss = x,
                                  date_debut_mesure = "2015-01-01")
)

water_table_level <- water_table_level %>%
  mutate(date_mesure = lubridate::ymd(date_mesure),
         year = lubridate::year(date_mesure),
         month = lubridate::month(date_mesure))

yearly_mean_water_table_level <- water_table_level %>%
  group_by(code_bss,
           year) %>%
  summarise(n_months = n_distinct(month)) %>%
  filter(n_months == 12) # complete years

yearly_mean_water_table_level <- yearly_mean_water_table_level %>%
  select(-n_months) %>%
  left_join(water_table_level) %>% # filtering join
  group_by(code_bss,
           year,
           month) %>%
  summarise(monthly_mean_water_table_level = mean(niveau_nappe_eau, na.rm = TRUE)) %>%
  group_by(code_bss,
           year) %>%
  summarise(yearly_mean_water_table_level = mean(monthly_mean_water_table_level, na.rm = TRUE)) %>%
  ungroup()

save(stations,
     yearly_mean_water_table_level,
     file = "inst/vignettes/example_niveaux_nappes_api.RData")
