# =========================================
# Load Library
# =========================================
library(dplyr)

# =========================================
# 1️⃣ Replace BMI < 10 with NA
# =========================================
df <- df %>%
  mutate(
    BMI = if_else(BMI < 10, NA_real_, BMI)
  )

# =========================================
# 2️⃣ Replace BMI == 999 with NA
# =========================================
df <- df %>%
  mutate(
    BMI = if_else(BMI == 999, NA_real_, BMI)
  )

# =========================================
# 3️⃣ Replace BMI < 10 OR BMI > 60 with NA
# =========================================
df <- df %>%
  mutate(
    BMI = if_else(BMI < 10 | BMI > 60, NA_real_, BMI)
  )

# =========================================
# 4️⃣ Replace Gender "female" with "F"
# =========================================
df <- df %>%
  mutate(
    Gender = if_else(Gender == "female", "F", Gender)
  )

# =========================================
# 5️⃣ Replace Missing BMI with Mean
# =========================================
df <- df %>%
  mutate(
    BMI = if_else(
      is.na(BMI),
      mean(BMI, na.rm = TRUE),
      BMI
    )
  )

# =========================================
# 6️⃣ Create BMI Category (Multiple Conditions)
# =========================================
df <- df %>%
  mutate(
    BMI_Category = case_when(
      BMI < 18.5 ~ "Underweight",
      BMI < 25   ~ "Normal",
      BMI < 30   ~ "Overweight",
      BMI >= 30  ~ "Obese"
    )
  )

# =========================================
# 7️⃣ Using replace() inside mutate()
# =========================================
df <- df %>%
  mutate(
    BMI = replace(BMI, BMI < 10, NA_real_)
  )

# =========================================
# Check Results
# =========================================
summary(df$BMI)
table(df$BMI_Category)




# =========================================
# replace_na() – Used ONLY to replace NA values
# Comes from tidyr package
# Cleaner and preferred for missing value handling
# =========================================

library(dplyr)
library(tidyr)

# -----------------------------------------
# 1️⃣ Replace NA in single numeric column (BMI)
# -----------------------------------------
df <- df %>%
  mutate(
    BMI = replace_na(BMI, mean(BMI, na.rm = TRUE))
  )

# Check
sum(is.na(df$BMI))


# -----------------------------------------
# 2️⃣ Replace NA in single numeric column (Age) with median
# -----------------------------------------
df <- df %>%
  mutate(
    Age = replace_na(Age, median(Age, na.rm = TRUE))
  )

# Check
sum(is.na(df$Age))


# -----------------------------------------
# 3️⃣ Replace NA in categorical column (Gender)
# -----------------------------------------
df <- df %>%
  mutate(
    Gender = replace_na(Gender, "Unknown")
  )

# Check
sum(is.na(df$Gender))


# -----------------------------------------
# 4️⃣ Replace NA in multiple columns at once
# -----------------------------------------
df <- df %>%
  replace_na(list(
    BMI = 0,
    Age = 0
  ))

# =========================================
# SHORT THEORY
# =========================================
# replace_na():
# - Used only for missing values (NA)
# - Cleaner than if_else() for NA handling
# - Works well inside tidyverse workflow
# - Syntax: replace_na(column, value)
