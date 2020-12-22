# Timeline graphic using R and ggplot2

library(ggplot2)
library(scales)
library(lubridate)

# input csv
df <- read.csv('~~~~.csv')
df

# add status column for coloring each event 
df$status <- "installed_program"
df <- df[with(df, order(time)), ] 	# could be different for each csv 
head(df)

# define colors for each event 
status_levels <- c("timeline", "installed_program", "search_terms")
status_clors <- c("#0070C0", "#00B050", "#C00000")

df$status <- factor(df$status, levels=status_levels, ordered=TRUE)

# assign the lines and heights for milestones with same minute to be the same

positions <- c(0.5, -0.5, 1.0, -1.0, 1.5, -1.5)
directions <- c(1,-1)

line_pos <- data.frame(
	"time" = uniqued(df$time))	# could be different for each csv 
	"position" = rep(postions, length.out = length(unique(df$time))),		# could be diff for each csv
	"direction" = rep(directions, length.out = length(unique(df$time)))		# could be diff for each csv
)

df <- merge(x=df, y=line_pos, by="time",all = TRUE)
df <- df[with(df, order(date, status)), ]

head(df)

# multiple tasks for a minute, slightly alter their positions higher or lower

text_offset <- 0.05




