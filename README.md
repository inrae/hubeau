
<!-- README.md is generated from README.Rmd. Please edit that file -->

# bnpe

<!-- badges: start -->

[![License:
MIT](https://img.shields.io/badge/license-MIT-orange.svg)](https://cran.r-project.org/web/licenses/MIT)
[![](https://img.shields.io/badge/lifecycle-experimental-blue.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

‘bnpe’ is an R-package proposing a collection of function to help
retrieve the French national data bank of quantitative withdrawals
(Banque Nationale des Prélèvements quantitatifs en Eau - BNPE) available
on its website <https://bnpe.eaufrance.fr> and on
<https://hubeau.eaufrance.fr/page/api-prelevements-eau>

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

### Loading data from the Hub’Eau API

Two functions are available:

-   `get_points_prelevement`: retrieve data about abstraction points
-   `get_chronique`: retrieve annual volume time series and
    characteristics

The available filters for these functions are detailed in the API
documentation respectively:
<https://hubeau.eaufrance.fr/page/api-prelevements-eau#/prelevements/prelevement>
and
<https://hubeau.eaufrance.fr/page/api-prelevements-eau#/prelevements/chronique>

Examples:

``` r
# Characteristics of surface abstraction points in the Ardennes departement
pp08 <- get_points_prelevement(list(code_departement = "08", code_type_milieu = "CONT"))
str(pp08)
#> tibble [85 x 28] (S3: tbl_df/tbl/data.frame)
#>  $ code_point_prelevement     : chr [1:85] "PTP000000000005792" "PTP000000000005793" "PTP000000000005794" "PTP000000000005795" ...
#>  $ nom_point_prelevement      : chr [1:85] "SARL WIEDENMANN" "ENERPRO BOGNY" "FORCES ENERGIES ELECTRIQUES" "STE EXPL CHUTES HYDRAULIQUES" ...
#>  $ date_exploitation_debut    : chr [1:85] "1900-01-01" "1900-01-01" "1900-01-01" "1900-01-01" ...
#>  $ date_exploitation_fin      : logi [1:85] NA NA NA NA NA NA ...
#>  $ code_type_milieu           : chr [1:85] "CONT" "CONT" "CONT" "CONT" ...
#>  $ libelle_type_milieu        : chr [1:85] "Surface continental" "Surface continental" "Surface continental" "Surface continental" ...
#>  $ code_nature                : chr [1:85] "F" "F" "F" "F" ...
#>  $ libelle_nature             : chr [1:85] "FICTIF" "FICTIF" "FICTIF" "FICTIF" ...
#>  $ lieu_dit                   : logi [1:85] NA NA NA NA NA NA ...
#>  $ commentaire                : logi [1:85] NA NA NA NA NA NA ...
#>  $ code_commune_insee         : chr [1:85] "08083" "08081" "08185" "08302" ...
#>  $ nom_commune                : chr [1:85] "Brévilly" "Bogny-sur-Meuse" "Fumay" "Monthermé" ...
#>  $ code_departement           : chr [1:85] "08" "08" "08" "08" ...
#>  $ libelle_departement        : chr [1:85] "Ardennes" "Ardennes" "Ardennes" "Ardennes" ...
#>  $ code_entite_hydro_cours_eau: logi [1:85] NA NA NA NA NA NA ...
#>  $ uri_entite_hydro_cours_eau : logi [1:85] NA NA NA NA NA NA ...
#>  $ code_entite_hydro_plan_eau : logi [1:85] NA NA NA NA NA NA ...
#>  $ uri_entite_hydro_plan_eau  : logi [1:85] NA NA NA NA NA NA ...
#>  $ code_zone_hydro            : chr [1:85] NA NA NA NA ...
#>  $ uri_zone_hydro             : chr [1:85] NA NA NA NA ...
#>  $ code_mer_ocean             : logi [1:85] NA NA NA NA NA NA ...
#>  $ nappe_accompagnement       : logi [1:85] TRUE TRUE TRUE TRUE TRUE TRUE ...
#>  $ uri_bss_point_eau          : logi [1:85] NA NA NA NA NA NA ...
#>  $ code_ouvrage               : chr [1:85] "OPR0000005780" "OPR0000005781" "OPR0000005782" "OPR0000005783" ...
#>  $ uri_ouvrage                : chr [1:85] "https://id.eaufrance.fr/OuvragePrel/OPR0000005780" "https://id.eaufrance.fr/OuvragePrel/OPR0000005781" "https://id.eaufrance.fr/OuvragePrel/OPR0000005782" "https://id.eaufrance.fr/OuvragePrel/OPR0000005783" ...
#>  $ code_bdlisa                : logi [1:85] NA NA NA NA NA NA ...
#>  $ uri_bdlisa                 : logi [1:85] NA NA NA NA NA NA ...
#>  $ code_bss_point_eau         : logi [1:85] NA NA NA NA NA NA ...

# Time series of annual abstracted volumes for drinking water supply from surface water in the Ardennes departement
# As the parameter "source of the water" (ground, surface...) is not available here, we can use the list of abstraction points previously downloaded as filter:
dfAEP <- get_chronique(list(code_ouvrage = paste(pp08$code_ouvrage, collapse = ","), 
                            code_usage = "AEP"))
str(dfAEP)
#> tibble [40 x 23] (S3: tbl_df/tbl/data.frame)
#>  $ code_ouvrage                 : chr [1:40] "OPR0000000767" "OPR0000000767" "OPR0000000767" "OPR0000000767" ...
#>  $ annee                        : int [1:40] 2012 2013 2014 2015 2016 2017 2018 2012 2013 2014 ...
#>  $ volume                       : num [1:40] 189938 175878 167035 169552 169694 ...
#>  $ code_usage                   : chr [1:40] "AEP" "AEP" "AEP" "AEP" ...
#>  $ libelle_usage                : chr [1:40] "EAU POTABLE" "EAU POTABLE" "EAU POTABLE" "EAU POTABLE" ...
#>  $ code_statut_volume           : chr [1:40] "1" "1" "1" "1" ...
#>  $ libelle_statut_volume        : chr [1:40] "Contrôlé Niveau 1" "Contrôlé Niveau 1" "Contrôlé Niveau 1" "Contrôlé Niveau 1" ...
#>  $ code_qualification_volume    : chr [1:40] "1" "1" "1" "1" ...
#>  $ libelle_qualification_volume : chr [1:40] "Correcte" "Correcte" "Correcte" "Correcte" ...
#>  $ code_statut_instruction      : chr [1:40] "REA" "REA" "REA" "REA" ...
#>  $ libelle_statut_instruction   : chr [1:40] "Prélèvement réalisé" "Prélèvement réalisé" "Prélèvement réalisé" "Prélèvement réalisé" ...
#>  $ code_mode_obtention_volume   : chr [1:40] "MED" "MED" "MED" "MED" ...
#>  $ libelle_mode_obtention_volume: chr [1:40] "Mesure directe" "Mesure directe" "Mesure directe" "Mesure directe" ...
#>  $ prelevement_ecrasant         : logi [1:40] FALSE FALSE FALSE FALSE FALSE FALSE ...
#>  $ producteur_donnee            : chr [1:40] "AERM" "AERM" "AERM" "AERM" ...
#>  $ longitude                    : num [1:40] 4.83 4.83 4.83 4.83 4.83 ...
#>  $ latitude                     : num [1:40] 50.1 50.1 50.1 50.1 50.1 ...
#>  $ code_commune_insee           : chr [1:40] "08247" "08247" "08247" "08247" ...
#>  $ nom_commune                  : chr [1:40] "Landrichamps" "Landrichamps" "Landrichamps" "Landrichamps" ...
#>  $ code_departement             : chr [1:40] "08" "08" "08" "08" ...
#>  $ libelle_departement          : chr [1:40] "Ardennes" "Ardennes" "Ardennes" "Ardennes" ...
#>  $ nom_ouvrage                  : chr [1:40] "COMMUNE DE GIVET" "COMMUNE DE GIVET" "COMMUNE DE GIVET" "COMMUNE DE GIVET" ...
#>  $ uri_ouvrage                  : chr [1:40] "https://id.eaufrance.fr/OuvragePrel/OPR0000000767" "https://id.eaufrance.fr/OuvragePrel/OPR0000000767" "https://id.eaufrance.fr/OuvragePrel/OPR0000000767" "https://id.eaufrance.fr/OuvragePrel/OPR0000000767" ...
```

### Scrapping aggregated data from the BNPE website

Functions for getting time series are:

-   `getTimeSeriesDep`: for one department
-   `getTimeSeriesCom`: for one commune

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

### Properties and time series from one device (“ouvrage”)

For getting metadata and withdrawal yearly time series from on device
identified by its “code Sandre” (See
<https://www.sandre.eaufrance.fr/atlas/srv/fre/catalog.search#/metadata/e315633f-0930-41e8-a1c4-61fb2303039c>):

``` r
# metadata and timeseries from withdrawal "COPRIMANCHE-forage LD LE PACO (40m)" 
ouvrage <- getOuvrageSeries("OPR0000200109")
str(ouvrage)
#> List of 12
#>  $ id               : int 200108
#>  $ code             : chr "OPR0000200109"
#>  $ codeCommune      : chr "50151"
#>  $ codePrecision    : int 1
#>  $ codeStatut       : chr "Validé"
#>  $ codeTypeEau      : chr "SOUT"
#>  $ codeUsage        : chr "4"
#>  $ commentaire      : chr ""
#>  $ exploitationDebut: Date[1:1], format: "1987-01-01"
#>  $ geom             :List of 2
#>   ..$ type       : chr "Point"
#>   ..$ coordinates:List of 2
#>   .. ..$ : num -1.58
#>   .. ..$ : num 49.2
#>  $ ouvNom           : chr "COPRIMANCHE-forage LD LE PACO (40m)"
#>  $ TS               :'data.frame':   6 obs. of  3 variables:
#>   ..$ annee     : chr [1:6] "2013" "2014" "2015" "2016" ...
#>   ..$ volume    : int [1:6] 101970 84430 85220 87820 106219 118124
#>   ..$ peuplement: chr [1:6] "1" "1" "1" "1" ...
```
