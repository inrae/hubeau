
<!-- README.md is generated from README.Rmd. Please edit that file -->

# bnpe

<!-- badges: start -->

[![License:
MIT](https://img.shields.io/badge/license-MIT-orange.svg)](https://cran.r-project.org/web/licenses/MIT)
[![](https://img.shields.io/badge/lifecycle-experimental-blue.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

‘bnpe’ is an R-package proposes a collection of function to help
retrieve the French national data bank of quantitative withdrawals
(Banque Nationale des Prélèvements quantitatifs en Eau - BNPE) available
on its website: <https://bnpe.eaufrance.fr>

## Installation

You can install the bnpe R-package from it’s development repository
with:

``` r
install.packages("remotes")
remotes::install_gitlab("in-wop/bnpe", host = "gitlab.irstea.fr")
```

## Get started

### Loading library

``` r
library(bnpe)
```

### Time series

Functions for getting time series are:

  - `getTimeSeriesDep`: for one department
  - `getTimeSeriesCom`: for one commune

These functions uses the French official geographical codification
(<https://fr.wikipedia.org/wiki/Code_officiel_g%C3%A9ographique>).

Type `?getTimeSeriesCom` for getting help.

Examples:

``` r
# Time series for all type of withdrawal sources and destinations in the Ardennes departement
getTimeSeriesDep("08")
#>       volume     annee  peuplement
#>  [1,] NULL       "2008" "2"       
#>  [2,] NULL       "2009" "2"       
#>  [3,] NULL       "2010" "2"       
#>  [4,] NULL       "2011" "2"       
#>  [5,] 750878007  "2012" "1"       
#>  [6,] 1070936432 "2013" "1"       
#>  [7,] 930232502  "2014" "1"       
#>  [8,] 918264038  "2015" "1"       
#>  [9,] 899230351  "2016" "1"       
#> [10,] 790975515  "2017" "1"       
#> [11,] 324131543  "2018" "1"       
#> [12,] 163293169  "2019" "3"

# Time series for drinking water withdrawals in surface water bodies in the Ardennes department
getTimeSeriesDep("08", code_usage = "AEP", code_type_eau = "CONT")
#>       volume  annee  peuplement
#>  [1,] NULL    "2008" "2"       
#>  [2,] NULL    "2009" "2"       
#>  [3,] NULL    "2010" "2"       
#>  [4,] NULL    "2011" "2"       
#>  [5,] 506356  "2012" "1"       
#>  [6,] 479622  "2013" "1"       
#>  [7,] 599626  "2014" "1"       
#>  [8,] 631363  "2015" "1"       
#>  [9,] 581305  "2016" "1"       
#> [10,] 1134831 "2017" "1"       
#> [11,] 504790  "2018" "1"       
#> [12,] 380556  "2019" "3"

# Withdrawal time series for the commune of Charleville-Mézières
getTimeSeriesCom("08105")
#>       volume annee  peuplement
#>  [1,] NULL   "2008" "2"       
#>  [2,] NULL   "2009" "2"       
#>  [3,] NULL   "2010" "2"       
#>  [4,] NULL   "2011" "2"       
#>  [5,] 55898  "2012" "1"       
#>  [6,] 15359  "2013" "1"       
#>  [7,] 79086  "2014" "1"       
#>  [8,] 100624 "2015" "1"       
#>  [9,] 16359  "2016" "1"       
#> [10,] 17162  "2017" "1"       
#> [11,] 67910  "2018" "1"       
#> [12,] 512130 "2019" "1"
```

### Communal data in one departement

For getting list of communes of departement with corresponding
withdrawal volumes for one year, use the function `getComSeriesDep` as
follow:

``` r
# All source and destination withdrawals for the year 2016 in the Ardennes departement
getComSeriesDep("08", 2016, code_usage = "AEP", code_type_eau = "CONT")
#>   insee_com volume
#> 1     08096  33024
#> 2     08135  13583
#> 3     08247 439424
#> 4     08420  95274
```
