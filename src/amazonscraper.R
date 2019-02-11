#Parse Amazon html pages for data
amzn_scr <- function(data){
  
  require(rvest)
  require(stringr)
  
  title <- data %>%
    html_nodes("#cm_cr-review_list .a-color-base") %>%
    html_text()
  
  author <- data %>%
    html_nodes("#cm_cr-review_list .a-profile-name") %>%
    html_text()
  
  
  date <- data %>%
    html_nodes("#cm_cr-review_list .review-date") %>%
    html_text() %>% 
    gsub(".*on ", "", .) %>%
    as.Date(format = "%B %d, %Y")
  
  ver.purchase <- data%>%
    html_nodes(".review-data.a-spacing-mini") %>%
    html_text() %>%
    grepl("Verified Purchase", .) %>%
    as.numeric()
  
  format <- data %>% 
    html_nodes(".review-data.a-spacing-mini") %>% 
    html_text() %>%
    gsub("Color: |\\|.*|Verified.*", "", .) %>% 
    gsub("Format: ", "", .)
  
  stars <- data %>%
    html_nodes("#cm_cr-review_list  .review-rating") %>%
    html_text() %>%
    str_extract("\\d") %>%
    as.numeric()
  
  comments <- data %>%
    html_nodes("#cm_cr-review_list .review-text") %>%
    html_text() 
  
  df <- data.frame(title, author, date, ver.purchase, format, stars, comments, stringsAsFactors = F)
  
  if (nrow(df) != 0) {
    return(df)
  } else {
    return(NULL)
  }
}

