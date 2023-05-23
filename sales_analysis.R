# Data Science at TUHH ------------------------------------------------------
# SALES ANALYSIS ----

# 1.0 Load libraries ----
install.packages("tidyverse")
library(tidyverse)
install.packages("readxl")
library(readxl)

# 2.0 Importing Files ----
# A good convention is to use the file name and suffix it with tbl for the data structure tibble
bikes_tbl      <- read_excel(path = "ds_data/01_bike_sales/01_raw_data/bikes.xlsx")
orderlines_tbl <- read_excel("ds_data/01_bike_sales/01_raw_data/orderlines.xlsx")

# Not necessary for this analysis, but for the sake of completeness
bikeshops_tbl  <- read_excel("ds_data/01_bike_sales/01_raw_data/bikeshops.xlsx")

# 3.0 Examining Data ----
# Method 1: Print it to the console
orderlines_tbl
# A tibble: 15,644 x 7
##    ...1  order.id order.line order.date          customer.id product.id quantity
##    <chr>    <dbl>      <dbl> <dttm>                    <dbl>      <dbl>    <dbl>
##  1 1            1          1 2015-01-07 00:00:00           2       2681        1
##  2 2            1          2 2015-01-07 00:00:00           2       2411        1
##  3 3            2          1 2015-01-10 00:00:00          10       2629        1
##  4 4            2          2 2015-01-10 00:00:00          10       2137        1
##  5 5            3          1 2015-01-10 00:00:00           6       2367        1
##  6 6            3          2 2015-01-10 00:00:00           6       1973        1
##  7 7            3          3 2015-01-10 00:00:00           6       2422        1
##  8 8            3          4 2015-01-10 00:00:00           6       2655        1
##  9 9            3          5 2015-01-10 00:00:00           6       2247        1
## 10 10           4          1 2015-01-11 00:00:00          22       2408        1
## # … with 15,634 more rows

# Method 2: Clicking on the file in the environment tab (or run View(orderlines_tbl)) There you can play around with the filter.

# Method 3: glimpse() function. Especially helpful for wide data (data with many columns)
glimpse(orderlines_tbl)
## Rows: 15,644
## Columns: 7
## $ ...1        <chr> "1", "2", "3", "4", "5", "6", "7", "8", "…
## $ order.id    <dbl> 1, 1, 2, 2, 3, 3, 3, 3, 3, 4, 5, 5, 5, 5,…
## $ order.line  <dbl> 1, 2, 1, 2, 1, 2, 3, 4, 5, 1, 1, 2, 3, 4,…
## $ order.date  <dttm> 2015-01-07, 2015-01-07, 2015-01-10, 2015…
## $ customer.id <dbl> 2, 2, 10, 10, 6, 6, 6, 6, 6, 22, 8, 8, 8,…
## $ product.id  <dbl> 2681, 2411, 2629, 2137, 2367, 1973, 2422,…
## $ quantity    <dbl> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 1, 1,…

# 4.0 Joining Data ----
# by automatically detecting a common column, if any ...
#left_join(orderlines_tbl, bikes_tbl)
## Error: `by` must be supplied when `x` and `y` have no common variables.

# If the data has no common column name, you can provide each column name in the "by" argument. For example, by = c("a" = "b") will match x.a to y.b. The order of the columns has to match the order of the tibbles).
left_join(orderlines_tbl, bikes_tbl, by = c("product.id" = "bike.id"))
## # A tibble: 15,644 x 15
##    ...1  order.id order.line order.date          customer.id
##    <chr>    <dbl>      <dbl> <dttm>                    <dbl>
##  1 1            1          1 2015-01-07 00:00:00           2
##  2 2            1          2 2015-01-07 00:00:00           2
##  3 3            2          1 2015-01-10 00:00:00          10
##  4 4            2          2 2015-01-10 00:00:00          10
##  5 5            3          1 2015-01-10 00:00:00           6
##  6 6            3          2 2015-01-10 00:00:00           6
##  7 7            3          3 2015-01-10 00:00:00           6
##  8 8            3          4 2015-01-10 00:00:00           6
##  9 9            3          5 2015-01-10 00:00:00           6
## 10 10           4          1 2015-01-11 00:00:00          22
## # … with 15,634 more rows, and 10 more variables:
## #   product.id <dbl>, quantity <dbl>, model <chr>,
## #   model.year <dbl>, frame.material <chr>, weight <dbl>,
## #   price <dbl>, category <chr>, gender <chr>, url <chr>

