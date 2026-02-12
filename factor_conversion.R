# =========================================
# 1️⃣ Recode Gender Values
# =========================================

library(dplyr)

# Using case_when() → male/female to M/F
df <- df %>%
  mutate(
    Gender = case_when(
      Gender == "male"   ~ "M",
      Gender == "female" ~ "F",
      TRUE ~ as.character(Gender)
    )
  )

# Using if_else()
df <- df %>%
  mutate(
    Gender = if_else(Gender == "male", "M", "F")
  )

# Using recode() (clean method)
df <- df %>%
  mutate(
    Gender = recode(Gender,
                    "male"   = "M",
                    "female" = "F")
  )


# =========================================
# 2️⃣ Convert Gender to Factor
# =========================================

# dplyr
df <- df %>%
  mutate(Gender = factor(Gender))

# Base R
df$Gender <- factor(df$Gender)


# =========================================
# 3️⃣ Set Specific Factor Levels (Order)
# =========================================

# dplyr
df <- df %>%
  mutate(
    Gender = factor(Gender, levels = c("M", "F"))
  )

# Base R
df$Gender <- factor(df$Gender, levels = c("M", "F"))


# =========================================
# 4️⃣ Factor with Numeric Levels and Labels
# =========================================

# dplyr
df <- df %>%
  mutate(
    Gender = factor(Gender,
                    levels = c(1, 2),
                    labels = c("Male", "Female"))
  )

# Base R
df$Gender <- factor(df$Gender,
                    levels = c(1, 2),
                    labels = c("Male", "Female"))


# =========================================
# 5️⃣ Convert Multiple Columns to Factor
# =========================================

# dplyr
df <- df %>%
  mutate(across(c(Gender, Status, Category), factor))

# Base R (manual)
df$Gender   <- factor(df$Gender)
df$Status   <- factor(df$Status)
df$Category <- factor(df$Category)

# Base R using lapply()
df[c("Gender", "Status", "Category")] <-
  lapply(df[c("Gender", "Status", "Category")], factor)


# =========================================
# 6️⃣ Convert All Character Columns to Factor
# =========================================

# dplyr
df <- df %>%
  mutate(across(where(is.character), factor))

# Base R
df[sapply(df, is.character)] <-
  lapply(df[sapply(df, is.character)], factor)


# =========================================
# 7️⃣ Count Numeric Variables
# =========================================

# dplyr
df %>%
  summarise(n_numeric = sum(sapply(., is.numeric)))

# Base R
sum(sapply(df, is.numeric))


# =========================================
# 8️⃣ Check Class After Changes
# =========================================

class(df$Gender)
str(df$Gender)
table(df$Gender)

