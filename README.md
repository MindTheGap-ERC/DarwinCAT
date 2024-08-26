# DarwinCAT

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.13375156.svg)](https://doi.org/10.5281/zenodo.13375156)

## Description

A web application to experiment and visualize how evolution is distorted by the geological record, focusing on carbonate platforms.

## Authors

**Niklas Hohmann** (Maintainer)\
Utrecht University\
email: n.h.hohmann [at] uu.nl\
Web page: [uu.nl/staff/NHohmann](https://www.uu.nl/staff/NHHohmann)\
ORCID: [0000-0003-1559-1838](https://orcid.org/0000-0003-1559-1838)

**Emilia Jarochowska**\
Utrecht University\
email: e.b.jarochowska [at] uu.nl\
Web page: [www.uu.nl/staff/EBJarochowska](https://www.uu.nl/staff/EBJarochowska)\
ORCID: [0000-0001-8937-9405](https://orcid.org/0000-0001-8937-9405)

**Peter Burgess**\
University of Liverpool\
Email: pmb42 [at] liverpool.ac.uk\
Web page: [liverpool.ac.uk/environmental-sciences/staff/peter-burgess](https://www.liverpool.ac.uk/environmental-sciences/staff/peter-burgess/)

## License

Apache 2.0 License, see LICENSE file for license text.

## Online Usage

The app is available online at [stratigraphicpaleobiology.shinyapps.io/DarwinCAT](https://stratigraphicpaleobiology.shinyapps.io/DarwinCAT/)\
Online access works with a web browser and does not require any coding skills or installations.

## Offline Usage

Running the app offline requires R version 3.3 or later, RStudio, and the R packages "renv", "shiny" and "png".

1.  Open the R project: Go to *File -\> Open Project*, then navigate to the DarwinCAT folder and open the DarwinCAT Rproject file (file ending *.Rproj*). This will bootstrap the *renv* package.

2.  Run

    ``` r
    renv::restore()
    ```

    This will install all packages dependencies required to run the app.

3.  Now you can start the app by running the command

    ``` r
    shiny::runApp()
    ```

## Repository structure

-   *LICENSE.md* : Apache 2.0 license text
-   *README.md* : Readme file
-   *app.R* : Main app
-   *renv.lock* : lock file from R package renv
-   *CITATION.cff* : Citation format file
-   *.zenodo.json* : Metadata for zenodo
-   *DarwinCAT.Rproj* : Rproject file
-   *.Rprofile* : Rprofile file generated by renv
-   *.gitignore* : Untracked files
-   *data* : Folder for data
    -   *age_depth_models_for_shiny_app.Rdata* : R workspace containing the age depth models generated by CarboCAT in Matlab
-   *renv* : Folder used by the R package renv
-   *src* : Folder for functions called by the app
    -   *getAgeDepthModel.R* : returns age depth models based on user input
    -   *getEvolutionarySimulations.R* : makes evolutionary simulation based on user inputs
    -   *global_variables.R* : loads data & global variables into workspace
    -   *makeBasinTransectPlot.R* : plot basin transect generated by CarboCAT
    -   *makeWheelerDiagram.R* : plot Wheeler diagram generated by CarboCAT
    -   *makeTimeDomainPlot.R* : plot trait simulations in time
    -   *makeAgeDepthModelPlot.R* : plots age depth models
    -   *makeStratDomainPlot.R* : plot evolutionary simulations in stratigraphic domain
    -   *transform_ts.R* : transfroms time series from time to depth domain
    -   *prepare_download_trait_evo.R* : prepares download of trait evol. data
    -   *prepare_download_strat_pal.R* : prepares download of strat pal data
    -   *prepare_download_upload_data.R* : prepares download in upload data tab
    -   *process_upload_data.R* : preprocesses data uploaded by users
-   *www* : Folder with pictures used in the app

## Citation

To cite the app, please use

-   Hohmann, N., Jarochowska, E., & Burgess, P. (2024). DarwinCAT (v1.2.1). Zenodo. https://doi.org/10.5281/zenodo.13375156

If you use or cite the app, please also cite CarboCAT:

-   Burgess, P.M., 2013, CarboCAT: A cellular automata model of heterogeneous carbonate strata: Computers & Geosciences, v. 53, p. 129--140, doi: [10.1016/j.cageo.2011.08.026](https://www.sciencedirect.com/science/article/pii/S0098300411002949).

## References

This app uses data from

-   Hohmann, Niklas, Koelewijn, Joël R.; Burgess, Peter; Jarochowska, Emilia. 2023. "Identification of the Mode of Evolution in Incomplete Carbonate Successions - Supporting Data." Open Science Framework. <https://doi.org/10.17605/OSF.IO/ZBPWA>, published under the [CC-BY 4.0](https://creativecommons.org/licenses/by/4.0/) license, supplement to: Hohmann, Niklas; Koelewijn, Joël R.; Burgess, Peter; Jarochowska, Emilia. 2024. "Identification of the mode of evolution in incomplete carbonate successions." BMC Ecology and Evolution, **24**, 113. [DOI: 10.1186/s12862-024-02287-2](https://doi.org/10.1186/s12862-024-02287-2).

This data was generated using [CarboCAT](https://github.com/csdms-contrib/carbocat), a forward model of carbonate sedimentation developed by [Peter Burgess](https://www.liverpool.ac.uk/environmental-sciences/staff/peter-burgess/).

## Funding information

Online access to the App is made possible by the IDUB programme of the University of Warsaw (Grant BOB-IDUB-622-18/2022).\
Co-funded by the European Union (ERC, MindTheGap, StG project no 101041077). Views and opinions expressed are however those of the author(s) only and do not necessarily reflect those of the European Union or the European Research Council. Neither the European Union nor the granting authority can be held responsible for them. ![European Union and European Research Council logos](https://erc.europa.eu/sites/default/files/2023-06/LOGO_ERC-FLAG_FP.png)
