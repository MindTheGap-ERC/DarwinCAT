library(shiny)
library(png)

# load data & global variables
source("src/global.R")

# load functions into workspace
source("src/getAgeDepthModel.R") # determines age-depth models
source("src/getEvolutionarySimulations.R") # simulates trait evolution

# functions to make the plots
source("src/makeAgeDepthModelPlot.R")
source("src/makeTimeDomainPlot.R")
source("src/makeStratDomainPlot.R")
source("src/makeBasinTransectPlot.R")
source("src/makeWheelerDiagram.R")
source("src/makeTimeDomainPlot_no_gap.R")


#### Iser interface ####
ui <- navbarPage(
  title = "DarwinCAT",
  id = "DarwinCAT_app",
  windowTitle = "DarwinCAT",
  #### Panel: Introduction ####
  tabPanel(
    title = "Introduction",
    "Sneak peek of DarwinCAT, not an official release! To view model outputs, navigate to the Panel \"Stratigraphic Paleobiology\"",
    # fluidRow(
    #   div(style = "margin-left: 1em; margin-bottom: -0.5em", tags$h4(" Creators")),
    #   column(
    #     6,
    #     tags$h5(tags$b("Niklas Hohmann")),
    #     fluidRow(
    #       column(5, img(src = "people/niklas_hohmann.jpg", alt = "Picture of Niklas Hohmann", align = "left", width = "100%")),
    #       column(
    #         7,
    #         div(style = "margin-left: -4em", tags$ul(
    #           "PhD candidate", br(),
    #           "Utrecht University, The Netherlands", br(),
    #           "Email: N.Hohmann (at) uu.nl", br(),
    #           HTML("Twitter: <a href=https://twitter.com/HohmannNiklas target=\"_blank\" > @HohmannNiklas </a>"), br(),
    #           HTML("Mastodon: <a href=https://ecoevo.social/@Niklas_Hohmann target=\"_blank\" > @Niklas_Hohmann@ecoevo.social </a>"), br(),
    #           HTML("<a href=https://scholar.google.com/citations?hl=de&user=2CB_ktEAAAAJ target=\"_blank\" > Google Scholar profile </a>"), br(),
    #           HTML("Profile on the <a href=https://www.uu.nl/staff/NHohmann target=\"_blank\" > university webpage </a>"), br(),
    #           HTML("<a href=https://github.com/NiklasHohmann target=\"_blank\" > GitHub page </a>")
    #         )),
    #       )
    #     )
    #   ),
    #   column(
    #     6,
    #     tags$h5(tags$b("Dr. Emilia Jarochowska")),
    #     fluidRow(
    #       column(5, img(src = "people/emilia_jarochowska.jpg", alt = "Picture of Emilia Jarochowska", align = "left", width = "100%")),
    #       column(7, div(style = "margin-left: -4em", tags$ul(
    #         "Utrecht University, The Netherlands", br(),
    #         "Email: e.b.jarochowska (at) uu.nl", br(),
    #         HTML("Mastodon: <a href=https://circumstances.run/@Emiliagnathus target=\"_blank\" > @Emiliagnathus@circumstances.run </a>"), br(),
    #         HTML("<a href=https://scholar.google.de/citations?user=Zrldp2MAAAAJ&hl=en target=\"_blank\" > Google Scholar profile </a>"), br(),
    #         HTML("Profile on the <a href=https://www.uu.nl/staff/EBJarochowska target=\"_blank\" > university webpage </a>")
    #       )), )
    #     )
    #   )
    # ),
    hr(),
    fluidRow(
      tags$h4("Code Availability"),
      tags$p(HTML('The code for this app is available under <a href="https://github.com/NiklasHohmann/DarwinCAT" target="_blank">github.com/NiklasHohmann/DarwinCAT </a>')),
      
      tags$h4("License"),
      tags$p(HTML('<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>. The code used is licensed under a <a rel="license" href="http://www.apache.org/licenses/LICENSE-2.0"> Apache 2.0 License</a>.')),
      
      
      tags$h4("Funding"),
      tags$p("Online access to the App is made possible by the IDUB programme of the University of Warsaw (Grant BOB-IDUB-622-18/2022). Co-funded by the European Union (ERC, MindTheGap, StG project no 101041077). Views and opinions expressed are however those of the author(s) only and do not necessarily reflect those of the European Union or the European Research Council. Neither the European Union nor the granting authority can be held responsible for them.")
    ),
    tags$h4("References"),
    tags$p("Coming Soon"),
    #### Funding
    hr(),
    fluidRow(
      column(
        3,
        img(src = "logos/UW_logo.svg", alt = "Logo of UW", width = "30%", align = "left")
      ),
      column(
        3,
        img(src = "logos/IDUB_logo.jpeg", alt = "Logo of IDUB", width = "30%", align = "left")
      ),
      column(
        3,
        img(src = "logos/mind_the_gap_logo.png", alt = "Logo of MindTheGap", width = "70%", align = "left")
      ),
      column(
        3,
        img(src = "logos/UU_logo.jpg", width = "70%", alt = "Logo of UU", align = "left")
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
              label = "Variability (sigma)",
              min = 0,
              max = 4,
              value = 1,
              step = 0.1
            ),
            sliderInput(
              inputId = "parameter2_trait_evo",
              label = "Drift (my)",
              min = -2,
              max = 2,
              value = 0,
              step = 0.1
            ),
            sliderInput(
              inputId = "parameter3_trait_evo",
              label = "Initial Trait Value",
              min = -1,
              max = 1,
              value = 0,
              step = 0.1
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
              step = 0.1
            ),
            sliderInput(
              inputId = "parameter5_trait_evo",
              label = "Variance",
              min = 0,
              max = 2,
              value = 1,
              step = 0.1
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
              step = 0.1
            ),
            sliderInput(
              inputId = "parameter7_trait_evo",
              label = "Pressure of Selection",
              min = 0,
              max = 10,
              value = 1,
              step = 0.1
            ),
            sliderInput(
              inputId = "parameter8_trait_evo",
              label = "Volatility",
              min = 0,
              max = 2,
              value = 1,
              step = 0.1
            ),
            sliderInput(
              inputId = "parameter9_trait_evo",
              label = "Initial Trait Value",
              min = -4,
              max = 4,
              value = 2,
              step = 0.1
            )
          )
        )
      ),
      column(
        width = 8,
        plotOutput(
          outputId = "timeDomainPlot_trait_evo"
        ),
      ),
      column(
        width = 2,
        wellPanel(
          tags$h3("Plot Options"),
          sliderInput(
            inputId = "axis_limits_trait_evo",
            label = "y axis limits",
            min = -8,
            max = 8,
            value = c(-3, 3),
            step = 0.1,
            animate = FALSE
          ),
          textInput(
            inputId = "trait_name_trait_evo",
            label = "Name of Trait",
            value = "log10(Body Size)"
          )
        )
      )
    ),

    #### Funding
    hr(),
    fluidRow(
      column(
        3,
        img(src = "logos/UW_logo.svg", alt = "Logo of UW", width = "30%", align = "left")
      ),
      column(
        3,
        img(src = "logos/IDUB_logo.jpeg", alt = "Logo of IDUB", width = "30%", align = "left")
      ),
      column(
        3,
        img(src = "logos/mind_the_gap_logo.png", alt = "Logo of MindTheGap", width = "70%", align = "left")
      ),
      column(
        3,
        img(src = "logos/UU_logo.jpg", width = "70%", alt = "Logo of UU", align = "left")
      )
    )
  ),
  #### Panel: Carbonate Stratigraphy ####
  tabPanel(
    title = "Carbonate Stratigraphy",
    column(
      width = 4,
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
        label = "Display Hiatuses in Strat. Column",
        value = FALSE
      )
    ),
    column(
      width = 8,
      plotOutput(
        outputId = "wheelerDiagram"
      ),
      plotOutput(
        outputId = "basinTransect"
      ),
      plotOutput(
        outputId = "ageDepthModelPlot_carb_strat"
      )
    ),


    #### Funding
    hr(),
    fluidRow(
      column(
        3,
        img(src = "logos/UW_logo.svg", alt = "Logo of UW", width = "30%", align = "left")
      ),
      column(
        3,
        img(src = "logos/IDUB_logo.jpeg", alt = "Logo of IDUB", width = "30%", align = "left")
      ),
      column(
        3,
        img(src = "logos/mind_the_gap_logo.png", alt = "Logo of MindTheGap", width = "70%", align = "left")
      ),
      column(
        3,
        img(src = "logos/UU_logo.jpg", width = "70%", alt = "Logo of UU", align = "left")
      )
    )
  ),
  #### Panel: Stratigraphuic Paleobiology ####
  tabPanel(
    title = "Stratigraphic Paleobiology",
    fluidRow(
    column(
      2,

      wellPanel(
        tags$h3("Evolutionary Simulations"),
        actionButton(
          inputId = "refreshSimulations",
          label = "refresh simulations"
        ),
        selectInput(
          inputId = "noOfSims",
          label = "Number of Simulations",
          choices = list("1", "2", "3")
        ),
        selectInput(
          inputId = "modeOfEvolution",
          label = "Mode of Evolution",
          choices = list("Random Walk", "Stasis", "Ornstein-Uhlenbeck")
        ),
        conditionalPanel(
          condition = "input.modeOfEvolution == 'Random Walk'",
          sliderInput(
            inputId = "parameter1",
            label = "Variability sigma",
            min = 0,
            max = 4,
            value = 1,
            step = 0.1
          ),
          sliderInput(
            inputId = "parameter2",
            label = "Drift my",
            min = -2,
            max = 2,
            value = 0,
            step = 0.1
          ),
          sliderInput(
            inputId = "parameter3",
            label = "initial  value",
            min = -1,
            max = 1,
            value = 0,
            step = 0.1
          )
        ),
        conditionalPanel(
          condition = "input.modeOfEvolution == 'Stasis'",
          sliderInput(
            inputId = "parameter4",
            label = "mean value",
            min = -1,
            max = 1,
            value = 0,
            step = 0.1
          ),
          sliderInput(
            inputId = "parameter5",
            label = "Variance",
            min = 0,
            max = 2,
            value = 1,
            step = 0.1
          )
        ),
        conditionalPanel(
          condition = "input.modeOfEvolution == 'Ornstein-Uhlenbeck'",
          sliderInput(
            inputId = "parameter6",
            label = "long term mean value mu",
            min = -2,
            max = 2,
            value = 0,
            step = 0.1
          ),
          sliderInput(
            inputId = "parameter7",
            label = "pressure of selection theta",
            min = 0,
            max = 10,
            value = 1,
            step = 0.1
          ),
          sliderInput(
            inputId = "parameter8",
            label = "volatility/variability sigma",
            min = 0,
            max = 2,
            value = 1,
            step = 0.1
          ),
          sliderInput(
            inputId = "parameter9",
            label = "initial value",
            min = -4,
            max = 4,
            value = 2,
            step = 0.1
          )
        )
      ),
      wellPanel(
        tags$h3("Plot Options"),
        sliderInput(
          inputId = "axis_limits",
          label = "y axis limits",
          min = -8,
          max = 8,
          value = c(-3, 3),
          step = 0.1,
          animate = FALSE
        ),
        textInput(
          inputId = "trait_name",
          label = "Name of Trait",
          value = "log10(Body Size)"
        )
      )
    ),
    column(
      width = 8,
      fluidRow(
        column(
          width = 4,
          plotOutput("stratDomainPlot")
        ),
        column(
          width = 8,
          plotOutput("ageDepthModelPlot_strat_pal")
        )
      ),
      column(
        width = 8,
        plotOutput("timeDomainPlot"),
        offset = 4
      )
    ),
    column(
      width = 2,
      wellPanel(
        sliderInput(
          inputId = "distFromShore",
          label = "Distance from Shore",
          min = 0.1,
          max = max_dist_from_shore_km,
          value = 1,
          step = 0.1,
          post = " km",
          animate = TRUE
        ),
        checkboxInput(
          inputId = "plotSeaLevel",
          label = "Show Sea Level",
          value = FALSE
        ),
        checkboxInput(
          inputId = "plot_time_gaps",
          label = "Display Gaps in Time",
          value = FALSE
        ),
        checkboxInput(
          inputId = "plot_hiatuses",
          label = "Display Hiatuses in Stratigraphy",
          value = FALSE
        )
      ),
      wellPanel(
        selectInput(
          inputId = "sampling_strategy",
          label = "Sampling Strategy",
          choices = list("Constant Number", "Constant Distance"),
          selected = "Constant Distance"
        ),
        conditionalPanel(
          condition = "input.sampling_strategy == 'Constant Number'",
          sliderInput(
            inputId = "no_of_samples",
            label = "Number of Samples",
            min = 5,
            max = 150,
            value = 20,
            step = 1,
            animate = TRUE
          )
        ),
        conditionalPanel(
          condition = "input.sampling_strategy == 'Constant Distance'",
          sliderInput(
            inputId = "dist_between_samples",
            label = "Distance between Samples",
            min = 0.1,
            max = 2,
            value = 1,
            step = 0.1,
            post = " m",
            animate = TRUE
          )
        )
      )
    )
    ),
    #### Funding
    hr(),
    fluidRow(
      column(
        3,
        img(src = "logos/UW_logo.svg", alt = "Logo of UW", width = "30%", align = "left")
      ),
      column(
        3,
        img(src = "logos/IDUB_logo.jpeg", alt = "Logo of IDUB", width = "30%", align = "left")
      ),
      column(
        3,
        img(src = "logos/mind_the_gap_logo.png", alt = "Logo of MindTheGap", width = "70%", align = "left")
      ),
      column(
        3,
        img(src = "logos/UU_logo.jpg", width = "70%", alt = "Logo of UU", align = "left")
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
    makeTimeDomainPlot_no_gap(
      evolutionarySimulations = evolutionarySimulations_trait_evo(),
      trait_name = input$trait_name_trait_evo,
      axis_limits = input$axis_limits_trait_evo
    )
  })

  #### Carbonate Stratigraphy: Reactive Variables ####
  ageDepthModel_carb_strat <- reactive({
    getAgeDepthModel(
      distanceFromShore = input$distFromShore_carb_strat
    )
  })

  #### Carbonate Stratigraphy: Outputs ####
  output$wheelerDiagram <- renderPlot({
    makeWheelerDiagram(
      distanceFromShore = input$distFromShore_carb_strat
    )
  })

  output$basinTransect <- renderPlot({
    makeBasinTransectPlot(
      distanceFromShore = input$distFromShore_carb_strat
    )
  })

  output$ageDepthModelPlot_carb_strat <- renderPlot({
    makeAgeDepthModelPlot(
      ageDepthModel = ageDepthModel_carb_strat(),
      plot_time_gaps = input$plot_time_gaps_carb_strat,
      plot_hiatuses = input$plot_hiatuses_carb_strat
    )
  })

  #### Stratigraphic Paleobiology: Reactive Variables ####
  eventReactive(eventExpr = input$refreshSimulations, {
    evolutionarySimulations()
  })

  evolutionarySimulations <- reactive({
    input$refreshSimulations
    getEvolutionarySimulations(
      noOfSims = input$noOfSims,
      mode = input$modeOfEvolution,
      input$parameter1,
      input$parameter2,
      input$parameter3,
      input$parameter4,
      input$parameter5,
      input$parameter6,
      input$parameter7,
      input$parameter8,
      input$parameter9
    )
  })

  ageDepthModel <- reactive({
    getAgeDepthModel(
      distanceFromShore = input$distFromShore
    )
  })
  #### Stratigraphic Paleobiology: Outputs ####
  output$ageDepthModelPlot_strat_pal <- renderPlot({
    makeAgeDepthModelPlot(
      ageDepthModel = ageDepthModel(),
      plot_time_gaps = input$plot_time_gaps,
      plot_hiatuses = input$plot_hiatuses
    )
  })

  output$timeDomainPlot <- renderPlot({
    makeTimeDomainPlot(
      evolutionarySimulations = evolutionarySimulations(),
      ageDepthModel = ageDepthModel(),
      trait_name = input$trait_name,
      axis_limits = input$axis_limits,
      plotSeaLevel = input$plotSeaLevel,
      plot_time_gaps = input$plot_time_gaps
    )
  })

  output$stratDomainPlot <- renderPlot({
    makeStratDomainPlot(
      ageDepthModel = ageDepthModel(),
      evolutionarySimulations = evolutionarySimulations(),
      axis_limits = input$axis_limits,
      trait_name = input$trait_name,
      plotSeaLevel = input$plotSeaLevel,
      plot_hiatuses = input$plot_hiatuses,
      sampling_strategy = input$sampling_strategy,
      dist_between_samples = input$dist_between_samples,
      no_of_samples = input$no_of_samples
    )
  })
}

shinyApp(ui = ui, server = server)
