require(xml2)

source('~/Programming/AmazonReviews/src/amazonscraper.R')

pages <- 2
id <- "B002RI99IM"
reviews_all <- NULL

for(page_num in 1:pages){
  url <- paste0("http://www.amazon.com/product-reviews/", id,"/?pageNumber=", page_num)
  doc <- read_html(url)
  reviews <- amazon_scraper(doc, delay = 2)
  reviews_all <- rbind(reviews_all, reviews)
}
