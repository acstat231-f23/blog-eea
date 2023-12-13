library(shiny)
library(tidyverse)
library(plotly)
library(dplyr)

data <- read_csv("data/shiny.csv")

# Define UI for application that draws a histogram
ui <- fluidPage(

  # Application title
  title = "EEA: Blog App Extension",
  titlePanel("HDI Clustering"),
  # Database citation
  p(tags$div(
    HTML(paste("Data is sourced by "
               , tags$a(href="https://data.worldbank.org", "World Bank Open Data")
               , sep = ""))
  )),

        # Show a plot of the generated distribution
        mainPanel(
           plotlyOutput("cluster"),
          em("*all of the variables have been scaled")
        )
    )


# Define server logic required to draw a histogram
server <- function(input, output) {

    output$cluster <- renderPlotly({
      plot_ly(df, x=~life_exp_scaled, y=~gni_scaled, 
              z=~yrs_sch_scaled, color=~cluster, height = 600) %>%
        layout(title = 'Human Development Index Indicators (2022)', scene = list(xaxis = list(title = 'Birth Life Expectancy (yrs)'), 
                                                                                 yaxis = list(title = 'GNI per capita'), zaxis = list(title = 'Expected Years of Schooling (%)')))%>% 
        add_markers(size=1.5)
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
