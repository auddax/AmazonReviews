#Parse Amazon html pages for data
amazon_scraper <- function(doc, delay = 0){
  
  require(rvest)
  require(stringr)
  
  sec = 0
  if(delay < 0) warning("delay was less than 0: set to 0")
  if(delay > 0) sec = max(0, delay + runif(1, -1, 1))
  
  
  title <- doc %>%
    html_nodes("#cm_cr-review_list .a-color-base") %>%
    html_text()
  
  author <- doc %>%
    html_nodes("#cm_cr-review_list .a-profile-name") %>%
    html_text()
  if(length(author) == 0) author <- NA
  
  date <- doc %>%
    html_nodes("#cm_cr-review_list .review-date") %>%
    html_text() %>% 
    gsub(".*on ", "", .)
  
  ver.purchase <- doc%>%
    html_nodes(".review-data.a-spacing-mini") %>%
    html_text() %>%
    grepl("Verified Purchase", .) %>%
    as.numeric()
  
  format <- doc %>% 
    html_nodes(".review-data.a-spacing-mini") %>% 
    html_text() %>%
    gsub("Color: |\\|.*|Verified.*", "", .)
  if(length(format) == 0) format <- NA
  
  stars <- doc %>%
    html_nodes("#cm_cr-review_list  .review-rating") %>%
    html_text() %>%
    str_extract("\\d") %>%
    as.numeric()
  
  comments <- doc %>%
    html_nodes("#cm_cr-review_list .review-text") %>%
    html_text() 
  
  df <- data.frame(title, author, date, ver.purchase, format, stars, comments, stringsAsFactors = F)
  
  return(df)
}

