# Import 'final_feature_set.xlsx' if needed 
final_feature_set <- readxl::read_excel("insert_your_pathway_to_file.xlsx")

# Remove 'id', 'txt_clean', and rows with missing data
final_feature_set <- final_feature_set %>% dplyr::select(-id, -txt_clean)
final_feature_set <- final_feature_set[complete.cases(final_feature_set), ]

# Apply correct variable types to features
final_feature_set$profile <- as.factor(final_feature_set$profile)
final_feature_set$race <- as.factor(final_feature_set$race)
final_feature_set$gender <- as.factor(final_feature_set$gender)
final_feature_set$nativity <- as.factor(final_feature_set$nativity)
final_feature_set[, 5:29] <- lapply(final_feature_set[, 5:29], as.numeric) 

# Confirm feature types are correctly assigned
str(final_feature_set)

# Randomly split 'final_feature_set' into a training set (80%) and testing set (20%)
set.seed(123)
split <- sample(c(TRUE, FALSE), nrow(final_feature_set), 
                replace = TRUE, prob = c(0.8, 0.2))

# Create training set df named 'train_set'
train_set <- final_feature_set[split, ]

# Create test set df named 'test_set'
test_set <- final_feature_set[!split, ]

# Remove 'final_feature_set'
final_feature_set <- NULL

# Define outcome variable
outcome_var <- "profile"

# Remove 'profile' column to generate feature-only dfs: 'train_x' and 'test_x'
train_x <- train_set[, !(names(train_set) %in% outcome_var)]
test_x  <- test_set[,  !(names(test_set)  %in% outcome_var)]

# Apply one-hot encoding to categorical features in 'train_x'
dummies <- caret::dummyVars(~ ., data = train_x)
train_x <- as.data.frame(stats::predict(dummies, newdata = train_x))

# Apply same one-hot encoding framework from 'train_x' ('dummies') to 'test_x'
test_x  <- as.data.frame(stats::predict(dummies, newdata = test_x))

# This adds 8 new binary features to 'train_x' and 'test_x':
# 'race.bipoc'
# 'race.other'
# 'race.white'
# 'gender.female'
# 'gender.male'
# 'gender.other'
# 'nativity.No'
# 'nativity.Yes'

# Remove 'dummies'
dummies <- NULL

# Standardize numeric features in 'train_x' (excluding one-hot encoded features)
preproc <- caret::preProcess(train_x[, 9:33], method = c("center", "scale"))
train_x[, 9:33] <- stats::predict(preproc, train_x[, 9:33])

# Add 'profile' back into 'train_x' and name it 'train_set_final'
train_set_final <- data.frame(train_x, profile = train_set[[outcome_var]])

# Remove 'train_set' and 'train_x'
train_set <- NULL
train_x <- NULL

# Apply same standardization framework from 'train_x' ('preproc') to 'test_x'
test_x[, 9:33] <- stats::predict(preproc, test_x[, 9:33])

# Add 'profile' back into 'test_x' and name it 'test_set_final'
test_set_final  <- data.frame(test_x,  profile = test_set[[outcome_var]])

# Remove 'test_set', 'test_x', and 'preproc'
test_set <- NULL
test_x <- NULL
preproc <- NULL

# Save 'train_set_final' and 'test_set_final' as .xlsx files if needed
WriteXLS::WriteXLS(train_set_final, "insert_file_pathway/train_set_final.xlsx")
WriteXLS::WriteXLS(test_set_final, "insert_file_pathway/test_set_final.xlsx")

