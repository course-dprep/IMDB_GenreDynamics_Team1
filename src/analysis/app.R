library(shiny)
library(tidyverse)
library(fixest)
library(tidyr)
library(skimr)
library(infer)
library(modelsummary)
library(broom)
library(purrr)
library(viridis)
library(estimatr)
library(pdftools)

# Define UI
ui <- fluidPage(
  titlePanel("Genre Preferences Analysis"),
  mainPanel(
    fluidRow(
      column(6,
             selectInput("genre_1", "Select Genre 1:", choices = unique(graph_data$genre.x)),
             plotlyOutput("plot_output_1")
      ),
      column(6,
             selectInput("genre_2", "Select Genre 2:", choices = unique(graph_data$genre.x)),
             plotlyOutput("plot_output_2")
      )
    ),
    br(),
    p("Hover over a dot in the plot to see the exact value of the estimate, and click on the significance value on the index on the right to filter on significance.")
  )
)

# Define server logic
server <- function(input, output, session) {
  # Render the plots
  output$plot_output_1 <- renderPlotly({
    selected_genre_data <- reactive({
      filtered_data <- graph_data %>%
        filter(genre.x == input$genre_1)
      return(filtered_data)
    })
    
    p <- ggplot(selected_genre_data(), aes(x = as.factor(sample), y = coef_value, color = factor(p_significance))) +
      geom_point() +
      geom_errorbar(aes(ymin = lower_ci, ymax = upper_ci), width = 0.2) +
      scale_color_manual(values = c("red", "green"), 
                         labels = c("Insignificant", "Significant")) +
      xlab("Year") + ylab("Coefficient Value") + ggtitle(paste("Genre:", input$genre_1)) +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
      guides(color = guide_legend(title = "Significance"))
    
    # Convert ggplot to plotly
    ggplotly(p, tooltip = c("x", "y"), click = "plot_click")
  })
  
  output$plot_output_2 <- renderPlotly({
    selected_genre_data <- reactive({
      filtered_data <- graph_data %>%
        filter(genre.x == input$genre_2)
      return(filtered_data)
    })
    
    p <- ggplot(selected_genre_data(), aes(x = as.factor(sample), y = coef_value, color = factor(p_significance))) +
      geom_point() +
      geom_errorbar(aes(ymin = lower_ci, ymax = upper_ci), width = 0.2) +
      scale_color_manual(values = c("red", "green"), 
                         labels = c("Insignificant", "Significant")) +
      xlab("Year") + ylab("Coefficient Value") + ggtitle(paste("Genre:", input$genre_2)) +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
      guides(color = guide_legend(title = "Significance"))
    
    # Convert ggplot to plotly
    ggplotly(p, tooltip = c("x", "y"), click = "plot_click")
  })
}

# Run the application
shinyApp(ui = ui, server = server)




