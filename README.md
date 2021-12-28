
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
#> gt_pr_> # Retrieve the withdrawal points located in Romilly-sur-Seine
#> gt_pr_> get_prelevements_points_prelevement(list(code_commune_insee = "10323"))
#> # A tibble: 9 x 28
#>   code_point_prelevement nom_point_prelevem~ date_exploitatio~ date_exploitatio~
#>   <chr>                  <chr>               <chr>             <lgl>            
#> 1 PTP000000000047369     <NA>                1987-01-01        NA               
#> 2 PTP000000000047370     <NA>                1987-01-01        NA               
#> 3 PTP000000000053334     SCEA FERME DES HAU~ 1992-01-01        NA               
#> 4 PTP000000000054886     <NA>                2018-03-16        NA               
#> 5 PTP000000000054887     <NA>                2006-09-28        NA               
#> 6 PTP000000000233572     <NA>                1987-01-01        NA               
#> 7 PTP000000000434018     <NA>                2016-06-24        NA               
#> 8 PTP000000000762434     <NA>                2012-12-31        NA               
#> 9 PTP000000000788799     <NA>                1900-01-01        NA               
#> # ... with 24 more variables: code_type_milieu <chr>,
#> #   libelle_type_milieu <chr>, code_nature <chr>, libelle_nature <chr>,
#> #   lieu_dit <lgl>, commentaire <lgl>, code_commune_insee <chr>,
#> #   nom_commune <chr>, code_departement <chr>, libelle_departement <chr>,
#> #   code_entite_hydro_cours_eau <lgl>, uri_entite_hydro_cours_eau <lgl>,
#> #   code_entite_hydro_plan_eau <lgl>, uri_entite_hydro_plan_eau <lgl>,
#> #   code_zone_hydro <chr>, uri_zone_hydro <chr>, code_mer_ocean <lgl>, ...
#> 
#> gt_pr_> # Retrieve the withdrawal devices located in Romilly-sur-Seine
#> gt_pr_> get_prelevements_ouvrages(list(code_commune_insee = "10323"))
#> # A tibble: 9 x 27
#>   code_ouvrage  nom_ouvrage   id_local_ouvrage date_exploitati~ date_exploitati~
#>   <chr>         <chr>         <chr>            <chr>            <lgl>           
#> 1 OPR0000032603 ROMILLY SUR ~ 02612X1004/PAEP~ 1987-01-01       NA              
#> 2 OPR0000032604 ROMILLY SUR ~ 02612X1011/FAEP~ 1987-01-01       NA              
#> 3 OPR0000038567 SCEA FERME D~ BSS95456G_018    1992-01-01       NA              
#> 4 OPR0000040119 S.N.C.F       BSS00593V_018    2018-03-16       NA              
#> 5 OPR0000040120 S.N.C.F       BSS00594W_018    2006-09-28       NA              
#> 6 OPR0000199638 SCEA FERME D~ BSS95455F_018    1987-01-01       NA              
#> 7 OPR0000333915 Soc des Carr~ 32055_017        2016-06-24       NA              
#> 8 OPR0000586224 SCEA DU MERI~ BSS95299L_018    2012-12-31       NA              
#> 9 OPR0000608675 CRBPE ROMILL~ 31132_018        1900-01-01       NA              
#> # ... with 22 more variables: code_precision_coord <chr>,
#> #   libelle_precision_coord <chr>, commentaire <lgl>, code_commune_insee <chr>,
#> #   nom_commune <chr>, code_departement <chr>, libelle_departement <chr>,
#> #   code_type_milieu <chr>, libelle_type_milieu <chr>,
#> #   code_entite_hydro_cours_eau <chr>, uri_entite_hydro_cours_eau <chr>,
#> #   code_entite_hydro_plan_eau <lgl>, uri_entite_hydro_plan_eau <lgl>,
#> #   code_mer_ocean <lgl>, ressource_cont_non_referencee <lgl>, ...
#> 
#> gt_pr_> # Retrieve the withdrawal time series of the devices located in Romilly-sur-Seine
#> gt_pr_> get_prelevements_chroniques(list(code_commune_insee = "10323"))
#> # A tibble: 41 x 23
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
#> # ... with 31 more rows, and 17 more variables: libelle_statut_volume <chr>,
#> #   code_qualification_volume <chr>, libelle_qualification_volume <chr>,
#> #   code_statut_instruction <chr>, libelle_statut_instruction <chr>,
#> #   code_mode_obtention_volume <chr>, libelle_mode_obtention_volume <chr>,
#> #   prelevement_ecrasant <lgl>, producteur_donnee <chr>, longitude <dbl>,
#> #   latitude <dbl>, code_commune_insee <chr>, nom_commune <chr>,
#> #   code_departement <chr>, libelle_departement <chr>, nom_ouvrage <chr>, ...
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
