The 'hubeau' package provides functions for 'Hub'Eau' APIs and their related endpoints.
These functions are named as follow: `hubeau::get_[API]_[endpoint]`.

Currently available APIs and related endpoints are listed below.

## API "Ecoulement des cours d'eau"

API documentation: <https://hubeau.eaufrance.fr/page/api-ecoulement>

Available functions:

- [get_ecoulement_stations()]: site data and locations
- [get_ecoulement_observations()]: flow observations collected during campaigns
- [get_ecoulement_campagnes()]: observation campaign information

## API "Hydrométrie"

API documentation: <https://hubeau.eaufrance.fr/page/api-hydrometrie>

Available functions:

- [get_hydrometrie_sites()]: hydrometry sites (can contain several stations)
- [get_hydrometrie_stations()]: hydrometry stations
- [get_hydrometrie_observations_tr()]: hydrometry water level and discharge time series
- [get_hydrometrie_obs_elab()]: hydrometric elaborate observations (daily/monthly mean flow)

## API "Indicateurs des services"

API documentation: <https://hubeau.eaufrance.fr/page/api-indicateurs-services>

Available functions:

- [get_indicateurs_services_communes()]: performance indicators by commune
- [get_indicateurs_services_indicateurs()]: performance indicators by indicator
- [get_indicateurs_services_services()]: performance indicators by commune for each service

## API "Piézométrie"

API documentation: <https://hubeau.eaufrance.fr/page/api-piezometrie>

Available functions:

- [get_niveaux_nappes_chroniques()]: archived time series of piezometric stations
- [get_niveaux_nappes_chroniques_tr()]: real-time time series of piezometric stations
- [get_niveaux_nappes_stations()]: piezometric stations

## API "Poisson"

API documentation: <https://hubeau.eaufrance.fr/page/api-poisson>

Available function:

- [get_poisson_observations()]: scientific fishery observations

## API "Prélèvements en eau"

API documentation: <https://hubeau.eaufrance.fr/page/api-prelevements-eau>

Available functions:

- [get_prelevements_chroniques()]: time series of annual withdrawn volumes by device
- [get_prelevements_ouvrages()]: withdrawal devices (can contain several withdrawal points)
- [get_prelevements_points_prelevement()]: withdrawal points
