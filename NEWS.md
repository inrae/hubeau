hubeau (development version)
============================

New features
------------
* Aggregate documentation by API (#16)
* Add informations in DESCRIPTION file (#12)
* `get_hydrometrie_observations_tr` add an option for handling duplicate entries (#10)
* Deploy pkgdown website on github (#9)
* Add "Piézométrie" APIs (#8)
* Add hydrometrie APIs (#7)
* Add the API prelevements/ouvrage (#6)
* Manage global limitation to 20000 records for all API (#5)
* Add data retrieval of "Indicateurs des services d'eau et d'assainissement" (#4)
* Extends package functionalities to the Hub'Eau APIs (#3)
* BNPE: Use new API for harvesting data (#2)

Bug fixes
---------

* Crash in get_hydrometrie_observations_tr for empty response (#13)

Internal changes
----------------

* CI: Mirroring gitlab repository to github at push (#11)
* pkgdown build site with Ubuntu on github (#15)

hubeau 0.2.0 (2021-06-24)
=========================
New features
------------

* BNPE: download metadata and annual withdrawal volumes at "ouvrage" scale (#1)

hubeau 0.1.0 (2021-04-30)
=========================
New features
------------

* BNPE: download annual withdrawal volumes at commune scale
