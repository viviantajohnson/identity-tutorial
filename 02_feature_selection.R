# Import 'initial_feature_set.xlsx'
initial_feature_set <- readxl::read_excel("insert_your_pathway_to_file.xlsx")

# Remove 'Segment' column from 'initial_feature_set' since it is not needed
initial_feature_set$Segment <- NULL

# Apply correct variable types to features
initial_feature_set$profile <- as.factor(initial_feature_set$profile)
initial_feature_set$id <- as.factor(initial_feature_set$id)
initial_feature_set$race <- as.factor(initial_feature_set$race)
initial_feature_set$gender <- as.factor(initial_feature_set$gender)
initial_feature_set$nativity <- as.factor(initial_feature_set$nativity)
initial_feature_set$age <- as.numeric(initial_feature_set$age)
initial_feature_set[, 8:47] <- lapply(initial_feature_set[, 8:47], as.numeric) 

# Confirm feature types are correctly assigned
str(initial_feature_set)

# Check for link between features and profile
# * = significant

data <- as.data.frame(initial_feature_set)
initial_feature_set <- NULL

# Non-linguistic features

# Age
summary(age <- stats::aov(age ~ profile, data = data))

# Race*
tbl_race <- table(initial_feature_set$profile, initial_feature_set$race)
print(race <- stats::chisq.test(tbl_race))

# Gender*
tbl_gender <- table(initial_feature_set$profile, initial_feature_set$gender)
print(gender <- stats::chisq.test(tbl_gender))

# Nativity*
tbl_nativity <- table(initial_feature_set$profile, initial_feature_set$nativity)
print(nativity <- stats::chisq.test(tbl_nativity))


# Linguistic Features

# Positive tone*
summary(tone_pos <- stats::aov(tone_pos ~ profile, data = data))

# Negative tone*
summary(tone_neg <- stats::aov(tone_neg ~ profile, data = data))

# Positive emotion*
summary(emo_pos <- stats::aov(emo_pos ~ profile, data = data))

# Negative emotion*
summary(emo_neg <- stats::aov(emo_neg ~ profile, data = data))

# Social behaviors
summary(socbehav <- stats::aov(socbehav ~ profile, data = data))

# Social referents*
summary(socrefs <- stats::aov(socrefs ~ profile, data = data))

# Cognitive processes*
summary(cogproc <- stats::aov(cogproc ~ profile, data = data))

# Insight*
summary(insight <- stats::aov(insight ~ profile, data = data))

# Causation
summary(cause <- stats::aov(cause ~ profile, data = data))

# Discrepancy*
summary(discrep <- stats::aov(discrep ~ profile, data = data))

# Tentativeness*
summary(tentat <- stats::aov(tentat ~ profile, data = data))

# Certitude*
summary(certitude <- stats::aov(certitude ~ profile, data = data))

# Differentiation*
summary(differ <- stats::aov(differ ~ profile, data = data))

# Psychological drives*
summary(drives <- stats::aov(Drives ~ profile, data = data))

# Affiliation*
summary(affiliation <- stats::aov(affiliation ~ profile, data = data))

# Achievement*
summary(achieve <- stats::aov(achieve ~ profile, data = data))

# Power*
summary(power <- stats::aov(power ~ profile, data = data))

# Time*
summary(time <- stats::aov(time ~ profile, data = data))

# Past-focused
summary(focuspast <- stats::aov(focuspast ~ profile, data = data))

# Present-focused*
summary(focuspresent <- stats::aov(focuspresent ~ profile, data = data))

# Future-focused
summary(focusfuture <- stats::aov(focusfuture ~ profile, data = data))

# Perception
summary(perception <- stats::aov(Perception ~ profile, data = data))

# Attention*
summary(attention <- stats::aov(attention ~ profile, data = data))

# Motion*
summary(motion <- stats::aov(motion ~ profile, data = data))

# Space*
summary(space <- stats::aov(space ~ profile, data = data))

# Visual*
summary(visual <- stats::aov(visual ~ profile, data = data))

# Auditory
summary(auditory <- stats::aov(auditory ~ profile, data = data))

# Feeling
summary(feeling <- stats::aov(feeling ~ profile, data = data))

# Culture
summary(culture <- stats::aov(Culture ~ profile, data = data))

# Ethnicity
summary(ethnicity <- stats::aov(ethnicity ~ profile, data = data))

# Lifestyle*
summary(lifestyle <- stats::aov(Lifestyle ~ profile, data = data))

# Leisure
summary(leisure <- stats::aov(leisure ~ profile, data = data))

# Home
summary(home <- stats::aov(home ~ profile, data = data))

# Work
summary(work <- stats::aov(work ~ profile, data = data))

# Religion
summary(religion <- stats::aov(relig ~ profile, data = data))

# Analytic language*
summary(analytic <- stats::aov(Analytic ~ profile, data = data))

# Clout*
summary(clout <- stats::aov(Clout ~ profile, data = data))

# Authenticity*
summary(authentic <- stats::aov(Authentic ~ profile, data = data))

# Function words
summary(func <- stats::aov(func ~ profile, data = data))

# Word count
summary(wc <- stats::aov(WC ~ profile, data = data))

# Remove nonsignificant features from 'data'
# Save as new df named 'final_feature_set'

final_feature_set <- data %>% 
  dplyr::select(-socbehav, -cause, -focuspast,
                -focusfuture, -Perception, -auditory,
                -feeling, -Culture, -ethnicity,
                -leisure, -home, -work,
                -relig, -func, -WC, -age
  )

# Remove 'data'
data <- NULL

# Save 'final_feature_set' as .xlsx file if needed
WriteXLS::WriteXLS(final_feature_set, "insert_file_pathway/final_feature_set.xlsx")
