library(shiny)

# load data into workspace
source("src/global.R")

# load functions into workspace
source("src/getAgeDepthModel.R") # determines age-depth models
source("src/getEvolutionarySimulations.R") # simulates trait evolution

# functions to make the plots
source("src/makeAgeDepthModelPlot.R")
source("src/makeTimeDomainPlot.R")
source("src/makeStratDomainPlot.R")


# Generate user interface
ui <- navbarPage(
  title = "DarwinCAT",
  id = "DarwinCAT_app",
  windowTitle = "DarwinCAT",
  tabPanel(
    title = "Introduction",
    "Intro goes here",
    hr(),
    fluidRow("Funding Info Goes Here"),
    hr()
  ),
  tabPanel(
    title = "Modes of Evolution",
    "Intro to Evo Modes goes here"
  ),
  tabPanel(
    title = "Carbonate Stratigraphy",
    "Intro to Strat Pal goes here"
  ),
  tabPanel(
    title = "StratPal",
    column(
      2,
      sliderInput(
        inputId = "distFromShore",
        label = "Distance from Shore",
        min = 0.1,
        max = 15,
        value = 1,
        step = 0.1,
        animate = TRUE
      ),
      checkboxInput(
        inputId = "plotSeaLevel",
        label = "Show sea level",
        value = FALSE
      ),
      checkboxInput(
        inputId = "plot_time_gaps",
        label = "Display Gaps in Time",
        value = FALSE
      ),
      checkboxInput(
        inputId = "plot_hiatuses",
        label = "Display Hiatuses in Rock",
        value = FALSE
      ),
      wellPanel(
        tags$h3("Evolutionary Simulations"),
        actionButton("refreshSimulations", label = "refresh simulations"),
        selectInput(
          inputId = "noOfSims",
          label = "Number of Simulations",
          choices = list("1", "2", "3")
        ),
        selectInput(
          inputId = "modeOfEvolution",
          label = "mode of evolution",
          choices = list("Random Walk", "Stasis", "Ornstein-Uhlenbeck")
        ),
        conditionalPanel(
          condition = "input.modeOfEvolution == 'Random Walk'",
          sliderInput(
            inputId = "parameter1", "Variability sigma",
            min = 0,
            max = 4,
            value = 1,
            step = 0.1
          ),
          sliderInput(
            inputId = "parameter2", "Drift my",
            min = -2,
            max = 2,
            value = 0,
            step = 0.1
          ),
          sliderInput(
            inputId = "parameter3", "initial  value",
            min = -1,
            max = 1,
            value = 0,
            step = 0.1
          )
        ),
        conditionalPanel(
          condition = "input.modeOfEvolution == 'Stasis'",
          sliderInput(
            inputId = "parameter4", "mean value",
            min = -1,
            max = 1,
            value = 0,
            step = 0.1
          ),
          sliderInput("parameter5", "Variance",
            min = 0,
            max = 2,
            value = 1,
            step = 0.1
          )
        ),
        conditionalPanel(
          condition = "input.modeOfEvolution == 'Ornstein-Uhlenbeck'",
          sliderInput(
            inputId = "parameter6", "long term mean value mu",
            min = -2,
            max = 2,
            value = 0,
            step = 0.1
          ),
          sliderInput("parameter7", "pressure of selection theta",
            min = 0,
            max = 10,
            value = 1,
            step = 0.1
          ),
          sliderInput(
            inputId = "parameter8", "volatility/variability sigma",
            min = 0,
            max = 2,
            value = 1,
            step = 0.1
          ),
          sliderInput(
            inputId = "parameter9", "initial value",
            min = -4,
            max = 4,
            value = 2,
            step = 0.1
          )
        )
      ),
      wellPanel(
        "SamplingStrategy",
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
            label = "Distance between Samples [m]",
            min = 0.1,
            max = 2,
            value = 1,
            step = 0.1,
            animate = TRUE
          )
        )
      ),
      wellPanel(
        tags$h3("Plot Options"),
        sliderInput(
          inputId = "axis_limits",
          label = "y axis limits",
          min = -5,
          max = 5,
          value = c(-1,1),
          step = 0.1,
          animate = FALSE
        ),
        textInput(
          inputId = "trait_name",
          label = "Trait",
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
          plotOutput("ageDepthModelPlot")
        )
      ),
      column(
        width = 8,
        plotOutput("timeDomainPlot"),
        offset = 4
      )
    )
  )
)



server <- function(input, output) {
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

  output$ageDepthModelPlot <- renderPlot({
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
