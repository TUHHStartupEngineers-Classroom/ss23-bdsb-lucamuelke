# WEBSCRAPING ----

# 1.0 LIBRARIES ----

library(tidyverse) # Main Package - Loads dplyr, purrr, etc.
library(rvest)     # HTML Hacking & Web Scraping
library(xopen)     # Quickly opening URLs
library(jsonlite)  # converts JSON files to R objects
library(glue)      # concatenate strings
library(stringi)   # character string/text processing
library(xml2)
library(tibble)


# 2.0 COLLECT BIKE DATA ----

# Get the URLs for the bikes of the first category
html_bike_category  <- read_html("https://www.radon-bikes.de/roadbike-gravel/alu/bikegrid/")
bike_names_tbl        <- html_bike_category %>%
  
  html_nodes(css = ".a-heading--small")# %>%
  #html_attr("href") %>%
  
  # Remove the query parameters of the URL (everything after the '?')
  #str_remove(pattern = "\\?.*") %>%
  
  # Convert vector to tibble
  #enframe(name = "position", value = "url")

names <- xml_text(bike_names_tbl)
names <- names[-c(36, 37)]
names <- names[-5]
names <- names[-4]
cat(names)

bike_price_tbl        <- html_bike_category %>%
  
  html_nodes(css = ".m-bikegrid__price--active")

prices <- xml_text(bike_price_tbl)
library(stringr)
prices <- str_remove(prices, " ₤")
prices <- str_remove(prices, "₤")
prices <- str_remove(prices, "₤ ")
prices <- prices[prices != ""]
library(readr)
prices_numeric <- sapply(prices, parse_number)
cat(prices_numeric)

cat(names)
output <- cbind(names, prices_numeric)
cat(output)