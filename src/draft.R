require(xml2)

source('~/Programming/AmazonReviews/src/amazonscraper.R')

pages <- 150
id <- "B002RI99IM"
reviews_all <- NULL

for(page_num in 100:pages){
  url <- paste0("http://www.amazon.com/product-reviews/", id,"/?pageNumber=", page_num)
  raw_data <- read_html(url)
  reviews <- amzn_scr(raw_data)
  if (!is.null(reviews)) {
    reviews_all <- rbind(reviews_all, reviews)
  } else {
    break
  }
}
