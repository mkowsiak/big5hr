library(bwsTools)
library(dplyr)
library(tidyr)
library(ggplot2)

# load data produced by SPSS into R (answers to questions)
mydata <- read.csv(file = '@PROJECT_LOCATION@/data/002-BigFiveHR-maxdiff.csv', header = TRUE)
dat1 <- data.frame(mydata)
print(dat1)

# structure of MaxDiff is know and fixed; this file was created once and is used any time we need to run
# empirical bayesan
my_keys <- read.csv(file = '@PROJECT_LOCATION@/R_files/keys.csv', header = TRUE)
key <- data.frame(my_keys)
print(key)

# based on: https://cran.r-project.org/web/packages/bwsTools/vignettes/tidying_data.html
dat1_i <- dat1 %>% 
  # 1. collect all of the non-pid columns, where variable names are filled into
  #    the column q, and the values are in column resp
  gather("q", "resp", -pid) %>%
  mutate(
    resp = case_when(  # 2. recode resp such that
      resp == 2 ~ 1,   #    if resp is 2, make it 1
      resp == 1 ~ -1,  #    if resp is 1, make it -1
      is.na(resp) ~ 0  #    if resp is NA, make it zero
    )
  ) %>% 
  # 3. join with the key data.frame by the column q
  left_join(key, by = "q") %>% 
  # 4. separate the q column into the block number and the item number
  #    by the underscore
  separate(q, c("block", "temp"), sep = "_") %>% 
  # 5. unselect the item number, since it is no longer needed
  #    as you have the item name now
  select(-temp)

print(dat1_i)

# based on: https://cran.r-project.org/web/packages/bwsTools/vignettes/tidying_data.html
dat1_a <- dat1_i %>% 
  # 1. group by the label
  group_by(label) %>% 
  # 2. summarise such that...
  summarise(
    total = n(),              # n() shows number of times the item appeared
    best = sum(resp == 1),    # sum up the number of times it was selected best
    worst = sum(resp == -1),  # and sum up the times it was selected as worst
  )
print(dat1_a)

# based on: https://cran.r-project.org/web/packages/bwsTools/vignettes/tidying_data.html
res1_i <- e_bayescoring(dat1_i, "pid", "block", "label", "resp")
head(res1_i)

# plot results
# based on: https://cran.r-project.org/web/packages/bwsTools/vignettes/aggregate.html
# Analysis of MaxDiff Results
res_plot <- ae_mnl(dat1_a, "total", "best", "worst")
print(res_plot)

scaleFUN <- function(x) sprintf("%.2f", x)

# generate the plot
# Analysis of MaxDiff Results
dat1_a %>% 
  bind_cols(res_plot) %>% 
  arrange(b) %>% 
  mutate(label = factor(label, label)) %>% 
  ggplot(aes(x = label, y = b)) +
  geom_text(aes(label = scaleFUN(b)), 
            position = position_dodge(width = 1),
            vjust = -1,
            size = 3
            ) +
  geom_point() +
  geom_errorbar(aes(ymin = lb, ymax = ub), width = 0) +
  labs(title="", y="Average Utility Coefficients", x="Recruitment process") +
  coord_flip() + 
  theme_bw() + 
  theme(panel.border = element_blank(), panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))

# ggsave(path = "@PROJECT_LOCATION@", filename='auc.tiff', width = 989, height = 518, device='tiff')
ggsave("@PROJECT_LOCATION@/auc.png")

print(dat1_a %>% bind_cols(res_plot))

# based on: https://cran.r-project.org/web/packages/bwsTools/vignettes/tidying_data.html
# Analysis of MaxDiff Results
dat1 <- e_bayescoring(dat1_i, "pid", "block", "label", "resp", wide = TRUE) %>% 
  left_join(dat1, by = "pid")
print(dat1)

# remove unwanted columns
dat1 <- dat1 %>% select(-(q1_1:q15_4))
print(dat1)

# sort ascending by `pid`
dat1 <- dat1[order(dat1$pid), ]
print(dat1)

# format data such way each column is f2.2 (this will save our live once data is imported back to SPSS)
# source: https://stackoverflow.com/questions/3443687/formatting-decimal-places-in-r
dat1 <- dat1 %>%
  mutate(across(where(is.numeric), .fns = function(x) {format(round(x, 2), nsmall = 2)}))

# Save the data and jump to SPSS - we need to merge files using yet another script
write.csv(dat1, '@PROJECT_LOCATION@/data/003-MaxDiff-output.csv', row.names=FALSE)


