# hubeau 0.4.1

New features
------------

* update API "ecoulement" from version beta to v1 (#33, contributor @OFB-IdF)

# hubeau 0.4.0

New features
------------

* Add API "Hydrobiologie" (#7, #18, 28)
* Add API "Température des cours d'eau" (#8)
* Add API "Qualité des nappes d'eau souterraine" (#10)
* Add API "Qualité de l'eau potable" (#5)
* Add vignettes with example of use of APIs (#21)

Bug fixes
---------

* Crash when dplyr is not installed (#16)

Internal changes
----------------

* Use swagger and openapi files to automatically check query fields (#14)

# hubeau 0.3.1

New features
------------

* Add customizable user agent (#12)
* Add "poisson" and "ecoulement" APIS (#2)
* Aggregate documentation by API ([gitlab#16](https://gitlab.irstea.fr/in-wop/hubeau/-/issues/16))
* Add informations in DESCRIPTION file ([gitlab#12](https://gitlab.irstea.fr/in-wop/hubeau/-/issues/12))
* `get_hydrometrie_observations_tr` add an option for handling duplicate entries ([gitlab#10](https://gitlab.irstea.fr/in-wop/hubeau/-/issues/10))
* Deploy pkgdown website on github ([gitlab#9](https://gitlab.irstea.fr/in-wop/hubeau/-/issues/9))
* Add "Piézométrie" APIs ([gitlab#8](https://gitlab.irstea.fr/in-wop/hubeau/-/issues/8))
* Add hydrometrie APIs ([gitlab#7](https://gitlab.irstea.fr/in-wop/hubeau/-/issues/7))
* Add the API prelevements/ouvrage ([gitlab#6](https://gitlab.irstea.fr/in-wop/hubeau/-/issues/6))
* Manage global limitation to 20000 records for all API ([gitlab#5](https://gitlab.irstea.fr/in-wop/hubeau/-/issues/5))
* Add data retrieval of "Indicateurs des services d'eau et d'assainissement" ([gitlab#4](https://gitlab.irstea.fr/in-wop/hubeau/-/issues/4))
* Extends package functionalities to the Hub'Eau APIs ([gitlab#3](https://gitlab.irstea.fr/in-wop/hubeau/-/issues/3))
* BNPE: Use new API for harvesting data ([gitlab#2](https://gitlab.irstea.fr/in-wop/hubeau/-/issues/2))

Bug fixes
---------

* Crash in get_hydrometrie_observations_tr for empty response ([gitlab#13](https://gitlab.irstea.fr/in-wop/hubeau/-/issues/13))

Internal changes
----------------

* Save package configuration as a global package variable (#4)
* Migration of the repository from https://gitlab.irstea.fr to github
* CI: Mirroring gitlab repository to github at push ([gitlab#11](https://gitlab.irstea.fr/in-wop/hubeau/-/issues/11))
* pkgdown build site with Ubuntu on github ([gitlab#15](https://gitlab.irstea.fr/in-wop/hubeau/-/issues/15))

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
