library(shiny)

server <- function(input, output) {
  output$result <- renderText({
    withProgress(message = 'Checking required packages', value = 0, {
      if (!require(learnr)) {
        incProgress(install.packages("learnr"), detail = "Installing learnr")
      }
    })
    if (require(learnr)) {
      "`learnr` installed."
    }
  })
}

ui <- shinyUI(basicPage(
  div(textOutput('result'))
))

shinyApp(ui = ui, server = server)
