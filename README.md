
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

# Installation

You can install the ‘hubeau’ R-package from it’s development repository
with:

``` r
install.packages("remotes")
remotes::install_github("inrae/hubeau")
```

# Loading library

``` r
library(hubeau)
```

# Get started

The ‘hubeau’ package provides functions for “Hub’eau” APIs and their
related endpoints. These functions are named as follow:
`hubeau::get_[API]_[endpoint]`.

Currently available APIs and related endpoints are listed below.

## API “Hydrométrie”

API documentation:

Available functions:

-   [`get_hydrometrie_sites`](https://inrae.github.io/hubeau/reference/get_hydrometrie.html):
    hydrometry sites (can contain several stations)
-   [`get_hydrometrie_stations`](https://inrae.github.io/hubeau/reference/get_hydrometrie.html):
    hydrometry stations
-   [`get_hydrometrie_observations_tr`](https://inrae.github.io/hubeau/reference/get_hydrometrie.html):
    hydrometry water level and discharge time series
-   [`get_hydrometrie_obs_elab`](https://inrae.github.io/hubeau/reference/get_hydrometrie.html):
    hydrometric elaborate observations (daily/monthly mean flow)

## API “Indicateurs des services”

API documentation:

Available functions:

-   [`get_indicateurs_services_communes`](https://inrae.github.io/hubeau/reference/get_indicateurs_services.html):
    performance indicators by commune
-   [`get_indicateurs_services_indicateurs`](https://inrae.github.io/hubeau/reference/get_indicateurs_services.html):
    performance indicators by indicator
-   [`get_indicateurs_services_services`](https://inrae.github.io/hubeau/reference/get_indicateurs_services.html):
    performance indicators by commune for each service

## API “Piézométrie”

API documentation:

Available functions:

-   [`get_niveaux_nappes_chroniques`](https://inrae.github.io/hubeau/reference/get_niveaux_nappes.html):
    archived time series of piezometric stations
-   [`get_niveaux_nappes_chroniques_tr`](https://inrae.github.io/hubeau/reference/get_niveaux_nappes.html):
    real-time time series of piezometric stations
-   [`get_niveaux_nappes_stations`](https://inrae.github.io/hubeau/reference/get_niveaux_nappes.html):
    piezometric stations

## API “Prélèvements en eau”

API documentation:

Available functions:

-   [`get_prelevements_chroniques`](https://inrae.github.io/hubeau/reference/get_prelevements.html):
    time series of annual withdrawn volumes by device
-   [`get_prelevements_ouvrages`](https://inrae.github.io/hubeau/reference/get_prelevements.html):
    withdrawal devices (can contain several withdrawal points)
-   [`get_prelevements_points_prelevement`](https://inrae.github.io/hubeau/reference/get_prelevements.html):
    withdrawal points

# Acknowledgement

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
