# =========================================
# 1️⃣ Load NHANES Dataset
# =========================================

install.packages("NHANES")   # Run once if not installed
library(NHANES)
data(NHANES)

df <- NHANES
df


# =========================================
# 2️⃣ Check Dimensions (Rows & Columns)
# =========================================

dim(df)


# =========================================
# 3️⃣ View Dataset
# =========================================

View(df)        # Table view
head(df)        # First 6 rows
tail(df)        # Last 6 rows


# =========================================
# 4️⃣ Column Names & Structure
# =========================================

colnames(df)
names(df)

str(df)

sapply(df, class)


# =========================================
# 5️⃣ Summary Statistics
# =========================================

summary(df)     # 5-number summary + missing info


# =========================================
# 6️⃣ Missing Value Checks
# =========================================

sum(is.na(df$ID))                 # Missing in specific column
any(is.na(df$AgeDecade))          # TRUE/FALSE check
colSums(is.na(df))                # Missing per column


# =========================================
# 7️⃣ Variable Type Checking
# =========================================

is.numeric(df)            # Logical vector for numeric check
class(df$Age)             # Class of specific variable

sapply(df, is.numeric)
sapply(df, is.factor)


# =========================================
# 8️⃣ Unique & NA Count Using sapply()
# =========================================

sapply(df, function(x) sum(is.na(x)))
sapply(df, function(x) length(unique(x)))

length(unique(df$ID))


# =========================================
# 9️⃣ Separate Numeric & Categorical Variables
# =========================================

numerical_var <- sapply(df, is.numeric)
categorical_var <- sapply(df, is.factor)

numerical_var
categorical_var


# =========================================
# 🔟 Apply Functions Only to Numeric Variables
# =========================================

sapply(df[, numerical_var], function(x) sum(is.na(x)))
sapply(df[, numerical_var], mean, na.rm = TRUE)
sapply(df[, numerical_var], max, na.rm = TRUE)
sapply(df[, numerical_var], range, na.rm = TRUE)


# =========================================
# 1️⃣1️⃣ Mean & SD Together (Important Concept)
# =========================================

sapply(df[, numerical_var], function(x)
  c(mean = mean(x, na.rm = TRUE),
    sd   = sd(x, na.rm = TRUE))
)


# =========================================
# 1️⃣2️⃣ Proportions & Percentages
# =========================================

prop.table(table(df$Gender)) * 100
prop.table(table(df$AgeDecade)) * 100


# =========================================
# 1️⃣3️⃣ Structure of Specific Variable
# =========================================

str(df$AgeDecade)


# =========================================
# 1️⃣4️⃣ Help / Documentation
# =========================================

?NHANES
