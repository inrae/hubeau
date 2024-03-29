% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_indicateurs_services.R
\name{get_indicateurs_services_communes}
\alias{get_indicateurs_services_communes}
\alias{get_indicateurs_services_indicateurs}
\alias{get_indicateurs_services_services}
\title{Retrieve data from API "Indicateurs des services"}
\usage{
get_indicateurs_services_communes(...)

get_indicateurs_services_indicateurs(...)

get_indicateurs_services_services(...)
}
\arguments{
\item{...}{parameters of the queries and their values in the format
\verb{Param1_Name = "Param1 value", Param2_Name = "Param2 value"}, use the
function \link{list_params} for a list of the available filter parameters
for a given API endpoint and see the API documentation for their description}
}
\value{
\code{get_indicateurs_services_communes} returns a \link[tibble:tibble]{tibble::tibble} with one row by commune, by service and by year and the following columns:
\itemize{
\item "code_commune_insee": \link{character} identifier of the commune
\item "nom_commune": \link{character} name of the commune
\item "codes_service": \link{integer} identifier of the drinking water supply and/or sanitation service
\item "annee": \link{integer} year of the data
\item The following columns are the performance indicators flagged by their respective codes. The documentation of these codes can be found at this URL: \url{https://www.services.eaufrance.fr/indicateurs/indicateurs}.
}

\code{get_indicateurs_services_indicateurs} returns a \link[tibble:tibble]{tibble::tibble} with one row by service and by year and the following columns:
\itemize{
\item "code_service": \link{character} identifier of the service
\item "nom_service": \link{character} name of the service
\item "numero_siren ": \link{character} SIREN identifier of the service
\item "type_collectivite": \link{character} kind of community
\item "mode_gestion": \link{character} management mechanism of the service
\item "annee": \link{integer} year of the data
\item "indicateur": value of the indicator
\item "uri_indicateur": the link to the indicator documentation
}

\code{get_indicateurs_services_services} returns a \link[tibble:tibble]{tibble::tibble} with one row by commune, by service and by year and the following columns:
\itemize{
\item "code_service": \link{character} identifier of the service
\item "nom_service": \link{character} name of the service
\item "code_commune_insee": \link{character} identifier of the commune
\item "nom_commune": \link{character} name of the commune
\item "numero_siren ": \link{character} SIREN identifier of the service
\item "type_collectivite": \link{character} kind of community
\item "mode_gestion": \link{character} management mechanism of the service
\item "annee": \link{integer} year of the data
\item The following columns are the performance indicators flagged by their respective codes. The documentation of these codes can be found at this URL: \url{https://www.services.eaufrance.fr/indicateurs/indicateurs}.
}
}
\description{
Retrieve performance indicators collected in drinking water and sanitation services in France.

See \link{list_params} and the API documentation for available filter parameters: \url{https://hubeau.eaufrance.fr/page/api-indicateurs-services}
}
\examples{
\dontrun{
# Retrieve performance indicator time series in the commune of Romilly-sur-Seine
get_indicateurs_services_communes(code_commune = "10323")

# Retrieve the drinking water withdrawal indicators of the year 2012 for all services
get_indicateurs_services_indicateurs(code_indicateur = "D102.0", annee = "2012")

# Retrieve performance indicator time series of Romilly-sur-Seine with service details
get_indicateurs_services_services(code_commune = "10323")
}
}
