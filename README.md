# DarwinCAT

## Description

App to visualize the effect of carbonate stratigraphy on trait evolution

## Authors

__Niklas Hohmann__ (Maintainer)  
Utrecht University  
Email: n.hohmann@uu.nl  
Web page: [uu.nl/staff/NHohmann](uu.nl/staff/NHohmann)  
Orcid: [0000-0003-1559-1838](https://orcid.org/0000-0003-1559-1838)

__Emilia Jarochowska__  
Utrecht University  
Email: e.b.jarochowska [at] uu.nl  
Web page: [uu.nl/staff/EBJarochowska](https://www.uu.nl/staff/EBJarochowska)  
Orcid: [0000-0001-8937-9405](https://orcid.org/0000-0001-8937-9405)

__Peter Burgess__  
University of Liverpool  
Email: pmb42 [at] liverpool.ac.uk  
Web page: [liverpool.ac.uk/environmental-sciences/staff/peter-burgess](https://www.liverpool.ac.uk/environmental-sciences/staff/peter-burgess/)

## License

Apache 2.0 License, see LICENSE file for license text.

## Online Usage

The app is available online at [stratigraphicpaleobiology.shinyapps.io/DarwinCAT](https://stratigraphicpaleobiology.shinyapps.io/DarwinCAT/)  
Online access works with a web browser and does not require any coding skills or installations.

## Offline Usage

Running the app offline requires R version 3.0.2 or later, RStudio, and the R packages "renv", "shiny" and "png"

1. Install the _renv_ package by running the following code in RStudio:

    ``` R
    if (!require("renv", quietly = TRUE)) install.packages("renv")
    ```

2. Open the R project: Go to _File -> Open Project_, then navigate to the DarwinCAT folder and open the DarwinCAT Rproject file (file ending _.Rproj_)
3. Run

    ``` R
    renv::restore()
    ```

    This will install all packages dependencies required to run the app.
4. Now you can start the app by running the command

    ``` R
    shiny::runApp()
    ```

## Further Work

Next steps in development of the App are (in no specific order):

1. Add option to download data (time series & stratigraphic time series)
2. Add option to upload user time series
3. Branch off _ProxyCAT_, an app that focuses on preservation of proxy records
4. Publish lesson plans for different skill/knowledge levels

## Repository structure

- _LICENSE.md_ : Apache 2.0 license text
- _README.md_ : Readme file
- _app.R_ : Main app
- _renv.lock_ : lock file from R package renv
- _CITATION.cff_ : Citation format file
- _.zenodo.json_ : Metadata for zenodo
- _DarwinCAT.Rproj_ : Rproject file
- _.Rprofile_ : Rprofile file generated by renv
- _.gitignore_ : Untracked files
- _data_ : Folder for data
  - _age_depth_models_for_shiny_app.Rdata_ : R workspace containing the age depth models generated by CarboCAT in Matlab
- _renv_ : Folder used by the R package renv
- _src_ : Folder for functions called by the app
  - _getAgeDepthModel.R_ : returns age depth models based on user input
  - _getEvolutionarySimulations.R_ : makes evolutionary simulation based on user inputs
  - _global_variables.R_ : loads data & global variables into workspace
  - _makeBasinTransectPlot.R_ : plot basin transect generated by CarboCAT
  - _makeWheelerDiagram.R_ : plot Wheeler diagram generated by CarboCAT
  - _makeTimeDomainPlot.R_ : plot trait simulations in time
  - _makeAgeDepthModelPlot.R_ : plots age depth models
  - _makeStratDomainPlot.R_ : plot evolutionary simulations in stratigraphic domain
- _www_ : Folder with pictures used in the app

## Citation

To cite the app, please use

- Hohmann, Niklas, Jarochowska, Emilia, & Burgess, Peter. (2023). DarwinCAT (1.0.0). Zenodo. [DOI: 10.5281/zenodo.7851988](https://doi.org/10.5281/zenodo.7851988)

The app uses datasets generated by [CarboCAT](https://github.com/csdms-contrib/carbocat), a forward model of carbonate sedimentation developed by [Peter Burgess](https://www.liverpool.ac.uk/environmental-sciences/staff/peter-burgess/). If you use or cite the app, please cite CarboCAT:

- Burgess, P.M., 2013, CarboCAT: A cellular automata model of heterogeneous carbonate strata: Computers & Geosciences, v. 53, p. 129–140, doi: [10.1016/j.cageo.2011.08.026](https://www.sciencedirect.com/science/article/pii/S0098300411002949).

## Funding

Online access to the App is made possible by the IDUB programme of the University of Warsaw (Grant BOB-IDUB-622-18/2022).  
Co-funded by the European Union (ERC, MindTheGap, StG project no 101041077). Views and opinions expressed are however those of the author(s) only and do not necessarily reflect those of the European Union or the European Research Council. Neither the European Union nor the granting authority can be held responsible for them.  
<img src="www/logos/mind_the_gap_logo.png"
     width="200"
     alt="Mind the Gap logo">
