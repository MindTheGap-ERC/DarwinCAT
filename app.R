library(shiny)

# load data
source("src/global.R")


source("src/getAgeDepthModel.R") # determines age-depth models
source("src/getEvolutionarySimulations.R") # simulates trait evolution

# functions to make the plots
source("src/makeAgeDepthModelPlot.R")
source("src/makeTimeDomainPlot.R")
source("src/makeStratDomainPlot.R")



ui <- navbarPage(title="DarwinCAT",
                 id="DarwinCAT_app",
                 windowTitle = "DarwinCAT",
                    tabPanel(title ="Introduction",
                            "Intro goes here",
                            hr(),
                            fluidRow("Funding Info Goes Here"
                            ),
                            hr()
                            ),
                    tabPanel(title = "Modes of Evolution",
                             "Intro to Evo Modes goes here"
                             ),
                    tabPanel(title = "Carbonate Stratigraphy",
                             "Intro to Strat Pal goes here"
                             ),
                    tabPanel(title = "StratPal",
                             column(4,
                             sliderInput(inputId = "distFromShore",
                                         label = "Distance from Shore",
                                         min=0.1,
                                         max=15,
                                         value = 1,
                                         step = 0.1,
                                         animate = TRUE),
                             checkboxInput(inputId = "plotSeaLevel",
                                           label = "Show sea level",
                                           value = FALSE),
                             checkboxInput(inputId = "plotGaps",
                                           label = "Display Gaps",
                                           value = FALSE),
                             actionButton('refreshSimulations',label = 'refresh simulations'),
                             selectInput(inputId = "noOfSims",
                                         label="Number of Simulations",
                                         choices = list("1","2","3")),
                             selectInput(inputId = "modeOfEvolution",
                                         label="mode of evolution",
                                         choices = list("Random Walk","Stasis","Ornstein-Uhlenbeck")),
                             conditionalPanel(condition = "input.modeOfEvolution == 'Random Walk'",
                                              sliderInput(inputId = "parameter1","Variability sigma",
                                                          min=0,
                                                          max=4,
                                                          value=1,
                                                          step = 0.1),
                                              sliderInput(inputId = "parameter2","Drift my",
                                                          min=-2,
                                                          max=2,
                                                          value=0,
                                                          step = 0.1),
                                              sliderInput(inputId = "parameter3","initial  value",
                                                          min=-1,
                                                          max=1,
                                                          value=0,
                                                          step = 0.1)),
                             conditionalPanel(condition = "input.modeOfEvolution == 'Stasis'",
                                              sliderInput(inputId = "parameter4","mean value",
                                                          min=-1,
                                                          max=1,
                                                          value=0,
                                                          step = 0.1),
                                              sliderInput("parameter5","Variance",
                                                          min=0,
                                                          max=2,
                                                          value=1,
                                                          step = 0.1)),
                             conditionalPanel(condition = "input.modeOfEvolution == 'Ornstein-Uhlenbeck'",
                                              sliderInput(inputId = "parameter6","long term mean value mu",
                                                          min=-2,
                                                          max=2,
                                                          value=0,
                                                          step = 0.1),
                                              sliderInput("parameter7","pressure of selection theta",
                                                          min=0,
                                                          max=10,
                                                          value=1,
                                                          step = 0.1),
                                             sliderInput(inputId = "parameter8","volatility/variability sigma",
                                                         min=0,
                                                         max=2,
                                                         value=1,
                                                         step = 0.1),
                                             sliderInput(inputId = "parameter9","initial value",
                                                         min=-4,
                                                         max=4,
                                                         value=2,
                                                         step = 0.1))

                             ),
                             column(8,
                                    fluidRow(
                                           column(4,plotOutput("stratDomainPlot")) ,
                             column(8,plotOutput("ageDepthModelPlot"))),
                             column(8,plotOutput("timeDomainPlot"),offset=4)
                             )
                             )
                 )



server <- function(input, output) {
  eventReactive(eventExpr=input$refreshSimulations,
               {evolutionarySimulations()})
  
  evolutionarySimulations=reactive({input$refreshSimulations
    getEvolutionarySimulations(noOfSims=input$noOfSims,
                      mode=input$modeOfEvolution,
                      input$parameter1,
                      input$parameter2,
                      input$parameter3,
                      input$parameter4,
                      input$parameter5,
                      input$parameter6,
                      input$parameter7,
                      input$parameter8,
                      input$parameter9)})
  ageDepthModel=reactive({
    getAgeDepthModel(distanceFromShore=input$distFromShore)
  })

  output$ageDepthModelPlot=renderPlot({
    makeAgeDepthModelPlot(ageDepthModel=ageDepthModel())
  })
  
  output$timeDomainPlot=renderPlot({
   makeTimeDomainPlot(evolutionarySimulations(),
                      ageDepthModel=ageDepthModel(),
                      plotSeaLevel=input$plotSeaLevel,
                      plotGaps=input$plotGaps)
  })
  
  output$stratDomainPlot=renderPlot({
    makeStratDomainPlot(ageDepthModel(),
                        evolutionarySimulations(),
                        plotSeaLevel=input$plotSeaLevel,
                        plotGaps=input$plotGaps)
  })

}

shinyApp(ui = ui, server = server)