#Author : Pratik Ganguli

# Loading packages upfront ----

## Package for Visualisation
if (!require("ggplot2")) install.packages("ggplot2")
library(ggplot2)

## Package for generating multiple scatterplots
if (!require("GGally")) install.packages("GGally")
library(GGally)
if (!require("tidyverse")) install.packages("tidyverse")
library(tidyverse)
if (!require("corrplot")) install.packages("corrplot")
library(corrplot)
#to read excel' file (load only if excel file is provided)
if(! require("readxl"))nstall.packages("readxl")
library(readxl)

## Package for Association Rules
if (!require("arules")) install.packages("arules")
library(arules)

if (!require("arulesViz")) install.packages("arulesViz")
library(arulesViz)


#Reading netflix csv 
netflix_tudum = read_xlsx("most-popular_global_weekly.xlsx")
head(netflix_tudum)

#Reading imbd fiel
imbd = read_csv("imdb-movies-dataset.csv")
imbd

#Removing unrequired columns
tudum_filter = select(netflix_tudum, -season_title,-country_iso2)
imbd_filter = select(imbd,-Poster,-Metascore,-Director,-Cast,-Votes,-Description,-Review)

head(tudum_filter)
head(imbd_filter)


#defining fuction for categorizing movie rating in 4 categories
categorize_age <- function(cert) {
  cert <- toupper(trimws(cert))  # normalize casing & spacing
  
  if (cert %in% c("G", "PG", "U", "ALL", "APPROVED", "U/A", "UA", "UA 7+", "7")) {
    return("Kids")
  } else if (cert %in% c("PG-13", "UA 13+", "13", "12", "12+", "15+", "UA 16+", "16", "16+", "M/PG")) {
    return("Teens")
  } else if (cert %in% c("R", "A", "18", "18+", "NC-17", "X")) {
    return("Adults")
  } else if (cert %in% c("NOT RATED", "UNRATED", "GP", "(BANNED)")) {
    return("Older")
  } else {
    return("Older")  
  }
}


# Apply it to your dataset
imbd_filter <- imbd_filter %>%
  mutate(Age_Rating = sapply(Certificate, categorize_age))


#Removing unwanted columns
imbd_filter = imbd_filter |> select(-`Duration (min)`, -`Review Count`, -`Review Title`, -Year,-Certificate) |> na.omit()
imbd_filter

#Renaming the column
tudum_filter <- tudum_filter%>%
  rename(Title = show_title)

#Joining both the datraset by title
df = tudum_filter |> inner_join(imbd_filter, by='Title')
df

#Removing null values
df = df|> na.omit()

#categorizing country into four regions
df$region <- case_when(
  df$country_name %in% c("United States", "Canada") ~ "U.S.A. and Canada",
  df$country_name %in% c("Argentina", "Bahamas", "Bolivia", "Brazil", "Chile", "Colombia",
                         "Costa Rica", "Dominican Republic", "Ecuador", "El Salvador", "Guatemala",
                         "Honduras", "Jamaica", "Mexico", "Panama", "Paraguay", "Peru", "Uruguay", "Venezuela") ~ "Latin America",
  df$country_name %in% c("Austria", "Belgium", "Bulgaria", "Croatia", "Cyprus", "Czech Republic",
                         "Denmark", "Estonia", "Finland", "France", "Germany", "Greece", "Hungary",
                         "Iceland", "Ireland", "Israel", "Italy", "Latvia", "Lebanon", "Lithuania", "Luxembourg",
                         "Malta", "Netherlands", "Norway", "Poland", "Portugal", "Romania", "Saudi Arabia",
                         "Slovakia", "Slovenia", "South Africa", "Spain", "Sweden", "Switzerland", "Turkey",
                         "Ukraine", "United Arab Emirates", "United Kingdom", "Egypt", "Jordan", "Kenya",
                         "Kuwait", "Bahrain", "Qatar") ~ "Europe, the Middle East, and Africa",
  df$country_name %in% c("Australia", "Bangladesh", "Hong Kong", "India", "Indonesia", "Japan",
                         "Malaysia", "Maldives", "New Zealand", "Pakistan", "Philippines", "Singapore",
                         "South Korea", "Sri Lanka", "Taiwan", "Thailand", "Vietnam") ~ "Asia Pacific",
  TRUE ~ "UNKNOWN"
)

#Changing theformat and type for date
df$date <- as.Date(df$week, format = "%Y-%m-%d")  # e.g., "03-Apr-22"

#Extracting year
df$year <- format(df$date, "%Y")

#Making transaction id based on region and date
df$txn_id <- paste(df$region, df$date, sep = "_")


#Group genres per transaction
grouped <- df %>%
  group_by(region, year, txn_id) %>%
  summarise(genres = list(Genre), .groups = "drop")
grouped

#Generate Apriori rules per country-year
rules_output <- data.frame()
unique_keys <- unique(grouped[c("region", "year")])
unique_keys

# Loop through each row in unique_keys to process rules for every region-year combination
for (k in 1:nrow(unique_keys)) {
  region <- unique_keys$region[k]  #Extract region name
  year <- unique_keys$year[k] # Extract year
  
  # Filter grouped dataset for the current region and year
  sub_group <- grouped %>%
    filter(region == region, year == year)
  
  if (nrow(sub_group) < 2) next  # Need at least 2 transactions
  
  # Convert genre data to transaction format for Apriori algorithm
  txn <- as(sub_group$genres, "transactions")
  
  # Generate association rules with defined support, confidence, and minimum rule length
  rules <- apriori(txn, parameter = list(supp = 0.10, conf = 0.33, minlen = 2))
  
  if (length(rules) > 0) {
    # Extract left-hand side and right-hand side of rules as strings
    lhs <- labels(lhs(rules))
    rhs <- labels(rhs(rules))
    
    # Create readable rule strings using → instead of => and square brackets
    rule_strings <- paste0(
      gsub("\\{", "[", gsub("\\}", "]", lhs)),
      " → ",
      gsub("\\{", "[", gsub("\\}", "]", rhs))
    )
    
    # Clean up brackets for comparison
    lhs_clean <- gsub("[\\[\\]]", "", lhs)
    rhs_clean <- gsub("[\\[\\]]", "", rhs)
    
    #Keep only rules where lhs is lexicographically less than rhs to avoid duplicates
    keep_indices <- which(lhs_clean < rhs_clean)
    
    if (length(keep_indices) > 0) {
      # Build a temporary dataframe with relevant rule information
      temp_df <- data.frame(
        region = region,
        year = year,
        rule = rule_strings[keep_indices],
        support = quality(rules)$support[keep_indices],
        confidence = quality(rules)$confidence[keep_indices],
        lift = quality(rules)$lift[keep_indices],
        stringsAsFactors = FALSE
      )
      # Append to the final rules output dataframe
      rules_output <- bind_rows(rules_output, temp_df)
    }
  }
}

# Inspecting the complete rules output
print(rules_output)
print(tail(rules_output))
print(rules_output[50:60,])

# Convert rules_output to a dataframe (redundant if already a dataframe)
rules_df <- as(rules_output, "data.frame")

# Extract top 5 rules with highest lift per region and year
top5_lift <- rules_df %>%
  group_by(country, month) %>%
  arrange(desc(lift)) %>%
  slice_head(n = 5) %>%
  ungroup()

# Display and save top 5 lift rules
print(top5_lift)
# Save all extracted rules to CSV
write.csv(top5_lift, "rules_apriori_top5.csv", row.names = FALSE)
