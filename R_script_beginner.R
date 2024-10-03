5+6
a=5
b=6
a+b
sum(1,b)

ages = c(a,b) #concatenation
ages
sum(ages)

names = c("John", "James")
friends = data.frame(names, ages)
friends
View(friends)
str(friends)

sum(friends$ages)

friends[1,1]
friends[1, ]
friends[ ,1]

#built in dataset
data()

#installing & using packages
install.packages("tidyverse")
library(tidyverse)
View(starwars)

starwars %>% 
  filter(height>150 & mass<200) %>% #observate rows
  mutate(height_in_metres = height/100) %>%  #mutate=change 
  select(height_in_metres, mass) %>% 
  arrange(mass) %>% #-mass 
  #View()
  plot()

#data structure and types of variables
View(msleep) #msleep about mammals
glimpse(msleep) #quick overview
head(msleep)
class(msleep$name)
length(msleep)
length(msleep$name)
names(msleep)
unique(msleep$vore)

#complete.cases() no missing data 
#!complete.cases() is an opposite 
#which means every rows that includes missing
missing = !complete.cases(msleep) 
msleep[missing,]

#clean







