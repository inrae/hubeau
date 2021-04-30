#' @param code_usage a [character()] representing the withdrawal destination which can take the following values:
#'        - "ENE" for energy
#'        - "CAN" for artificial canals
#'        - "BAR" for turbined water (dam)
#'        - "AEP" for drinking water
#'        - "IND" for industry
#'        - "IRR" for irrigation
#' @param code_type_eau a [character()] representing the withdrawal source which can take the following values:
#'        - "CONT" for continental surface
#'        - "SOUT" for subsurface
#'        - "LIT" for littoral
#' @param cookie a named [character] [vector] with the values of the cookies (See [getCookie])
#' @inheritParams getCookie
