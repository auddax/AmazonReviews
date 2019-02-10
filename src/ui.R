library(shiny)
library(wordcloud2)


# shinyUI(pageWithSidebar(
#   # left, output on the right
#   headerPanel("Wordcloud"), 
#   sidebarPanel( 
#     fileInput("textFile", "Upload your file", multiple = FALSE, accept = NULL, width = NULL)
#   ),
#   mainPanel(
#     wordcloud2Output("wordcloud")
#   )
# ))

navbarPage("WordCloudR",
  tabPanel("WordCloudR",
           div(class="outer",
               
               tags$head(
                 # Include our custom CSS
                 includeCSS("styles.css")
               ),
               
           wordcloud2Output("wordcloud", height = "800px"),
           
           absolutePanel(
             id = "controls", class = "panel panel-default", fixed = TRUE,
             draggable = TRUE, top = 60, left = 10, right = "auto", bottom = "auto",
             width = 300, height = "auto",
             div(
               h3("Upload your file"),
               align = "center"
             ),
             fileInput("textFile", NULL, multiple = FALSE, accept = NULL, width = NULL),
             hr(),
             sliderInput("freq",
                         "Minimum Frequency:",
                         min = 1,  max = 50, value = 2),
             sliderInput("max",
                         "Maximum Number of Words:",
                         min = 1,  max = 300,  value = 100)
           )
      )
  )
)