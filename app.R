library(shiny)

lesson_nums <- c("01", "02", "03", "04", "05", "06", "07", "08")
activity_nums <- c("01", "02", "03", "04")

rlesson_links <- paste0(
  "https://r.datatools.utoronto.ca/hub/user-redirect/git-pull?",
  "repo=https%3A%2F%2Fgithub.com%2Fsta237%2Frlesson",
  lesson_nums,
  "&urlpath=shiny%2Frlesson",
  lesson_nums,
  "%2F&branch=main"
)
activity_links <- paste0(
  "https://r.datatools.utoronto.ca/hub/user-redirect/git-pull?",
  "repo=https%3A%2F%2Fgithub.com%2Fsta237%2Fweekly",
  activity_nums,
  "&urlpath=shiny%2Fweekly",
  activity_nums,
  "%2F&branch=main"
)

server <- function(input, output) {
  output$result <- renderText({
    withProgress(message = 'Checking required packages', value = 0, {
      if (!require(learnr)) {
        incProgress(NULL, detail = "Installing learnr")
        incProgress(install.packages("learnr"), detail = "Installing learnr")
      }
    })
    if (require(learnr)) {
      "`learnr` installed."
    }
  })
}

ui <- shinyUI(fluidPage(
  hr(),
  div(em(textOutput('result'))),
  hr(),
  fluidRow(
    column(
      6,
      h2("R worksheets"),
      HTML(
        paste0("<div><ul>",
               paste0("<li><a href='", rlesson_links, "' target='_blank'>R Worksheet ", 
                      lesson_nums, "</a></li>"),
               "</ul></div>")
      )     
    ),
    column(
      6,
      h2("Weekly activities"),
      HTML(
        paste0("<div><ul>",
               paste0("<li><a href='", activity_links, "' target='_blank'>Weekly Activity ", 
                      activity_nums, "</a></li>"),
               "</ul></div>")
      )
    )
  )
))

shinyApp(ui = ui, server = server)
