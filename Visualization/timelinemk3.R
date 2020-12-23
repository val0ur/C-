# Timeline graphic using R and ggplot2

#install.packages("ggplot2")
#install.packages("scales")
#install.packages("lubridate")

library(ggplot2)
library(scales)
library(lubridate)

# input csv from DB 
df1 <- read.csv('C:/Users/305/Desktop/R/csv2/3_installedprogram.csv', encoding = 'UTF-8')
df1$status <- "installed_program"
df1 <- df1[with(df1, order(time)), ]    
head(df1, 20)

df2 <- read.csv('C:/Users/305/Desktop/R/csv2/3_serachterms.csv', encoding = 'UTF-8')
df2$status <- "search_terms"
df2 <- df2[with(df2, order(time)), ]   
head(df2, 20)

df3 <- read.csv('C:/Users/305/Desktop/R/csv2/3_timeline.csv', encoding = 'UTF-8')
df3$status <- "timeline"
df3 <- df3[with(df3, order(time)), ]   
head(df3, 20)

# all Dataframe in to 1
df <- rbind(df1, df2, df3)

# add anti_time row for BOOM | INPUT the anti_forensic_time as "YYYY-MM-DDThh:mm" form
df[nrow(df)+1, ] <- c(99,"2020-10-06T01:41","BOOM","BOOM")
df <- df[with(df, order(time)), ]
head(df,20)

# define colors for each event 
status_levels <- c("timeline", "installed_program", "search_terms","BOOM")
status_colors <- c("#0070C0", "#00B050","#FFC000", "#C00000")
df$status <- factor(df$status, levels=status_levels, ordered=TRUE)

# same event in same line
positions <- c(0.5, -0.5, 1.0, -1.0, 1.5, -1.5)
directions <- c(1,-1)

line_pos <- data.frame(
  "time" = unique(df$time),  
  "position" = rep(positions, length.out = length(unique(df$time))),    
  "direction" = rep(directions, length.out = length(unique(df$time)))   
)

df <- merge(x=df, y=line_pos, by="time",all= TRUE)
df <- df[with(df, order(time, status)), ]
head(df, 20)

# multiple tasks for a minute, slightly alter their positions higher or lower
text_offset <- 0.05
df$time_count <- ave(df$time==df$time, df$time, FUN=cumsum)
df$text_position <- (df$time_count * text_offset * df$direction) + df$position
head(df,20)

hour_df <- unlist(hour_df)

# Draw Timeline Graph
timeline_plot <- ggplot(df, aes(x=time, y=0, col=status, label = task)) # what data you use
timeline_plot <- timeline_plot + labs(col ="Artifacts")
timeline_plot <- timeline_plot +scale_color_manual(values=status_colors, labels=status_levels, drop = FALSE)
timeline_plot <- timeline_plot + theme_classic()

# Plot horizontal black line for timeline
timeline_plot <- timeline_plot + geom_hline(yintercept = 0, color = "black", size=0.3)

# Plot Title name
timeline_plot <- timeline_plot + ggtitle("Timeline for Aniforensic Event +- 30 min")    
timeline_plot <- timeline_plot + theme(plot.title = element_text( face = "bold", hjust = 0.5, size = 15, color = "darkblue"))

# Plot vertical segment lines for tasks
timeline_plot <- timeline_plot + geom_segment(data=df[df$time_count == 1,], aes(y=position, yend=0, xend=time), color = 'black', size=0.2)

# Plot scatter points at zero and date
timeline_plot<- timeline_plot + geom_point(aes(y=0), size =4) # point size 

# Legend
timeline_plot <- timeline_plot + theme(axis.line.y=element_blank(),
                                       axis.text.y=element_blank(),
                                       axis.title.x=element_blank(),
                                       axis.title.y=element_blank(),
                                       axis.ticks.y=element_blank(),
                                       axis.text.x=element_text(angle=30),
                                       axis.ticks.x=element_blank(),
                                       axis.line.x=element_blank(),
                                       legend.position = "bottom"
)

# Show text for each task | font size 
timeline_plot <- timeline_plot + geom_text(aes(y=text_position,label=task), size=2.5)

print(timeline_plot)