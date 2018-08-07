# demo script for R Users Group (October 6, 2014)
# Hao Ye
# file operations and regular expressions

# clear current workspace
rm(list = ls())

# set working directory
setwd("~/Desktop/line_p_nutrients/")
file_names <- list.files()

# try loading all files
nutrient_data <- lapply(file_names, function(curr_file) {
    temp <- read.csv(curr_file)
    return(temp)
})

# isolate error using cat
nutrient_data <- lapply(file_names, function(curr_file) {
    cat("now trying to read ", curr_file, "...\n")
    temp <- read.csv(curr_file)
    return(temp)
})

# check first line of every file
lapply(file_names, function(curr_file) {
    readLines(curr_file, n = 1)
})

# now skip initial header line
nutrient_data <- lapply(file_names, function(curr_file) {
    cat("now trying to read ", curr_file, "...\n")
    temp <- read.csv(curr_file, skip = 1)
    return(temp)
})

# filter csv files using grep and regular expressions
# common regular expression expressions (see ?regex)
# '[]' - matches any character contained within the brackets
grep("[0123]", c("abc2", "3210", "abcd", "abcde00abcde"), value = TRUE)

# '[^abc]' - matches anything except a, b, or c
grep("[^abc]", c("abc2", "3210", "abcd", "abcde00abcde", "aaaaa"), value = TRUE)

# '^a' - matches a only at the beginning of the string
grep("^a", c("abc2", "3210", "abcd", "abcde00abcde", "aaaaa"), value = TRUE)

# 'a$' - matches a only at the end of the string
grep("a$", c("abc2", "3210", "abcd", "abcde00abcde", "aaaaa"), value = TRUE)

# '?' - matches preceding item 0 or 1 times
# '*' - matches preceding item 0 or more times
# '+' - matches preceding item 1 or more times
# '{n}' - matches preceding item exactly n times
# '{n,}' - matches preceding item n or more times
# '{n,m}' - matches preceding item at least n times, but not more than m times
grep("ac*b", c("ab", "accccccb", "adb"), value = TRUE)


grep("[abcde]{2,4}", c("abc2", "3210", "abcd", "abcde00abcde", "aaaaa", "a"), value = TRUE)

# '[0-9]' - matches numerical digits
grep("[0-9]", c("abc2", "3210", "abcd", "abcde00abcde", "aaaaa"), value = TRUE)

# '[a-z]' - matches lowercase letters
grep("[a-z]", c("abc2", "3210", "abcd", "abcde00abcde", "aaaaa"), value = TRUE)

# '[A-Z]' - matches uppercase letters
grep("[A-Z]", c("abc2", "3210", "abcd", "abcde00abcde", "aaaaa"), value = TRUE)

# '.' - matches any character
grep(".{4,10}", c("abc2", "3210", "abcd", "abcde00abcde", "aaaaa", "a"), value = TRUE)

# '|' - matches either substring
grep("abc|cde", c("abc2", "3210", "abcd", "abcde00abcde", "aaaaa"), value = TRUE)

# '()' - groups subexpressions: get files from 1998 to 2002
grep("^18DD(199[89]|200[012]).*csv$", file_names, value = TRUE)

# but I just want all the csv files
csv_files <- grep("csv$", file_names, value = TRUE)

# try loading again
nutrient_data <- lapply(csv_files, function(curr_file) {
    cat("now trying to read ", curr_file, "...\n")
    temp <- read.csv(curr_file, skip = 1)
    return(temp)
})

# add "#" as comment character
nutrient_data <- lapply(csv_files, function(curr_file) {
    cat("now trying to read ", curr_file, "...\n")
    temp <- read.csv(curr_file, skip = 1, comment.char = "#")
    return(temp)
})

# try and combine data
nutrient_df <- do.call(rbind, nutrient_data)

# use rbind.fill from plyr package
library(plyr)
nutrient_df <- do.call(rbind.fill, nutrient_data)
