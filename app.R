library(shiny)

# load data & global variables
source("src/global_variables.R")

# load functions into workspace
source("src/getAgeDepthModel.R") # determines age-depth models
source("src/getEvolutionarySimulations.R") # simulates trait evolution

# functions to make the plots
source("src/makeAgeDepthModelPlot.R")
source("src/makeTimeDomainPlot.R")
source("src/makeStratDomainPlot.R")
source("src/makeBasinTransectPlot.R")
source("src/makeWheelerDiagram.R")

# functions for data download / upload
source("src/prepare_download_trait_evo.R")
source("src/prepare_download_strat_pal.R")

source("src/transform_ts.R")

#### Iser interface ####
ui <- navbarPage(
  title = "DarwinCAT",
  id = "DarwinCAT_app",
  windowTitle = "DarwinCAT",
  #### Panel: Introduction ####
  tabPanel(
    title = "Introduction",
    div(
      style = "margin-left: 4em; margin-right: 4em",
      fluidRow(
        column(
          width = 8,
          HTML(
            '
        <h1>
        Preservation of Evolution in the Fossil Record
        </h1>
        <!-- The text below will go on the intro page-->
        <h4>
        Motivation
        </h4>
        <p>
        In the fossil record, we can observe gradual changes in lineages of
        organisms over timescales of thousands to millions of years.
        The changes can be in any aspect of the organism, even behaviour, but
        we will only be able to track those which fossilize
        (i.e. have a preservation potential).
        This usually refers to skeletal morphology, such as tooth size
        of a primate, the body weight of a squirrel (Gingerich, 1979)
        or the number of denticles of a conodont (Dzik, 1991).
        If we follow
        these gradual changes through a geological succession, we should
        be able - in theory - to catch evolution "red handed" and even
        spot moments of speciation and find out <b>how</b> it happens:
        do species gradually turn into other species (<i>anagenesis</i>) or do
        new species split out from the old ones (<i>branching speciation</i>)?
        </p>
        <h4>
        What Could Go Wrong?
        </h4>
        <p>
        If the geological record was a faithful record of the evolutionary time,
        this would be true.
        First, a geological section is only a small part of the space in which
        the organism lived.
        And most organisms do not occur in <i>everything everywhere all at
        once</i> (check if not bacteria or tardigrade).
        So if <a href="https://www.smithsonianmag.com/smart-news/yes-giant-technicolor-squirrels-actually-roam-forests-southern-india-180971886/" target="_blank">giant squirrels</a>
        appear in a section we study, it could be
        because their ancestors evolved towards larger body sizes or
        larger squirrels lived somewhere else and, owing to some
        deterministic or
        accidental factors, migrated into the part of squirrel habitat that happens to be preserved
        in our geological section that only represents a small fragment of the extent of that habitat
        in space ant time.
        Many morhological traits vary systematically
        with environmental gradients. For example, according to the Bergmann\'s rule,
        mamalian individuals and species living in colder areas tend to be
        larger than their counterparts in warmer climes.
        So a morphological change in a geological section could be an
        evolutionary change or an environmental change to which
        the organisms responded <a href="https://en.wikipedia.org/wiki/Phenotype" target="_blank">phenotypically</a>.
        </p>
        <h4>
        The Geological Record Is Incomplete
        </h4>
        <p>
        A geological section not only represents a small fragment of the space
        in which it was formed, but typically also a small part of
        time in which it was deposited.
        If omission (lack of deposition) or <a href="https://en.wikipedia.org/wiki/Erosion" target="_blank">erosion</a> took place,
        the corresponding time - with its fossils - will be missing.
        Instead of a gradual change in morphology, we might see a jump.
        Nonetheless, some palaeontologists proposed that exceptionally complete
        geological records record evolution faithfully.
        This approach is known under the name of <i>stratophenetics</i>.
        Very successful applications of stratophenetics exist e.g. to
        planktonic foraminifera (Aze et al., 2011).
        Yet, phylogenies typically do not use stratophenetic data, assuming
        that the geological record is too incomplete - or its structure is too
        complex to account for - and focus on
        morphological data (e.g. Smith, 2000),
        optionally aided by fossil calibrations.
        But what if we <i>knew</i> the structure of the geological record
        and where the gaps are? We could distinguish gradual
        evolution towards a certain
        morphology from a gradual change in the environment in
        which such morphology is manifested phenotypically.
        In this app, you can simulate the geological record by taking a
        model of a carbonate platform and examining
        how continuous evolution would be represented at any point in it.
        </p>
        <h4>
        How To Use This App
        </h4>
        <p>
        Use the taps at the top to navigate between the different sections of
        the app.
        The second and third tab provide an introduction to
        evolutionary biology and carbonate stratigraphy.
        The fourth tab, labeled "Stratigraphic Paleobiology"
        combines both to explore how trait evolution
        is preserved in the rock record.
        In each tab, you will find a brief explanation of key concepts
        and explanations on how to use the interactive elements in the tab.
        </p>'
          )
        ),
        column(
          width = 4,
          HTML(
            '
          <div style="margin-top: 4em">
          <figure>
          <img src="modes_of_speciation.jpg" alt="Modes of Speciation" align="left" width="100%">
          <figcaption>Fig. 1 - Modes of Speciation. Based on the FossilSim
          package for R (<a href="https://doi.org/10.1111/2041-210X.13170">Barido-Sottani et al. 2019</a>).
          </figcaption>
          </figure>
          </div>

          <div style="margin-top: 4em">
          <figure>
          <img src="geology/angular_unconformity.JPG" alt="angular unconformity" align="left" width="100%">
          <figcaption>Fig. 2 - Devonian/Permian angular unconformity: a gap of nearly 100 My. Zachełmie Quarry, Poland.</figcaption>
          </figure>
          </div>

          '
          )
        )
      ),
      fluidRow(
        HTML(
          '
            <div style="margin-left: 1em; margin-bottom: -0.5em;">
            <h4>Creators</h4>
            </div>
            '
        ),
        column(
          width = 4,
          HTML(
            "
              <h5><b> Niklas Hohmann</b> </h5>
              "
          ),
          fluidRow(
            column(
              width = 5,
              HTML(
                '
                  <img src="people/niklas_hohmann.jpg" alt="Picture of Niklas Hohmann" align="left" width="100%">

                  '
              )
            ),
            column(
              width = 7,
              HTML(
                '
                  <div style="margin-left: 0em">
                    PhD candidate<br/>
                    Utrecht University, The Netherlands (formerly University of Warsaw)<br/>
                    Email: N.Hohmann [at] uu.nl<br/>
                    Twitter: <a href="https://twitter.com/HohmannNiklas" target="_blank">@HohmannNiklas</a><br/>
                    Mastodon: <a href="https://ecoevo.social/@Niklas_Hohmann" target="_blank">@Niklas_Hohmann@ecoevo.social</a><br/>
                    <a href="https://scholar.google.com/citations?hl=de&user=2CB_ktEAAAAJ" target="_blank">Google Scholar profile</a><br/>
                    Profile on the <a rel="author" href="https://www.uu.nl/staff/NHohmann" target="_blank">university webpage</a><br/>
                    <a href="https://github.com/NiklasHohmann" target="_blank">GitHub page</a>
                  </div>

                  '
              ),
            )
          )
        ),
        column(
          width = 4,
          HTML(
            "
              <h5><b> Dr. Emilia Jarochowska</b> </h5>
              "
          ),
          fluidRow(
            column(
              width = 5,
              HTML(
                '
                  <img src="people/emilia_jarochowska.jpg" alt="Picture of Emilia Jarochowska" align="left" width="100%">

                  '
              )
            ),
            column(
              width = 7,
              HTML(
                '
                  <div style="margin-left: 0em">
                  Utrecht University, The Netherlands<br>
                  Email: e.b.jarochowska [at] uu.nl<br>
                  <a href="https://scholar.google.de/citations?user=Zrldp2MAAAAJ&hl=en" target="_blank">Google Scholar profile</a><br>
                  Profile on the <a rel="author" href="https://www.uu.nl/staff/EBJarochowska" target="_blank">university webpage</a>

                  </div>
                  '
              ),
            )
          )
        ),
        column(
          width = 4,
          HTML(
            "
              <h5><b> Prof. Peter Burgess</b> </h5>
              "
          ),
          fluidRow(
            column(
              width = 5,
              HTML(
                '
                <figure>
                  <img src="people/peter_burgess.png" alt="Picture of Peter
                  Burgess" align="left" width="100%">
                  <figcaption> <font size="-2"> Figure from <a href="https://xkcd.com/">xkcd.com</a>
                  licensed under the Creative Commons Attribution-NonCommercial
                  2.5 license, see <a href="xkcd.com/license.html">www.xkcd.com/license.html</a>
                  for details. </font></figcaption>
                  </figure>

                  '
              )
            ),
            column(
              width = 7,
              HTML(
                '
                  <div style="margin-left: 0em">
                  University of Liverpool, United Kingdom<br>
                  Email: pmb42 [at] liverpool.ac.uk<br>
                  <a href="https://scholar.google.co.uk/citations?user=C2fIqOoAAAAJ&hl=en" target="_blank">Google Scholar profile</a><br>
                  Profile on the <a rel="author" href="https://www.liverpool.ac.uk/environmental-sciences/staff/peter-burgess/" target="_blank">university webpage</a>

                  </div>
                  '
              ),
            )
          )
        )
      ),
      HTML(
        '
        <h4>
        Code Availability
        </h4>
        <p>
        The code for this app is available under <a href="https://github.com/MindTheGap-ERC/DarwinCAT" target="_blank">github.com/MindTheGap-ERC/DarwinCAT</a>
        <p/>
        <h4>
        License
        </h4>
        <p>
        <a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>. The code used is licensed under a <a rel="license" href="http://www.apache.org/licenses/LICENSE-2.0"> Apache 2.0 License</a>.
        </p>
        <h4>
        Funding
        </h4>
        <p>
        Online access to the app is made possible by the IDUB programme of the University of Warsaw (Grant BOB-IDUB-622-18/2022). Co-funded by the European Union (ERC, MindTheGap, StG project no 101041077). Views and opinions expressed are however those of the author(s) only and do not necessarily reflect those of the European Union or the European Research Council. Neither the European Union nor the granting authority can be held responsible for them.
        </p>
        <h4>
        References
        </h4>
        <ul>
         <li>
         Aze, T., Ezard, T.H.G., Purvis, A., Coxall, H.K., Stewart, D.R.M.,
         Wade, B.S., and Pearson, P.M. (2011). A phylogeny of Cenozoic
         macroperforate planktonic foraminifera from fossil data. Biological
         Reviews, 86, p. 900–927. <a href="https://doi.org/10.1111/j.1469-185X.2011.00178.x">
         doi.org/10.1111/j.1469-185X.2011.00178.x</a>
         </li>
          <li>
          Barido-Sottani, J., Pett, W., O\'Reilly, J.E., Warnock, R.C.M.
          Fossilsim: An r package for simulating fossil occurrence data under
          mechanistic models of preservation and recovery. Methods Ecol
          Evol. 2019, 10: 835–840. <a href="https://doi.org/10.1111/2041-210X.13170">
         doi.org/10.1111/2041-210X.13170</a>
         </li>
         <li>
         Burgess, P.M. (2013). CarboCAT: A cellular automata model of
         heterogeneous carbonate strata: Computers & Geosciences, 53, p.
         129–140. <a href="https://doi.org/10.1016/j.cageo.2011.08.026">
         doi.org/10.1016/j.cageo.2011.08.026</a>
         </li>
         <li>
         <a href="https://darwinscat.bandcamp.com/album/darwins-cat">Darwin\'s Cat. A sci-fi rock band.</a> - not affiliated with this project.
         </li>
         <li>
         Dzik, J. (1991). <a title="Go to Publication"
         href="https://bibliotekanauki.pl/articles/20386.pdf">Features of the
         fossil record of evolution</a>. Acta Palaeontologica
         Polonica, 36, p. 91-113.
         </li>
         <li>
         Gingerich, P.D. (1979). The stratophenetic approach to phylogeny
         reconstruction in vertebrate paleontology. In: Cracraft, J. and
         Eldredge, N. <i>Phylogenetic analysis and palaeontology.
         </i> Columbia University Press, New York. pp. 41-77.
         <a href="https://doi.org/10.7312/crac92306-004">
         doi.org/10.7312/crac92306-004</a>
         </li>
         <li>
         Smith, A.B. (2000). Stratigraphy in phylogeny reconstruction. Journal
         of Paleontology, 74, p. 763-766.
         <a href="https://doi.org/10.1666/0022-3360(2000)074%3C0763:SIPR%3E2.0.CO;2">
         doi.org/10.1666/0022-3360(2000)074%3C0763:SIPR%3E2.0.CO;2</a>
         </li>
        </ul>
        '
      )
    ),
    #### Funding
    hr(),
    div(
      style = "margin-left: 4em; margin-right: 4em; margin-bottom: 2em",
      fluidRow(
        column(
          width = 3,
          img(
            src = "logos/UW_logo.svg",
            alt = "Logo of UW",
            width = "30%",
            align = "left"
          )
        ),
        column(
          width = 3,
          img(
            src = "logos/IDUB_logo.jpeg",
            alt = "Logo of IDUB",
            width = "30%",
            align = "left"
          )
        ),
        column(
          width = 3,
          img(
            src = "logos/mind_the_gap_logo.png",
            alt = "Logo of MindTheGap",
            width = "70%",
            align = "left"
          )
        ),
        column(
          width = 3,
          img(
            src = "logos/UU_logo.jpg",
            width = "70%",
            alt = "Logo of UU",
            align = "right"
          )
        )
      )
    )
  ),
  #### Panel: Modes of Evolution ####
  tabPanel(
    title = "Modes of Evolution",
    fluidRow(
      column(
        width = 2,
        wellPanel(
          tags$h3("Evolutionary Simulations"),
          actionButton(
            inputId = "refreshSimulations_trait_evo",
            label = "Refresh"
          ),
          selectInput(
            inputId = "noOfSims_trait_evo",
            label = "Number of Lineages",
            choices = list("1", "2", "3")
          ),
          selectInput(
            inputId = "modeOfEvolution_trait_evo",
            label = "Mode of Evolution",
            choices = list("Random Walk", "Stasis", "Ornstein-Uhlenbeck")
          ),
          conditionalPanel(
            condition = "input.modeOfEvolution_trait_evo == 'Random Walk'",
            sliderInput(
              inputId = "parameter1_trait_evo",
              label = "Variability",
              min = 0,
              max = 4,
              value = 1,
              step = 0.1,
              animate = TRUE
            ),
            sliderInput(
              inputId = "parameter2_trait_evo",
              label = "Drift",
              min = -2,
              max = 2,
              value = 0,
              step = 0.1,
              animate = TRUE
            ),
            sliderInput(
              inputId = "parameter3_trait_evo",
              label = "Initial Trait Value",
              min = -1,
              max = 1,
              value = 0,
              step = 0.1,
              animate = TRUE
            )
          ),
          conditionalPanel(
            condition = "input.modeOfEvolution_trait_evo == 'Stasis'",
            sliderInput(
              inputId = "parameter4_trait_evo",
              label = "Mean Trait Value",
              min = -1,
              max = 1,
              value = 0,
              step = 0.1,
              animate = TRUE
            ),
            sliderInput(
              inputId = "parameter5_trait_evo",
              label = "Variance",
              min = 0,
              max = 2,
              value = 1,
              step = 0.1,
              animate = TRUE
            )
          ),
          conditionalPanel(
            condition = "input.modeOfEvolution_trait_evo == 'Ornstein-Uhlenbeck'",
            sliderInput(
              inputId = "parameter6_trait_evo",
              label = "Long Term Mean",
              min = -2,
              max = 2,
              value = 0,
              step = 0.1,
              animate = TRUE
            ),
            sliderInput(
              inputId = "parameter7_trait_evo",
              label = "Pressure of Selection",
              min = 0,
              max = 10,
              value = 1,
              step = 0.1,
              animate = TRUE
            ),
            sliderInput(
              inputId = "parameter8_trait_evo",
              label = "Volatility",
              min = 0,
              max = 2,
              value = 1,
              step = 0.1,
              animate = TRUE
            ),
            sliderInput(
              inputId = "parameter9_trait_evo",
              label = "Initial Trait Value",
              min = -4,
              max = 4,
              value = 2,
              step = 0.1,
              animate = TRUE
            )
          )
        )
      ),
      column(
        width = 8,
        fluidRow(
          plotOutput(
            outputId = "timeDomainPlot_trait_evo"
          )
        ),
        fluidRow(
          HTML(
            '
            <h4>
            Modes of Evolution
            </h4>
            <p>
            In evolutionary biology, the process of how organism <a title="Wikipedia article on
            phenotypic traits"
            href="https://en.wikipedia.org/w/index.php?title=Phenotypic_trait&oldid=1143667283">traits</a>
            change through time due to <a href="https://evolution.berkeley.edu/evolution-101/mechanisms-the-processes-of-evolution/genetic-variation/">biological
            generation of variation</a> and selection by the environment
            are referred to as <i>modes of evolution</i>.
            Here, we focus on three mathematical descriptions used to represent modes of evolution:
            <ul>
            <li>Random walk</li>
            <li>Stasis</li>
            <li>and Ornstein-Uhlenbeck</li>
            </ul>
            (Hunt, 2008; Hunt et al. 2008;
            Hopkins and Lidgard, 2012).
            The evolution of a trait within a <a title="Wikipedia article on Lineage"
            href="https://en.wikipedia.org/w/index.php?title=Lineage_(evolution)&oldid=1113106063">
            lineage</a> is specified by the mode of evolution and a set of
            model parameters.
            </p>
            <p>
            To specify the simulated mode of evolution and the number of
            lineages, use the drop-down menu.
            You can adjust the model parameters using the sliders.
            Click the "play" button located beneath the sliders to generate
            an animation.
            You can use the refresh button to generate new simulations based
            on the specified mode and parameters.
            </p>
            <h4>
            References
            </h4>
            <!-- References for the tab "Modes of Evolution"-->
            <ul>
              <li>
              Hunt, G. (2007). The relative importance of directional change,
              random walks, and stasis in the evolution of fossil lineages.
              Proceedings of the National Academy of Sciences, 104, p.
              18404-18408.  <a
              href="https://doi.org/10.1073/pnas.0704088104">doi.org/10.1073/pnas.0704088104</a>
              </li>
              <li>
              Hopkins, M.J. and Lidgard, S. (2012). Evolutionary mode routinely
              varies among morphological traits within fossil species lineages.
              Proceedings of the National Academy of Sciences, 109,
              p. 20520-20525. <a href="https://doi.org/10.1073/pnas.1209901109">
              doi.org/10.1073/pnas.1209901109</a>
              </li>
              <li>
              Hunt, G., Bell, M., and Travis, M.P. (2008). Evolution toward a
              new adaptive optimum: phenotypic evolution in a fossil stickleback
              lineage. Evolution, 62, p. 700-710.
              <a href="https://doi.org/10.1111/j.1558-5646.2007.00310.x">
              doi.org/10.1111/j.1558-5646.2007.00310.x</a>
              </li>
            </ul>
            '
          )
        )
      ),
      column(
        width = 2,
        wellPanel(
          tags$h3("Plot Options"),
          sliderInput(
            inputId = "axis_limits_trait_evo",
            label = "Axis Limits",
            min = -8,
            max = 8,
            value = c(-3, 3),
            step = 0.1,
            animate = FALSE
          ),
          textInput(
            inputId = "trait_name_trait_evo",
            label = "Trait Name",
            value = "log10(Body Size)"
          )
        ),
        wellPanel(
          tags$h3("Download Data"),
          downloadButton(
            outputId = "download_data_trait_evo",
            label = "Download"
          )
        )
      )
    ),

    #### Funding
    hr(),
    div(
      style = "margin-left: 4em; margin-right: 4em; margin-bottom: 2em",
      fluidRow(
        column(
          width = 3,
          img(
            src = "logos/UW_logo.svg",
            alt = "Logo of UW",
            width = "30%",
            align = "left"
          )
        ),
        column(
          width = 3,
          img(
            src = "logos/IDUB_logo.jpeg",
            alt = "Logo of IDUB",
            width = "30%",
            align = "left"
          )
        ),
        column(
          width = 3,
          img(
            src = "logos/mind_the_gap_logo.png",
            alt = "Logo of MindTheGap",
            width = "70%",
            align = "left"
          )
        ),
        column(
          width = 3,
          img(
            src = "logos/UU_logo.jpg",
            width = "70%",
            alt = "Logo of UU",
            align = "right"
          )
        )
      )
    )
  ),
  #### Panel: Carbonate Stratigraphy ####
  tabPanel(
    title = "Carbonate Stratigraphy",
    fluidRow(
      column(
        width = 2,
        wellPanel(
          sliderInput(
            inputId = "distFromShore_carb_strat",
            label = "Distance from Shore",
            min = 0.1,
            max = max_dist_from_shore_km,
            value = 1,
            step = 0.1,
            post = " km",
            animate = TRUE
          ),
          checkboxInput(
            inputId = "plot_time_gaps_carb_strat",
            label = "Display Gaps in Time",
            value = FALSE
          ),
          checkboxInput(
            inputId = "plot_hiatuses_carb_strat",
            label = "Display Hiatuses in Stratigraphic Column",
            value = FALSE
          )
        ),
        HTML(
          "
          Use the slider to view age-depth models from various locations
          on the platform.
          Additionally, you can use the checkboxes to highlight the
          timing and stratigraphic position of hiatuses.
          "
        )
      ),
      column(
        width = 10,
        fluidRow(
          column(
            width = 3,
            HTML(
              '
              <h4>
              Carbonate Platforms
              </h4>
              <!-- The text below will appear beside the Basin Transect in the tab "Carbonate Stratigraphy"-->
              <p>
              The image depicts a transect of a carbonate platform that has
              been simulated using the CarboCAT model (<a title="Go to Publication"
              href="https://doi.org/10.1016/j.cageo.2011.08.026">Burgess 2013</a>).
              The colors correspond to carbonate factories: groups of organism
              s responsible for carbonate production in different ecological
              niches (e.g. the photozoan factory composed of corals and algae
              in the shallowest water).
              The growth of the platform is influenced by three key factors:
              the relative sea level, the environmental preferences of
              the carbonate-producing organisms, and the dispersal abilities
              of biota, which is simulated
              here using <a title="cellular automata"
              href="https://plato.stanford.edu/entries/cellular-automata/ ">cellular automata</a>.
              </p>
              '
            )
          ),
          column(
            width = 9,
            plotOutput(
              outputId = "basinTransect_carb_strat"
            )
          )
        ),
        fluidRow(
          column(
            width = 3,
            HTML(
              '
              <h4>
              Gaps in the Record
              </h4>
              <!-- The text below will appear beside the Wheeler Diagram in the tab "Carbonate Stratigraphy"-->
              <p>
              On the right you see the Wheeler diagram of the simulated platform.
              A Wheeler diagram (<a title="Go to Publication"
              href="https://doi.org/10.1130/0016-7606(1964)75[599:BLSAT]2.0.CO;2">
              Wheeler 1964</a>), also known as a chronostratigraphic chart, shows
              when and where sediment in the basin is deposited.
              White areas indicate the abscence of preserved rocks.
              The diagram demonstrates that gaps in the rock record vary
              systematically with time and as a function of distance from the
              shore. The proportion of time preserved in rocks is called
              stratigraphic completeness.
              </p>
              '
            )
          ),
          column(
            width = 9,
            plotOutput(
              outputId = "wheelerDiagram_carb_strat"
            )
          ),
        ),
        fluidRow(
          column(
            width = 3,
            HTML(
              '
              <h4>
              Time and Stratigraphy
              </h4>
              <!-- The text below will appear beside the ADM plot in the tab "Carbonate Stratigraphy"-->
              <p>
              Age-depth models describe the relationship between rock in
              stratigraphic height (e.g. meters) and geological time (e.g. years).
              They can serve as a coordinate transformation between the time domain
               (where evolution occurs) and stratigraphic domain
               (where fossils are found) (<a title="Go to Publication"
               href="https://doi.org/10.2110/palo.2020.038">Hohmann 2021</a>).
              Intervals where no rock is preserved result in gaps in the age-depth model.
              During these gaps, no evolutionary history is recorded.
              </p>
              '
            )
          ),
          column(
            width = 9,
            plotOutput(
              outputId = "ageDepthModelPlot_carb_strat"
            )
          )
        ),
        fluidRow(
          HTML(
            '
            <h4>
            References
            </h4>
            <!-- References for the tab "Carbonate Stratigraphy"-->
            <ul>
              <li>
              Burgess, P.M. (2013). CarboCAT: A cellular automata model of
              heterogeneous carbonate strata: Computers & Geosciences, 53, p.
              129–140. <a href="https://doi.org/10.1016/j.cageo.2011.08.026">
              doi.org/10.1016/j.cageo.2011.08.026</a>
              </li>
              <li>
              Wheeler, H.E. (1964). Baselevel, lithosphere surface, and
              time-stratigraphy. Geological Society of America Bulletin, 75, p.
              599-610. <a href="https://doi.org/10.1130/0016-7606(1964)75[599:BLSAT]2.0.CO;2">
              doi: 10.1130/0016-7606(1964)75[599:BLSAT2.0.CO;2</a>
              </li>
              <li>
              Hohmann, N. (2021). Incorporating information on varying
              sedimentation rates in paleontological analyses. PALAIOS, 36,
              p. 53–67. <a href = "https://doi.org/10.2110/palo.2020.038">
              doi: 10.2110/palo.2020.038</a>
              </li>
            </ul>
            '
          )
        )
      )
    ),


    #### Funding
    hr(),
    div(
      style = "margin-left: 4em; margin-right: 4em; margin-bottom: 2em",
      fluidRow(
        column(
          width = 3,
          img(
            src = "logos/UW_logo.svg",
            alt = "Logo of UW",
            width = "30%",
            align = "left"
          )
        ),
        column(
          width = 3,
          img(
            src = "logos/IDUB_logo.jpeg",
            alt = "Logo of IDUB",
            width = "30%",
            align = "left"
          )
        ),
        column(
          width = 3,
          img(
            src = "logos/mind_the_gap_logo.png",
            alt = "Logo of MindTheGap",
            width = "70%",
            align = "left"
          )
        ),
        column(
          width = 3,
          img(
            src = "logos/UU_logo.jpg",
            width = "70%",
            alt = "Logo of UU",
            align = "right"
          )
        )
      )
    )
  ),
  #### Panel: Stratigraphuic Paleobiology ####
  tabPanel(
    title = "Stratigraphic Paleobiology",
    fluidRow(
      column(
        width = 2,
        wellPanel(
          tags$h3("Evolutionary Simulations"),
          actionButton(
            inputId = "refreshSimulations_strat_pal",
            label = "Refresh"
          ),
          selectInput(
            inputId = "noOfSims_strat_pal",
            label = "Number of Lineages",
            choices = list("1", "2", "3")
          ),
          selectInput(
            inputId = "modeOfEvolution_strat_pal",
            label = "Mode of Evolution",
            choices = list("Random Walk", "Stasis", "Ornstein-Uhlenbeck")
          ),
          conditionalPanel(
            condition = "input.modeOfEvolution_strat_pal == 'Random Walk'",
            sliderInput(
              inputId = "parameter1_strat_pal",
              label = "Variability",
              min = 0,
              max = 4,
              value = 1,
              step = 0.1,
              animate = TRUE
            ),
            sliderInput(
              inputId = "parameter2_strat_pal",
              label = "Drift",
              min = -2,
              max = 2,
              value = 0,
              step = 0.1,
              animate = TRUE
            ),
            sliderInput(
              inputId = "parameter3_strat_pal",
              label = "Initial Trait Value",
              min = -1,
              max = 1,
              value = 0,
              step = 0.1,
              animate = TRUE
            )
          ),
          conditionalPanel(
            condition = "input.modeOfEvolution_strat_pal == 'Stasis'",
            sliderInput(
              inputId = "parameter4_strat_pal",
              label = "Mean Trait Value",
              min = -1,
              max = 1,
              value = 0,
              step = 0.1,
              animate = TRUE
            ),
            sliderInput(
              inputId = "parameter5_strat_pal",
              label = "Variance",
              min = 0,
              max = 2,
              value = 1,
              step = 0.1,
              animate = TRUE
            )
          ),
          conditionalPanel(
            condition = "input.modeOfEvolution_strat_pal == 'Ornstein-Uhlenbeck'",
            sliderInput(
              inputId = "parameter6_strat_pal",
              label = "Long Term Mean",
              min = -2,
              max = 2,
              value = 0,
              step = 0.1,
              animate = TRUE
            ),
            sliderInput(
              inputId = "parameter7_strat_pal",
              label = "Pressure of Selection",
              min = 0,
              max = 10,
              value = 1,
              step = 0.1,
              animate = TRUE
            ),
            sliderInput(
              inputId = "parameter8_strat_pal",
              label = "Volatility",
              min = 0,
              max = 2,
              value = 1,
              step = 0.1,
              animate = TRUE
            ),
            sliderInput(
              inputId = "parameter9_strat_pal",
              label = "Initial Trait Value",
              min = -4,
              max = 4,
              value = 2,
              step = 0.1,
              animate = TRUE
            )
          )
        ),
        wellPanel(
          tags$h3("Plot Options"),
          sliderInput(
            inputId = "axis_limits_strat_pal",
            label = "Axis Limits",
            min = -8,
            max = 8,
            value = c(-3, 3),
            step = 0.1,
            animate = FALSE
          ),
          textInput(
            inputId = "trait_name_strat_pal",
            label = "Trait Name",
            value = "log10(Body Size)"
          )
        )
      ),
      column(
        width = 8,
        fluidRow(
          fluidRow(
            column(
              width = 4,
              plotOutput("stratDomainPlot_strat_pal")
            ),
            column(
              width = 8,
              plotOutput("ageDepthModelPlot_strat_pal")
            )
          ),
          column(
            width = 8,
            plotOutput("timeDomainPlot_strat_pal"),
            offset = 4
          )
        ),
        fluidRow(
          HTML(
            '
            <h4>
            Where Geology and Biology Meet
            </h4>
            <p>
            The geological record has gaps. These gaps are not distributed at random,
            but change systematically. These systematic changes eliminate certain environments
            and types of organisms that live in them and overemphasize the others. Thus, our
            reconstructions of evolution and ecology from the fossil record may become biased
            (Patzkowsky and Holland, 2012; Danise et al., 2019).
            </p>
            <p>
            Select the mode of evolution and a number of lineages in the drop-down
            menu. You can modify the model parameters with the sliders.
            The figures show how the evolutionary history of the lineages
            originally looked (bottom right), how the age-depth model looks like
            (top right), and what change of traits is observed in the section.
            Use the slider on the right side to change the position in the basin
            you examine.
            In addition to displaying the time intervals and position
            of hiatuses, you can also show the sea level curve, an important
            control on the growth of the carbonate platform.
            Do you see any connection between sea level and the timing
            of the gaps?
            </p>
            <p>
            You can adjust your sampling strategy in the panel on the right.
            </p>
            <h4>
            References
            </h4>
              <ul>
                <li>
                Danise, S., Clémence, M. E., Price, G. D., Murphy, D. P.,
                Gómez, J. J., & Twitchett, R. J. (2019). Stratigraphic and
                environmental control on marine benthic community change
                through the early Toarcian extinction event
                (Iberian Range, Spain). Palaeogeography, Palaeoclimatology,
                Palaeoecology, 524, 183-200.
                <a href="https://doi.org/10.1016/j.palaeo.2019.03.039">
                doi.org/10.1016/j.palaeo.2019.03.039</a>
                </li>
                <li>
                Patzkowsky, M. E., & Holland, S. M. (2012). Stratigraphic
                paleobiology. In Stratigraphic Paleobiology.
                University of Chicago Press.
                </li>
              </ul>
            '
          )
        )
      ),
      column(
        width = 2,
        wellPanel(
          sliderInput(
            inputId = "distFromShore_strat_pal",
            label = "Distance from Shore",
            min = 0.1,
            max = max_dist_from_shore_km,
            value = 1,
            step = 0.1,
            post = " km",
            animate = TRUE
          ),
          checkboxInput(
            inputId = "plotSeaLevel_strat_pal",
            label = "Show Sea Level",
            value = FALSE
          ),
          checkboxInput(
            inputId = "plot_time_gaps_strat_pal",
            label = "Display Gaps in Time",
            value = FALSE
          ),
          checkboxInput(
            inputId = "plot_hiatuses_strat_pal",
            label = "Display Hiatuses in Stratigraphic Column",
            value = FALSE
          )
        ),
        wellPanel(
          selectInput(
            inputId = "sampling_strategy_strat_pal",
            label = "Sampling Strategy",
            choices = list("Fixed Number", "Fixed Distance"),
            selected = "Fixed Distance"
          ),
          conditionalPanel(
            condition = "input.sampling_strategy_strat_pal == 'Fixed Number'",
            sliderInput(
              inputId = "no_of_samples_strat_pal",
              label = "Number of Samples",
              min = 5,
              max = 150,
              value = 20,
              step = 1,
              animate = TRUE
            )
          ),
          conditionalPanel(
            condition = "input.sampling_strategy_strat_pal == 'Fixed Distance'",
            sliderInput(
              inputId = "dist_between_samples_strat_pal",
              label = "Distance between Samples",
              min = 0.1,
              max = 2,
              value = 1,
              step = 0.1,
              post = " m",
              animate = TRUE
            )
          )
        ),
        wellPanel(
          tags$h3("Download Data"),
          downloadButton(
            outputId = "download_data_strat_pal",
            label = "Download"
          )
        ),
      )
    ),
    #### Funding
    hr(),
    div(
      style = "margin-left: 4em; margin-right: 4em; margin-bottom: 2em",
      fluidRow(
        column(
          width = 3,
          img(
            src = "logos/UW_logo.svg",
            alt = "Logo of UW",
            width = "30%",
            align = "left"
          )
        ),
        column(
          width = 3,
          img(
            src = "logos/IDUB_logo.jpeg",
            alt = "Logo of IDUB",
            width = "30%",
            align = "left"
          )
        ),
        column(
          width = 3,
          img(
            src = "logos/mind_the_gap_logo.png",
            alt = "Logo of MindTheGap",
            width = "70%",
            align = "left"
          )
        ),
        column(
          width = 3,
          img(
            src = "logos/UU_logo.jpg",
            width = "70%",
            alt = "Logo of UU",
            align = "right"
          )
        )
      )
    )
  )
)


#### Server ####
server <- function(input, output) {
  #### Trait Evolution: Reactive Variables ####
  eventReactive(eventExpr = input$refreshSimulations_trait_evo, {
    evolutionarySimulations_trait_evo()
  })

  evolutionarySimulations_trait_evo <- reactive({
    input$refreshSimulations_trait_evo
    getEvolutionarySimulations(
      noOfSims = input$noOfSims_trait_evo,
      mode = input$modeOfEvolution_trait_evo,
      input$parameter1_trait_evo,
      input$parameter2_trait_evo,
      input$parameter3_trait_evo,
      input$parameter4_trait_evo,
      input$parameter5_trait_evo,
      input$parameter6_trait_evo,
      input$parameter7_trait_evo,
      input$parameter8_trait_evo,
      input$parameter9_trait_evo
    )
  })

  #### Trait Evolution: Outputs ####

  output$timeDomainPlot_trait_evo <- renderPlot({
    makeTimeDomainPlot(
      ts_list = evolutionarySimulations_trait_evo(),
      trait_name = input$trait_name_trait_evo,
      axis_limits = input$axis_limits_trait_evo,
      plot_strat_info = FALSE
    )
  })

  output$download_data_trait_evo <- downloadHandler(
    filename = function() {
      paste("DarwinCAT_trait_evo", Sys.time(), ".csv", sep = "")
    },
    content = function(file) {
      prepare_download_trait_evo(
        file = file,
        trait_series = evolutionarySimulations_trait_evo(),
        trait_name = input$trait_name_trait_evo,
        mode = input$modeOfEvolution_trait_evo,
        input$parameter1_trait_evo,
        input$parameter2_trait_evo,
        input$parameter3_trait_evo,
        input$parameter4_trait_evo,
        input$parameter5_trait_evo,
        input$parameter6_trait_evo,
        input$parameter7_trait_evo,
        input$parameter8_trait_evo,
        input$parameter9_trait_evo
      )
    }
  )

  #### Carbonate Stratigraphy: Reactive Variables ####
  ageDepthModel_carb_strat <- reactive({
    getAgeDepthModel(
      distanceFromShore = input$distFromShore_carb_strat
    )
  })

  #### Carbonate Stratigraphy: Outputs ####
  output$wheelerDiagram_carb_strat <- renderPlot({
    makeWheelerDiagram(
      distanceFromShore = input$distFromShore_carb_strat
    )
  })

  output$basinTransect_carb_strat <- renderPlot({
    makeBasinTransectPlot(
      distanceFromShore = input$distFromShore_carb_strat
    )
  })

  output$ageDepthModelPlot_carb_strat <- renderPlot({
    makeAgeDepthModelPlot(
      ageDepthModel = ageDepthModel_carb_strat(),
      plot_time_gaps = input$plot_time_gaps_carb_strat,
      plot_hiatuses = input$plot_hiatuses_carb_strat,
      dist_from_shore_km = input$distFromShore_carb_strat
    )
  })

  #### Stratigraphic Paleobiology: Reactive Variables ####
  eventReactive(eventExpr = input$refreshSimulations_strat_pal, {
    evolutionarySimulations_strat_pal()
  })

  evolutionarySimulations_strat_pal <- reactive({
    input$refreshSimulations_strat_pal
    getEvolutionarySimulations(
      noOfSims = input$noOfSims_strat_pal,
      mode = input$modeOfEvolution_strat_pal,
      input$parameter1_strat_pal,
      input$parameter2_strat_pal,
      input$parameter3_strat_pal,
      input$parameter4_strat_pal,
      input$parameter5_strat_pal,
      input$parameter6_strat_pal,
      input$parameter7_strat_pal,
      input$parameter8_strat_pal,
      input$parameter9_strat_pal
    )
  })

  ageDepthModel_strat_pal <- reactive({
    getAgeDepthModel(
      distanceFromShore = input$distFromShore_strat_pal
    )
  })

  transformed_ts_strat_pal <- reactive({
    transform_ts(
      ageDepthModel = ageDepthModel_strat_pal(),
      ts_list = evolutionarySimulations_strat_pal(),
      sampling_strategy = input$sampling_strategy_strat_pal,
      no_of_samples = input$no_of_samples_strat_pal,
      dist_between_samples = input$dist_between_samples_strat_pal
    )
  })
  #### Stratigraphic Paleobiology: Outputs ####
  output$ageDepthModelPlot_strat_pal <- renderPlot({
    makeAgeDepthModelPlot(
      ageDepthModel = ageDepthModel_strat_pal(),
      plot_time_gaps = input$plot_time_gaps_strat_pal,
      plot_hiatuses = input$plot_hiatuses_strat_pal,
      dist_from_shore_km = input$distFromShore_strat_pal
    )
  })

  output$timeDomainPlot_strat_pal <- renderPlot({
    makeTimeDomainPlot(
      ts_list = evolutionarySimulations_strat_pal(),
      ageDepthModel = ageDepthModel_strat_pal(),
      trait_name = input$trait_name_strat_pal,
      axis_limits = input$axis_limits_strat_pal,
      plotSeaLevel = input$plotSeaLevel_strat_pal,
      plot_time_gaps = input$plot_time_gaps_strat_pal,
      plot_strat_info = TRUE
    )
  })

  output$stratDomainPlot_strat_pal <- renderPlot({
    makeStratDomainPlot(
      ageDepthModel = ageDepthModel_strat_pal(),
      transformed_ts = transformed_ts_strat_pal(),
      axis_limits = input$axis_limits_strat_pal,
      trait_name = input$trait_name_strat_pal,
      plotSeaLevel = input$plotSeaLevel_strat_pal,
      plot_hiatuses = input$plot_hiatuses_strat_pal
    )
  })

  output$download_data_strat_pal <- downloadHandler(
    filename = function() {
      paste("DarwinCAT_strat_pal", Sys.time(), ".csv", sep = "")
    },
    content = function(file) {
      prepare_download_strat_pal(
        file = file,
        transformed_ts = transformed_ts_strat_pal(),
        dist_from_shore_km = input$distFromShore_strat_pal,
        sampling_strategy = input$sampling_strategy_strat_pal,
        no_of_samples = input$no_of_samples_strat_pal,
        dist_between_samples = input$dist_between_samples_strat_pal,
        trait_name = input$trait_name_strat_pal,
        mode = input$modeOfEvolution_strat_pal,
        input$parameter1_strat_pal,
        input$parameter2_strat_pal,
        input$parameter3_strat_pal,
        input$parameter4_strat_pal,
        input$parameter5_strat_pal,
        input$parameter6_strat_pal,
        input$parameter7_strat_pal,
        input$parameter8_strat_pal,
        input$parameter9_strat_pal
      )
    }
  )
}

shinyApp(ui = ui, server = server)
