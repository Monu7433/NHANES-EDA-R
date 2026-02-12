# =========================================
# 1️⃣ Load Libraries
# =========================================
library(dplyr)
library(tidyr)

# =========================================
# 2️⃣ Basic Data Inspection
# =========================================
glimpse(df)
df
dim(df)

# =========================================
# 3️⃣ Missing Value Analysis (Base R)
# =========================================

# Total missing values
sum(is.na(df))

# Missing values per column
sapply(df, function(x) sum(is.na(x)))

# Remove NA rows (Base R)
df_clean_base <- na.omit(df)
df_clean_base

# =========================================
# 4️⃣ Missing Value Analysis (dplyr)
# =========================================

# Missing per variable
df %>%
  summarise(across(everything(), ~sum(is.na(.))))

# Missing percentage per variable
df %>%
  summarise(across(everything(), ~mean(is.na(.)) * 100))

# Remove rows with any NA
df_complete <- df %>%
  drop_na()

# Remove NA only for specific column
df_no_BMI_NA <- df %>%
  drop_na(BMI)

# Remove NA only for numeric variables
df_no_numeric_NA <- df %>%
  drop_na(where(is.numeric))

# =========================================
# 5️⃣ Replace Missing Values
# =========================================

# Replace BMI NA with mean (dplyr)
df <- df %>%
  mutate(
    BMI = if_else(
      is.na(BMI),
      mean(BMI, na.rm = TRUE),
      BMI
    )
  )

# Replace BMI NA with mean (Base R)
df$BMI[is.na(df$BMI)] <- mean(df$BMI, na.rm = TRUE)

# =========================================
# 6️⃣ Variable Selection
# =========================================

# Select numeric variables
df %>%
  select(where(is.numeric))

# =========================================
# 7️⃣ Descriptive Statistics
# =========================================

# Mean of numeric variables
df %>%
  summarise(across(where(is.numeric), mean, na.rm = TRUE))

# Mean and SD of numeric variables
df %>%
  summarise(across(
    where(is.numeric),
    list(
      mean = ~mean(.x, na.rm = TRUE),
      sd   = ~sd(.x, na.rm = TRUE)
    )
  ))
# for Specific one 
df %>%
  summarise(
    Age_mean = mean(Age, na.rm = TRUE),
    Age_sd = sd(Age, na.rm = TRUE),
    BMI_mean = mean(BMI, na.rm = TRUE),
    BMI_sd = sd(BMI, na.rm = TRUE)
  )
# =========================================
# 8️⃣ Grouped Summary
# =========================================

# Mean and SD of BMI by Gender
df %>%
  group_by(Gender) %>%
  summarise(
    mean_BMI = mean(BMI, na.rm = TRUE),
    sd_BMI   = sd(BMI, na.rm = TRUE),
    n = n()
  )

# =========================================
# 9️⃣ Crosstab / Frequency
# =========================================

# Frequency table
df %>%
  count(Gender)

# Cross-tab Education × Gender
df %>%
  count(Education, Gender)

# Row percentage
df %>%
  count(Gender, Education) %>%
  group_by(Gender) %>%
  mutate(percent = n / sum(n) * 100)

# =========================================
# 🔟 Create New Variable (Obesity)
# =========================================

df <- df %>%
  mutate(
    Obesity = if_else(BMI >= 30, "Obese", "Non-Obese")
  )
df
# Obesity prevalence
df %>%
  count(Obesity) %>%
  mutate(percent = n / sum(n) * 100)

# Obesity prevalence by Gender
df %>%
  count(Gender, Obesity) %>%
  group_by(Gender) %>%
  mutate(percent = n / sum(n) * 100)

# =========================================
# Important Concepts
# =========================================
# summarise() → create summary output
# across() → apply function to multiple columns
# group_by() → grouped analysis
# mutate() → create or modify variables
# count() → frequency table
# drop_na() → remove missing rows
# if_else() → conditional variable creation


df%>%
  filter(BMI>30 & Age>50)%>%nrow

df%>%
  filter(Gender=="Female"&BMI>30)%>%  summarise(mean_age = mean(Age, na.rm = TRUE))