# Chaining commands with the pipe and assigning it to order_items_joined_tbl
bike_orderlines_joined_tbl <- orderlines_tbl %>%
  left_join(bikes_tbl, by = c("product.id" = "bike.id")) %>%
  left_join(bikeshops_tbl, by = c("customer.id" = "bikeshop.id"))

# Examine the results with glimpse()
bike_orderlines_joined_tbl %>% glimpse()
## Rows: 15,644
## Columns: 19
## $ ...1           <chr> "1", "2", "3", "4", "5", "6", "7", …
## $ order.id       <dbl> 1, 1, 2, 2, 3, 3, 3, 3, 3, 4, 5, 5,…
## $ order.line     <dbl> 1, 2, 1, 2, 1, 2, 3, 4, 5, 1, 1, 2,…
## $ order.date     <dttm> 2015-01-07, 2015-01-07, 2015-01-10…
## $ customer.id    <dbl> 2, 2, 10, 10, 6, 6, 6, 6, 6, 22, 8,…
## $ product.id     <dbl> 2681, 2411, 2629, 2137, 2367, 1973,…
## $ quantity       <dbl> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2,…
## $ model          <chr> "Spectral CF 7 WMN", "Ultimate CF S…
## $ model.year     <dbl> 2021, 2020, 2021, 2019, 2020, 2020,…
## $ frame.material <chr> "carbon", "carbon", "carbon", "carb…
## $ weight         <dbl> 13.80, 7.44, 14.06, 8.80, 11.50, 8.…
## $ price          <dbl> 3119, 5359, 2729, 1749, 1219, 1359,…
## $ category       <chr> "Mountain - Trail - Spectral", "Roa…
## $ gender         <chr> "female", "unisex", "unisex", "unis…
## $ url            <chr> "https://www.canyon.com/en-de/mount…
## $ name           <chr> "AlexandeRad", "AlexandeRad", "WITT…
## $ location       <chr> "Hamburg, Hamburg", "Hamburg, Hambu…
## $ lat            <dbl> 53.57532, 53.57532, 53.07379, 53.07…
## $ lng            <dbl> 10.015340, 10.015340, 8.826754, 8.8…

# 5.0 Wrangling Data ----
# bike_orderlines_wrangled_tbl <- bike_orderlines_joined_tbl %>%
#   separate(col    = location,
#            into   = c("city", "state"),
#            sep    = ", ")
# 
# glimpse(bike_orderlines_wrangled_tbl)


# All actions are chained with the pipe already. You can perform each step separately and use glimpse() or View() to validate your code. Store the result in a variable at the end of the steps.
bike_orderlines_wrangled_tbl <- bike_orderlines_joined_tbl %>%
  # 5.1 Separate category name
  separate(col    = category,
           into   = c("category.1", "category.2", "category.3"),
           sep    = " - ") %>%
  
  # 5.2 Add the total price (price * quantity) 
  # Add a column to a tibble that uses a formula-style calculation of other columns
  mutate(total.price = price * quantity) %>%
  
  # 5.3 Optional: Reorganize. Using select to grab or remove unnecessary columns
  # 5.3.1 by exact column name
  select(-...1, -gender) %>%
  
  # 5.3.2 by a pattern
  # You can use the select_helpers to define patterns. 
  # Type ?ends_with and click on Select helpers in the documentation
  select(-ends_with(".id")) %>%
  
  # 5.3.3 Actually we need the column "order.id". Let's bind it back to the data
  bind_cols(bike_orderlines_joined_tbl %>% select(order.id)) %>% 
  
  # 5.3.4 You can reorder the data by selecting the columns in your desired order.
  # You can use select_helpers like contains() or everything()
  select(order.id, contains("order"), contains("model"), contains("category"),
         price, quantity, total.price,
         everything()) %>%
  
  # 5.4 Rename columns because we actually wanted underscores instead of the dots
  # (one at the time vs. multiple at once)
  rename(bikeshop = name) %>%
  set_names(names(.) %>% str_replace_all("\\.", "_"))



# 6.0 Business Insights ----
# 6.1 Sales by Year ----

