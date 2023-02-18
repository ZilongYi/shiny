library(shiny)

ui <- navbarPage('App title', # navbar!
                 tabPanel('A', # first navbar page
                          sidebarLayout( 
                            sidebarPanel("You can add Input function here"), # sidebar panel inside the first navbar page
                            mainPanel(
                              tabsetPanel( # there are two tabs in the main panel 
                                tabPanel('tab-1',
                                         "First panel"
                                ),
                                tabPanel('tab-2',
                                         "Second panel"
                                         
                                )
                              )
                            )
                          )
                 ),
                 tabPanel('B', 'Hello'), # second navbar tab.
                 tabPanel('Histogram', # third navbar tab. We added here the UI elements we coded in L1
                          titlePanel("Old Faithful Geyser Data"),
                          sidebarLayout(
                            sidebarPanel( # the slider input is in the sidebar
                              sliderInput(inputId='bins',
                                          label='i am label',
                                          min=2,
                                          max=50,
                                          value=20)
                            ),
                            mainPanel( # The histogram plot is the main panel
                              plotOutput(outputId = 'hist')
                            )
                          )
                 ),
                 navbarMenu("subpanels", # the fourth tab of the navbar is a menu with 3 new pages
                            tabPanel("panel Da", "D-a"),
                            tabPanel("panel Db", "D-b"),
                            tabPanel("panel Dc", "D-c"))
                 
)

server <- function(input, output, session) {
  
  output$hist <-  renderPlot({
    
    x    <- faithful[, 2]
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    # draw the histogram with the specified number of bins
    hist(x, breaks = bins, col = 'darkgray', border = 'white',
         xlab = 'Waiting time to next eruption (in mins)',
         main = 'Histogram of waiting times')
  })
}

shinyApp(ui, server)
