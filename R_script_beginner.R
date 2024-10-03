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

#select variables
starwars %>% 
  select(name, height, mass)

starwars %>% 
  select(1:3)

starwars %>% 
  select(ends_with("color"))

#change variable order
starwars %>%
  select(name, mass, height,everything())

#change variable name
starwars %>% 
  rename("characters"="name") %>% head() #name to characters

#change variable type
class(starwars$hair_color)
starwars$hair_color = as.factor(starwars$hair_color)
class(starwars$hair_color)

starwars %>% 
  mutate(hair_color = as.character(hair_color)) %>% glimpse()

#change factor levels
df = starwars
df$sex = as.factor(df$sex)
levels(df$sex)

df = df %>% 
  mutate(sex = factor(sex, levels = c("male", "female", "hermaphroditic")))

levels(df$sex)

#filter rows
starwars %>% 
  select(mass, sex) %>% #not necessary
  filter(mass<55 &
           sex == "male")

#recode data
starwars %>% 
  select(sex) %>% #not necessary
  mutate(sex = recode(sex,
                      "male" = "man",
                      "female" = "woman"))

#dealing with missing data
mean(starwars$height) #na? doesn't know how to deal with the missing data
mean(starwars$height, na.rm = TRUE) #na.romove

#dealing with duplicates
names = c("Peter", "John", "Peter", "Andrew")
age = c(22,23,22,42)
friends = data.frame(names,age)
friends
friends %>% distinct()
distinct(friends)

#manipulate
#create or change a variable (mutate)
starwars %>% 
  mutate(height_m = height/100) %>% 
  select(name, height, height_m)


starwars %>%
  mutate(height_m = height/100) %>% 
  select(name, height, height_m) %>% 
  mutate(tallness =
           if_else(height_m<1,"short", "tall"))

#reshape data with pivot wider
library(gapminder)
View(gapminder)

data = select(gapminder, country, year, lifeExp)
View(data)  

wide_data = data %>% pivot_wider(names_from=year, values_from=lifeExp)
View(wide_data)  #pivot_wide(variable, value)

#reshape data with pivot longer
long_data = wide_data %>% pivot_longer(2:13, names_to = "year", values_to = "lifeExp")
View(long_data)  
  
#Range/spread
min(msleep$awake)
max(msleep$awake)
range(msleep$awake)
IQR(msleep$awake) # interquartile range 사분위수범위

#centrality
mean(msleep$awake)
median(msleep$awake)

#variance
var(msleep$awake)

summary(msleep$awake)

msleep %>% select(awake,sleep_total) %>% 
  summary()

#summarise your data
msleep %>% 
  drop_na(vore) %>% 
  group_by(vore) %>% 
  summarise(Lower = min(sleep_total),
            Average = mean(sleep_total),
            Upper = max(sleep_total),
            Difference = max(sleep_total)-min(sleep_total)) %>% 
  arrange(Average) %>% #arrange()=sorting
  View()

#create tables
View(msleep)
table(msleep$vore)

msleep %>% 
  select(vore,order) %>% 
  filter(order %in% c("Rodentia","Primates")) %>% 
  table()

#visualisation
plot(pressure)

#The grammar of graphics
#data / mapping / geometry

#Bar plots
ggplot(data = starwars,
       mapping = aes(x=gender))+geom_bar() #aes=aesthetics

#Histograms
starwars %>% 
  drop_na(height) %>% 
  ggplot(mapping = aes(x = height))+ #don't need to write mapping
  geom_histogram()

#box plots
starwars %>% 
  drop_na(height) %>% 
  ggplot(mapping= aes(x=height))+
  geom_boxplot(fill = "Steelblue")+
  theme_bw()+
  labs(title = "Boxplot of height", x="Height of characters")

#Density plots
starwars %>% 
  drop_na(height) %>% 
  filter(sex %in% c("male","female")) %>% 
  ggplot(aes(height, color=sex, fill=sex))+
  geom_density(alpha=0.2)+ #alpha=level of transparency
  theme_bw()

#Scatter plots
starwars %>% 
  filter(mass<200) %>% 
  ggplot(aes(height, mass, color=sex))+
  geom_point(size=5, alpha=0.2)+
  theme_bw()+
  labs(title="Height and mass by sex")

#smoothed model1
starwars %>% 
  filter(mass<200) %>% 
  ggplot(aes(height, mass, color=sex))+
  geom_point(size=3, alpha=0.8)+
  geom_smooth()+ #adding an extra layer
  facet_wrap(~sex)
  theme_bw()+
  labs(title="Height and mass by sex")  

#Hypothesis Testing
#t-test
#ANOVA
#Chi-Squared#Linear Models

library(dplyr)  
library(gapminder)
View(gapminder)

#t_test
gapminder %>% 
  filter(continent %in% c("Africa", "Europe")) %>% 
  t.test(lifeExp ~ continent, 
         data = ., #used the data from the filter
         alternative = "two.sided") #you can choose less or more one.sided
         #paired=FALSE
  
#ANOVA (Analysis of Variance)
gapminder %>% 
  filter(year==2007) %>% 
  filter(continent %in% c("Americans","Europe","Asia")) %>% 
  aov(lifeExp ~ continent, data=.) %>% 
  summary()

gapminder %>% 
  filter(year==2007) %>% 
  filter(continent %in% c("Americans","Europe","Asia")) %>% 
  aov(lifeExp ~ continent, data=.) %>% 
  TukeyHSD()

gapminder %>% 
  filter(year==2007) %>% 
  filter(continent %in% c("Americans","Europe","Asia")) %>% 
  aov(lifeExp ~ continent, data=.) %>% 
  TukeyHSD() %>% plot()

#Chi squared
#chi_plot

head(iris)

flowers = iris %>% 
  mutate(size=cut(Sepal.Length, breaks=3,
                  labels = c("Small", "Medium", "Large"))) %>% 
  select(Species, size)

View(flowers)

#chi squared goodness of fit test
flowers %>% 
  select(size) %>% 
  table() %>% 
  chisq.test()

#chi suqared test of independence
flowers %>% 