library(lubridate)
# Step 1 - Manipulate
sales_by_year_tbl <- bike_orderlines_wrangled_tbl %>%
  
  # Select columns
  select(order_date, total_price) %>%
  
  # Add year column
  mutate(year = year(order_date)) %>%
  
  # Grouping by year and summarizing sales
  group_by(year) %>% 
  summarize(sales = sum(total_price)) %>%
  
  # Optional: Add a column that turns the numbers into a currency format 
  # (makes it in the plot optically more appealing)
  # mutate(sales_text = scales::dollar(sales)) <- Works for dollar values
  mutate(sales_text = scales::dollar(sales, big.mark = ".", 
                                     decimal.mark = ",", 
                                     prefix = "", 
                                     suffix = " €"))

sales_by_year_tbl
## # A tibble: 5 x 3
##    year    sales sales_text  
##   <dbl>    <dbl> <chr>       
## 1  2015  9930282 9.930.282 € 
## 2  2016 10730507 10.730.507 €
## 3  2017 14510291 14.510.291 €
## 4  2018 12241853 12.241.853 €
## 5  2019 15017875 15.017.875 €


# Step 2 - Visualize
sales_by_year_tbl %>%
  
  # Setup canvas with the columns year (x-axis) and sales (y-axis)
  ggplot(aes(x = year, y = sales)) +
  
  # Geometries
  geom_col(fill = "#2DC6D6") + # Use geom_col for a bar plot
  geom_label(aes(label = sales_text)) + # Adding labels to the bars
  geom_smooth(method = "lm", se = FALSE) + # Adding a trendline
  
  # Formatting
  # scale_y_continuous(labels = scales::dollar) + # Change the y-axis. 
  # Again, we have to adjust it for euro values
  scale_y_continuous(labels = scales::dollar_format(big.mark = ".", 
                                                    decimal.mark = ",", 
                                                    prefix = "", 
                                                    suffix = " €")) +
  labs(
    title    = "Revenue by year",
    subtitle = "Upward Trend",
    x = "", # Override defaults for x and y
    y = "Revenue"
  )

# 6.2 Sales by Year and Category ----
# Step 1 - Manipulate
sales_by_year_cat_1_tbl <- bike_orderlines_wrangled_tbl %>%
  
  # Select columns and add a year
  select(order_date, total_price, category_1) %>%
  mutate(year = year(order_date)) %>%
  
  # Group by and summarize year and main catgegory
  group_by(year, category_1) %>%
  summarise(sales = sum(total_price)) %>%
  ungroup() %>%
  
  # Format $ Text
  mutate(sales_text = scales::dollar(sales, big.mark = ".", 
                                     decimal.mark = ",", 
                                     prefix = "", 
                                     suffix = " €"))

sales_by_year_cat_1_tbl  
## # A tibble: 25 x 4
##     year category_1      sales sales_text 
##    <dbl> <chr>           <dbl> <chr>      
##  1  2015 E-Bikes       1599048 1.599.048 €
##  2  2015 Gravel         663025 663.025 €  
##  3  2015 Hybrid / City  502512 502.512 €  
##  4  2015 Mountain      3254289 3.254.289 €
##  5  2015 Road          3911408 3.911.408 €
##  6  2016 E-Bikes       1916469 1.916.469 €
##  7  2016 Gravel         768794 768.794 €  
##  8  2016 Hybrid / City  512346 512.346 €  
##  9  2016 Mountain      3288733 3.288.733 €
## 10  2016 Road          4244165 4.244.165 €
## # … with 15 more rows

# Step 2 - Visualize
sales_by_year_cat_1_tbl %>%
  
  # Set up x, y, fill
  ggplot(aes(x = year, y = sales, fill = category_1)) +
  
  # Geometries
  geom_col() + # Run up to here to get a stacked bar plot
  
  # Facet
  facet_wrap(~ category_1) +
  
  # Formatting
  scale_y_continuous(labels = scales::dollar_format(big.mark = ".", 
                                                    decimal.mark = ",", 
                                                    prefix = "", 
                                                    suffix = " €")) +
  labs(
    title = "Revenue by year and main category",
    subtitle = "Each product category has an upward trend",
    fill = "Main category" # Changes the legend name
  )


# 7.0 Writing Files ----

# 7.1 Excel ----
install.packages("writexl")
library("writexl")
write_xlsx(bike_orderlines_wrangled_tbl, "00_data/01_bike_sales/02_wrangled_data/bike_orderlines.xlsx")

# 7.2 CSV ----
bike_orderlines_wrangled_tbl %>% write_csv("00_data/01_bike_sales/02_wrangled_data/bike_orderlines.csv")

# 7.3 RDS ----
bike_orderlines_wrangled_tbl %>% write_rds("00_data/01_bike_sales/02_wrangled_data/bike_orderlines.rds")