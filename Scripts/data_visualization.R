# =========================================
# DATA VISUALIZATION IN R (BASE R + GGPLOT2)
# =========================================

# =========================================
# 1️⃣ Load Dataset & Libraries
# =========================================

# Install once if not installed
install.packages("NHANES")
install.packages("ggplot2")

library(NHANES)
library(dplyr)
library(tidyr)
library(ggplot2)

data(NHANES)
df <- NHANES


# =========================================
# 🔹 PART 1: BASE R VISUALIZATION
# (Simple and quick plots)
# =========================================


# -----------------------------------------
# 2️⃣ Histogram (Distribution of Age)
# -----------------------------------------
# Histogram shows distribution of numeric variable
# Helps check skewness and spread

hist(df$Age,
     main = "Histogram of Age",
     xlab = "Age",
     col = "lightblue",
     border = "black")


# -----------------------------------------
# 3️⃣ Boxplot (Outliers & Spread)
# -----------------------------------------
# Shows median, quartiles, and outliers

boxplot(df$Age,
        main = "Boxplot of Age",
        ylab = "Age",
        col = "orange")


# -----------------------------------------
# 4️⃣ Boxplot by Group (BMI by Gender)
# -----------------------------------------
# Compares numeric variable across categories

boxplot(BMI ~ Gender,
        data = df,
        main = "BMI by Gender",
        xlab = "Gender",
        ylab = "BMI",
        col = c("pink", "lightblue"))


# -----------------------------------------
# 5️⃣ Barplot (Categorical Frequency)
# -----------------------------------------
# table() counts categories
# barplot() visualizes counts

age_tab <- table(df$AgeDecade)

barplot(age_tab,
        xlab = "Age Decade",
        ylab = "Frequency",
        main = "Distribution of Age by Decade",
        col = rainbow(length(age_tab)))


# -----------------------------------------
# 6️⃣ Scatter Plot (Relationship between variables)
# -----------------------------------------
# Shows relationship between two numeric variables

plot(df$Age, df$BMI,
     main = "Age vs BMI",
     xlab = "Age",
     ylab = "BMI",
     col = "darkgreen",
     pch = 16)


# =========================================
# 🔹 PART 2: GGPLOT2 VISUALIZATION
# (Modern & professional plotting system)
# =========================================

# ggplot structure:
# ggplot(data, aes(mapping)) + geom_*()


# -----------------------------------------
# 7️⃣ Histogram using ggplot2
# -----------------------------------------
# aes() → aesthetic mapping
# geom_histogram() → plot type

ggplot(df, aes(x = BMI)) +
  geom_histogram(bins = 30,
                 fill = "skyblue",
                 color = "black") +
  labs(title = "Histogram of BMI",
       x = "BMI",
       y = "Frequency")


# -----------------------------------------
# 8️⃣ Boxplot using ggplot2
# -----------------------------------------
# fill adds color by group

ggplot(df, aes(x = Gender, y = BMI, fill = Gender)) +
  geom_boxplot() +
  labs(title = "BMI by Gender",
       x = "Gender",
       y = "BMI")


# -----------------------------------------
# 9️⃣ Bar Chart using ggplot2
# -----------------------------------------
# geom_bar() automatically counts frequencies

ggplot(df, aes(x = Gender, fill = Gender)) +
  geom_bar() +
  labs(title = "Gender Distribution",
       x = "Gender",
       y = "Frequency") +
  theme_classic()


# -----------------------------------------
# 🔟 Scatter Plot using ggplot2
# -----------------------------------------
# geom_point() creates scatter plot

ggplot(df, aes(x = Age, y = BMI)) +
  geom_point(alpha = 0.5) +
  labs(title = "Age vs BMI",
       x = "Age",
       y = "BMI")


# =========================================
# SUMMARY (THEORY)
# =========================================

# Base R → Quick basic visualization
# ggplot2 → Layer-based, professional visualization

# ggplot components:
# 1. Data
# 2. aes() → variable mapping
# 3. geom_*() → type of plot
# 4. labs() → labels
# 5. theme_*() → style
