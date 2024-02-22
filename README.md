
<!-- README.md is generated from README.Rmd. Please edit that file -->

# hubeau an R package for the Hub’Eau APIs

<img src="man/figures/logo.png" align="right" style="float: right; height: 220px; margin: 15px;"/>

<!-- badges: start -->

[![CRAN](https://www.r-pkg.org/badges/version-ago/hubeau)](https://cran.r-project.org/package=hubeau)
[![Total
downloads](https://cranlogs.r-pkg.org/badges/grand-total/hubeau)](https://cran.r-project.org/package=hubeau)
[![DOI:
10.57745/XKN6NC](https://img.shields.io/badge/doi-10.57745%2FXKN6NC-purple)](https://doi.org/10.57745/XKN6NC)
[![License:
MIT](https://img.shields.io/badge/license-MIT-orange.svg)](https://cran.r-project.org/web/licenses/MIT)
[![](https://img.shields.io/badge/lifecycle-stable-blue.svg)](https://lifecycle.r-lib.org/articles/stages.html#stable)

[![R-CMD-check](https://github.com/inrae/hubeau/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/inrae/hubeau/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

‘hubeau’ is an R-package proposing a collection of function to help
retrieve data from the French national databases on water:
<https://hubeau.eaufrance.fr>

# Installation

``` r
# Install released version from CRAN
install.packages("hubeau")

# Install development version from GitHub:
# install.packages("remotes")
remotes::install_github("inrae/hubeau")
```

# Loading library

``` r
library(hubeau)
```

# Get started

The ‘hubeau’ package provides functions for ‘Hub’Eau’ APIs and their
related endpoints. These functions are named as follow:
`hubeau::get_[API]_[endpoint]`.

Currently available APIs and related endpoints are listed below.

## API “Ecoulement des cours d’eau”

API documentation: <https://hubeau.eaufrance.fr/page/api-ecoulement>

Available functions:

- [`get_ecoulement_stations`](https://inrae.github.io/hubeau/reference/get_ecoulement.html):
  site data and locations
- [`get_ecoulement_observations`](https://inrae.github.io/hubeau/reference/get_ecoulement.html):
  flow observations collected during campaigns
- [`get_ecoulement_campagnes`](https://inrae.github.io/hubeau/reference/get_ecoulement.html):
  observation campaign information

## API “Hydrométrie”

API documentation: <https://hubeau.eaufrance.fr/page/api-hydrometrie>

Available functions:

- [`get_hydrometrie_sites`](https://inrae.github.io/hubeau/reference/get_hydrometrie.html):
  hydrometry sites (can contain several stations)
- [`get_hydrometrie_stations`](https://inrae.github.io/hubeau/reference/get_hydrometrie.html):
  hydrometry stations
- [`get_hydrometrie_observations_tr`](https://inrae.github.io/hubeau/reference/get_hydrometrie.html):
  hydrometry water level and discharge time series
- [`get_hydrometrie_obs_elab`](https://inrae.github.io/hubeau/reference/get_hydrometrie.html):
  hydrometric elaborate observations (daily/monthly mean flow)

## API “Indicateurs des services”

API documentation:
<https://hubeau.eaufrance.fr/page/api-indicateurs-services>

Available functions:

- [`get_indicateurs_services_communes`](https://inrae.github.io/hubeau/reference/get_indicateurs_services.html):
  performance indicators by commune
- [`get_indicateurs_services_indicateurs`](https://inrae.github.io/hubeau/reference/get_indicateurs_services.html):
  performance indicators by indicator
- [`get_indicateurs_services_services`](https://inrae.github.io/hubeau/reference/get_indicateurs_services.html):
  performance indicators by commune for each service

## API “Piézométrie”

API documentation: <https://hubeau.eaufrance.fr/page/api-piezometrie>

Available functions:

- [`get_niveaux_nappes_chroniques`](https://inrae.github.io/hubeau/reference/get_niveaux_nappes.html):
  archived time series of piezometric stations
- [`get_niveaux_nappes_chroniques_tr`](https://inrae.github.io/hubeau/reference/get_niveaux_nappes.html):
  real-time time series of piezometric stations
- [`get_niveaux_nappes_stations`](https://inrae.github.io/hubeau/reference/get_niveaux_nappes.html):
  piezometric stations

## API “Poisson”

API documentation: <https://hubeau.eaufrance.fr/page/api-poisson>

Available function:

- [`get_poisson_operations`](https://inrae.github.io/hubeau/reference/get_poisson.html):
  sampling operations carried out at stations measuring the quality of
  rivers
- [`get_poisson_observations`](https://inrae.github.io/hubeau/reference/get_poisson.html):
  fish observations made during sampling operations
- [`get_poisson_indicateurs`](https://inrae.github.io/hubeau/reference/get_poisson.html):
  the IPR and IPR+ indicators calculated from fish observations
- [`get_poisson_stations`](https://inrae.github.io/hubeau/reference/get_poisson.html):
  stations measuring the quality of rivers

## API “Prélèvements en eau”

API documentation:
<https://hubeau.eaufrance.fr/page/api-prelevements-eau>

Available functions:

- [`get_prelevements_chroniques`](https://inrae.github.io/hubeau/reference/get_prelevements.html):
  time series of annual withdrawn volumes by device
- [`get_prelevements_ouvrages`](https://inrae.github.io/hubeau/reference/get_prelevements.html):
  withdrawal devices (can contain several withdrawal points)
- [`get_prelevements_points_prelevement`](https://inrae.github.io/hubeau/reference/get_prelevements.html):
  withdrawal points

## API “Qualité de l’eau potable”

API documentation:
<https://hubeau.eaufrance.fr/page/api-qualite-eau-potable>

Available functions:

- [`get_qualite_eau_potable_communes_udi`](https://inrae.github.io/hubeau/reference/get_qualite_eau_potable.html):
  links between “UDI” (Distribution units or networks) and communes
- [`get_qualite_eau_potable_resultats_dis`](https://inrae.github.io/hubeau/reference/get_qualite_eau_potable.html):
  samples, analysis results and sanitary conclusions from the sanitary
  control of the distributed water commune by commune

## API “Qualité des cours d’eau”

API documentation:
<https://hubeau.eaufrance.fr/page/api-qualite-cours-deau>

Available functions:

- [`get_qualite_rivieres_station`](https://inrae.github.io/hubeau/reference/get_qualite_rivieres.html):
  stations (measuring points) on rivers or water bodies where water
  samples have been taken for water quality analyses
- [`get_qualite_rivieres_operation`](https://inrae.github.io/hubeau/reference/get_qualite_rivieres.html):
  sampling operations carried out at the stations
- [`get_qualite_rivieres_analyse`](https://inrae.github.io/hubeau/reference/get_qualite_rivieres.html):
  physico-chemical analyses carried out on samples prepared during
  sampling operations at the stations
- [`get_qualite_rivieres_condition_environnementale`](https://inrae.github.io/hubeau/reference/get_qualite_rivieres.html):
  environmental conditions (air temperature, presence of leaves, moss,
  iridescence, etc.) observed during physico-chemical sampling
  operations

## API “Qualité des nappes d’eau souterraines”

API documentation: <https://hubeau.eaufrance.fr/page/api-qualite-nappes>

Available functions:

- [`get_qualite_nappes_stations`](https://inrae.github.io/hubeau/reference/get_qualite_nappes.html):
  measuring stations for groundwater quality
- [`get_qualite_nappes_analyses`](https://inrae.github.io/hubeau/reference/get_qualite_nappes.html):
  analysis results of quality measurement

## API “Température des cours d’eau”

API Documentation
<https://hubeau.eaufrance.fr/page/api-temperature-continu>

Available functions:

- [`get_temperature_stations`](https://inrae.github.io/hubeau/reference/get_temperature.html):
  temperature stations in French rivers
- [`get_temperature_chronique`](https://inrae.github.io/hubeau/reference/get_temperature.html):
  river temperature time series

A complete documentation is available on the package website:
<https://inrae.github.io/hubeau/>

# Acknowledgements

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
