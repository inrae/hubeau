
<!-- README.md is generated from README.Rmd. Please edit that file -->

# hubeau an R package for the Hub’eau APIs

<img src="man/figures/logo.svg" align="right" height="120px"/>

<!-- badges: start -->

[![License:
MIT](https://img.shields.io/badge/license-MIT-orange.svg)](https://cran.r-project.org/web/licenses/MIT)
[![](https://img.shields.io/badge/lifecycle-experimental-blue.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

‘hubeau’ is an R-package proposing a collection of function to help
retrieve data from the French national databases on water:
<https://hubeau.eaufrance.fr>

## Installation

You can install the ‘hubeau’ R-package from it’s development repository
with:

``` r
install.packages("remotes")
remotes::install_github("inrae/hubeau")
```

## Loading library

``` r
library(hubeau)
```

## Get started

See the package documentation by typing:

``` r
?hubeau
```

Each function is documented with at least one example:

``` r
example("get_prelevements_chroniques")
#>
#> gt_pr_> # For retrieving the withdrawal time series of the devices located in Romilly-sur-Seine
#> gt_pr_> get_prelevements_chroniques(list(code_commune_insee = "10323"))
#> # A tibble: 36 x 23
#>    code_ouvrage  annee volume code_usage libelle_usage code_statut_volume
#>    <chr>         <int>  <dbl> <chr>      <chr>         <chr>
#>  1 OPR0000032603  2012 617624 AEP        EAU POTABLE   1
#>  2 OPR0000032603  2013 463545 AEP        EAU POTABLE   1
#>  3 OPR0000032603  2014 535557 AEP        EAU POTABLE   1
#>  4 OPR0000032603  2015 541785 AEP        EAU POTABLE   1
#>  5 OPR0000032603  2016 478938 AEP        EAU POTABLE   1
#>  6 OPR0000032603  2017 402363 AEP        EAU POTABLE   1
#>  7 OPR0000032603  2018 402383 AEP        EAU POTABLE   1
#>  8 OPR0000032604  2012 617624 AEP        EAU POTABLE   1
#>  9 OPR0000032604  2013 463545 AEP        EAU POTABLE   1
#> 10 OPR0000032604  2014 535557 AEP        EAU POTABLE   1
#> # ... with 26 more rows, and 17 more variables: libelle_statut_volume <chr>,
#> #   code_qualification_volume <chr>, libelle_qualification_volume <chr>,
#> #   code_statut_instruction <chr>, libelle_statut_instruction <chr>,
#> #   code_mode_obtention_volume <chr>, libelle_mode_obtention_volume <chr>,
#> #   prelevement_ecrasant <lgl>, producteur_donnee <chr>, longitude <dbl>,
#> #   latitude <dbl>, code_commune_insee <chr>, nom_commune <chr>,
#> #   code_departement <chr>, libelle_departement <chr>, nom_ouvrage <chr>,
#> #   uri_ouvrage <chr>
```

## Acknowledgement

The authors would like to thank the European Commission and the French
National Research Agency (ANR) for funding in the frame of the
collaborative international consortium
[IN-WOP](http://www.waterjpi.eu/joint-calls/joint-call-2018-waterworks-2017/booklet/in-wop)
financed under the 2018 Joint call of the WaterWorks2017 ERA-NET Cofund.
This ERA-NET is an integral part of the activities developed by the
Water JPI.

<div style="display: flex; justify-content: space-between;">

![Water JPI](man/figures/logo_water_jpi.png) ![Water Works
2017](man/figures/logo_water_works_2017.png) ![European
Commission](man/figures/logo_european_commission.jpg) ![2018 Joint
call](man/figures/logo_2018_joint_call.png)

</div>
