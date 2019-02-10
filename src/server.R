library(shiny)
library(tm)
library(wordcloud2)

toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))

shinyServer(function(input, output) {
  
  data <- reactive({
    if (is.null(input$textFile)) {
      text <- readLines("text.txt")
    } else {
      text <- readLines(input$textFile$datapath)
    }
    
    docs <- Corpus(VectorSource(text))
    docs <- tm_map(docs, toSpace, "/")
    docs <- tm_map(docs, toSpace, "@")
    docs <- tm_map(docs, toSpace, "\\|")
    
    # Convert the text to lower case
    docs <- tm_map(docs, content_transformer(tolower))
    # Remove numbers
    docs <- tm_map(docs, removeNumbers)
    # Remove english common stopwords
    docs <- tm_map(docs, removeWords, stopwords("english"))
    # Remove your own stop word
    # specify your stopwords as a character vector
    docs <- tm_map(docs, removeWords, c(stopwords("SMART"), "thy", "thou", "thee", "the", "and", "but")) 
    # Remove punctuations
    docs <- tm_map(docs, removePunctuation)
    # Eliminate extra white spaces
    docs <- tm_map(docs, stripWhitespace)
    
    dtm <- TermDocumentMatrix(docs)
    m <- as.matrix(dtm)
    v <- sort(rowSums(m),decreasing=TRUE)
    data <- data.frame(word = names(v),freq = v)
    data <- subset(data, freq >= input$freq & freq <= input$max)
  })
  
  output$wordcloud <- renderWordcloud2({
    wordcloud2(data(), size = 0.8)
  })
})