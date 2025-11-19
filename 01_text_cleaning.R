# Import 'initial.xlsx'. It contains the following columns:
# 'text': uncleaned text responses combined at the individual level
# 'id': participant id
# 'age': participant age
# 'gender': participant gender (female, male, other)
# 'race': participant ethnicity/race (bipoc, white, other)
# 'nativity': participant nativity status (Yes = born in U.S.; No = not born in U.S.)
# 'profile': profile membership (profile1, profile2, profile3)

initial <- readxl::read_excel("insert_your_pathway_to_file.xlsx")

# Apply correct class types to features
initial$id <- as.factor(initial$id)
initial$profile <- as.factor(initial$profile)
initial$race <- as.factor(initial$race)
initial$gender <- as.factor(initial$gender)
initial$nativity <- as.factor(initial$nativity)
initial$age <- as.numeric(initial$age)
initial$text <- as.character(initial$text)

# Confirm column types are correctly assigned to features
str(initial)

# Extract initial$id and initial$text into separate df named
# 'txt_clean'. All text cleaning will be conducted on 'txt_clean'.
txt_clean <- as.data.frame(dplyr::select(initial, c('id', 'text')))

txt_clean$text <- tolower(txt_clean$text) # lowercase
txt_clean$text <- gsub("[[:punct:]]", "", txt_clean$text) # remove punctuation
txt_clean$text <- gsub("[^A-Za-z0-9 ]", "", txt_clean$text) # remove special characters
txt_clean$text <- trimws(txt_clean$text) # remove leading/trailing white spaces 

# Apply word-level tokenization to 'txt_clean$text'. This will yield a new df
# named 'df_tokens' containing all tokens and corresponding id.
df_tokens <- txt_clean %>% 
    tidytext::unnest_tokens(word, text)  # 'word'= name of new column with tokens

# remove 'txt_clean'
txt_clean <- NULL

# Re-aggregate 'df_tokens' by id into new df named 'df_aggregated'.
# The cleaned text is inserted in 'txt_clean'.
df_aggregated <- df_tokens %>%
  dplyr::group_by(id) %>%
  dplyr::summarise(txt_clean = paste(word, collapse = " "), .groups = "keep")

# Remove 'df_tokens'
df_tokens <- NULL

# Merge 'df_aggregated' with 'initial' by id and name new df 'text_cleaned'
text_cleaned <- merge(df_aggregated, initial, by = "id", all= FALSE)

# Remove 'df_aggregated' and 'initial'
df_aggregated <- NULL
initial <- NULL

# Remove 'text' from 'text_cleaned'
text_cleaned$text <- NULL

# Save 'text_cleaned' as .xlsx file if needed
WriteXLS::WriteXLS(text_cleaned, "text_cleaned.xlsx")
