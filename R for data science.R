# the books is avalable online https://r4ds.had.co.nz/ 

# the answers to exercises here 
#https://github.com/maxconway/r4ds_solutions/blob/master/transform_solutions.Rmd

# first install.packages(c("nycflights13", "gapminder", "Lahman"))
# and tidyverse

# install tidyverse
install.packages("tidyverse")

# load the required packages
library(nycflights13)
library(tidyverse)

#explore nycflights 
nycflights13::flights
# can view View(flights)

# ggplot2 + dataframe mpg
library (ggplot2)
ggplot2::mpg

# two ways to code ggplot 
ggplot(data = mpg,mapping = aes(x = displ, y = hwy)) + 
  geom_point ()

ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy))

# a graphing template
#ggplot(data = <DATA>) +
 # <GEOM_FUNCTION>(mapping = aes(<MAPPINGS>))

#exploring mpg with gg
ggplot(mpg, aes(x=cyl,y=hwy))+
  geom_point()

ggplot(mpg, aes(x=class,y=drv))+
  geom_point()

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, colour = class))

# Top 
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, alpha = class))

# Bottom

ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, shape = class))

# blue colour of dots
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy), colour = "blue")

#facets
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy)) + facet_wrap(~ class, nrow = 2)

ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy)) + facet_grid(drv ~ cyl)

# What do the empty cells in a plot with facet_grid(drv ~ cyl) mean? How do they relate to this plot?

ggplot(data = mpg) + geom_point(mapping = aes(x = drv, y = cyl))+ facet_grid(drv ~ cyl)

ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy)) + facet_grid(drv ~ .)

ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy)) + facet_grid(. ~ cyl)

?facet_wrap

# left 
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy))

# right
ggplot(data = mpg) + geom_smooth(mapping = aes(x = displ, y = hwy))

# Here geom_smooth() separates the cars into three lines based on their drv value, which describes a car’s drivetrain.
ggplot(data = mpg) + geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv))
       
# we can make it more clear by overlaying the lines on top of the raw data and then coloring everything according to drv.
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, linetype = drv, color=drv))+
geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv, color=drv))

ggplot(data = mpg) + geom_smooth(mapping = aes(x = displ, y = hwy))
ggplot(data = mpg) + geom_smooth(mapping = aes(x = displ, y = hwy, group = drv))
ggplot(data = mpg) + geom_smooth( mapping = aes(x = displ, y = hwy, color = drv), show.legend = FALSE)

# To display multiple geoms in the same plot, add multiple geom functions to ggplot():
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy)) + geom_smooth(mapping = aes(x = displ, y = hwy))

# more efficient code for the same plot
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + geom_point() + geom_smooth()

# to display different aesthetics in different layers:
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + geom_point(mapping = aes(color = class)) + geom_smooth()

# Here, our smooth line displays just a subset of the mpg dataset, the subcompact cars
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + geom_point(mapping = aes(color = class)) + 
  geom_smooth( 
    data = filter(mpg, class == "subcompact"), se = FALSE
    )

#Will these two graphs look different? Why/why ( the same)

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + geom_point() + geom_smooth()

ggplot() + geom_point( data = mpg, mapping = aes(x = displ, y = hwy)
) +
  geom_smooth( data = mpg, mapping = aes(x = displ, y = hwy)
  )

# Re-create the R code necessary to generate the following graphs.
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + geom_point() + geom_smooth()

ggplot(data = mpg, mapping = aes(x = displ, y = hwy, linetype = drv))+
  geom_smooth(se=FALSE, size=2)+
  geom_point(size=4)

ggplot(data = mpg) + 
    geom_point(mapping = aes(x = displ, y = hwy, linetype = drv, color=drv, size=2))

ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv))+
  geom_point(size=3)+
  geom_smooth(se=FALSE)

ggplot() + geom_point( data = mpg, mapping = aes(x = displ, y = hwy, color=drv, size=2)
) +
  geom_smooth( data = mpg, mapping = aes(x = displ, y = hwy, size=1)
               , se=FALSE)

ggplot() + geom_point( data = mpg, mapping = aes(x = displ, y = hwy, color=drv, size=1)
) +
  geom_smooth( data = mpg, mapping = aes(x = displ, y = hwy,linetype=drv, size=1)
               , se=FALSE)

# statstical transformations
# exploring diamonds dataset with bar charts
library (ggplot2)
ggplot2::diamonds
ggplot(data = diamonds) + geom_col(mapping = aes(x = cut))
# using stat_count instead of geom_bar
ggplot(data = diamonds) + stat_count(mapping = aes(x = cut))

#you might want to display a bar chart of proportion, rather than count:
ggplot(data = diamonds) + geom_bar( mapping = aes(x = cut, y = ..prop.., group = 1))

#you might use stat_sum mary(), which summarizes the y values for each unique x value
ggplot(data = diamonds) + stat_summary( mapping = aes(x = cut, y = depth), 
                                        fun.ymin = min, fun.ymax = max, fun.y = median) 

#the other way to do the same as above but a boxplot
ggplot(data = diamonds) + geom_boxplot(mapping = aes(x=cut, y=depth))

# You can color a bar chart using either the color aesthetic, or more usefully, fill:
ggplot(data = diamonds) + geom_bar(mapping = aes(x = cut, color = cut))
ggplot(data = diamonds) + geom_bar(mapping = aes(x = cut, fill = cut))

#Note what happens if you map the fill aesthetic to another variable, like clarity: the
ggplot(data = diamonds) + geom_bar(mapping = aes(x = cut, fill = clarity))

#If you don’t want a stacked bar chart, you can use one of three other options: 
#"identity", "dodge" or "fill":

# position = "identity"
ggplot( data = diamonds, mapping = aes(x = cut, fill = clarity))
+ geom_bar(alpha = 1/5, position = "identity")
ggplot( data = diamonds, mapping = aes(x = cut, color = clarity)) 
+ geom_bar(fill = NA, position = "identity")
ggplot(data = diamonds) + geom_bar( mapping = aes(x = cut, fill = clarity), 
                                    position = "fill")
# position = "dodge" places
ggplot(data = diamonds) + geom_bar( mapping = aes(x = cut, fill = clarity), 
                                    position = "dodge")
# position = "jitter" 
ggplot(data = mpg) + geom_point( mapping = aes(x = displ, y = hwy), position = "jitter", size=1)
# ggplot2 comes with a shorthand for geom_point(posi tion = "jitter"): geom_jitter()

#excercise 1
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + geom_point(position = "jitter")

# excercise 4
ggplot(data = mpg) + geom_boxplot(mapping = aes(x = drv, y = hwy), position = "dodge")

# Boxplots on mpg dataset
ggplot2::mpg
ggplot(mpg, aes(class, hwy)) + 
  geom_boxplot()

ggplot(mpg, aes(class, hwy))+ 
  geom_boxplot() + geom_jitter(width = 0.2)

ggplot(mpg, aes(class, hwy))+ 
  geom_boxplot() + coord_flip()

ggplot(mpg, aes(class, hwy))+ 
  geom_boxplot(notch = TRUE)

ggplot(mpg, aes(class, hwy))+ 
  geom_boxplot(varwidth = TRUE)

ggplot(mpg, aes(class, hwy))+ 
geom_boxplot(aes(colour = drv))

# coordinate system
nz <- map_data("nz")
ggplot(nz, aes(long, lat, group = group)) + geom_polygon(fill = "white", color = "black")
ggplot(nz, aes(long, lat, group = group)) + geom_polygon(fill = "white", color = "black") + coord_quickmap()

#coord_polar() uses polar coordinates. Polar coordinates reveal an interesting connection between a bar chart and a Coxcomb chart:

bar <- ggplot(data = diamonds) + 
  geom_bar( mapping = aes(x = cut, fill = cut), show.legend = FALSE, width = 1
) +
  theme(aspect.ratio = 1) + labs(x = NULL, y = NULL)
bar + coord_flip() 
bar + coord_polar()

# Data Transformation with dplyr
# prerequisites 
library(nycflights13)
library(tidyverse) 

nycflights13::flights
View (flights)

# 5.2 Filter rows with filter()

filter(flights, month==1, day==1)
jan1<-filter(flights, month==1, day==1) 
# to print and save them to the variable 
(dec25 <- filter(flights, month==12, day==25)) 
# filter nov and Dec flights
filter(flights, month==11 | month==12)
# or using (x %in% y) expression
nov_dec<-filter(flights, month %in% c(11,12))

filter(flights, !(arr_delay > 120 | dep_delay > 120)) 
filter(flights, arr_delay <= 120, dep_delay <= 120)

# 5.2.3 Missing values 
# if you want to determine if a value is missing, use is.na()

is.na(jan1)

#filter() only includes rows where the condition is TRUE; it excludes both FALSE and NA values. 

#5.2.4 Exercises
#Find all flights that
# Had an arrival delay of two or more hours
filter(flights, (arr_delay >= 120 | dep_delay >= 120)) 
# Flew to Houston (IAH or HOU)
filter(flights, dest=="IAH")
#Were operated by United, American, or Delta
filter(flights, carrier %in% c("UA", "AA", "DL"))
#Departed in summer (July, August, and September)
filter(flights, month %in% c(7,8,9))
# Arrived more than two hours late, but didn’t leave late 
filter(flights, (arr_delay > 120 | dep_delay <= 0)) 
#Were delayed by at least an hour, but made up over 30 minutes in flight
filter(flights, (dep_delay >= 60 | arr_delay >= 30)) 

#Arrange Rows with arrange() https://r4ds.had.co.nz/transform.html#arrange-rows-with-arrange
arrange(flights, year, month, day)
arrange(flights, desc(arr_delay))
#Missing values are always sorted at the end:
df <- tibble(x = c(5, 2, NA))
arrange(df, x)
arrange(df, desc(x))
# Exercises
arrange(flights, desc(dep_delay))
arrange(flights, desc(dep_time-sched_dep_time))
arrange(flights, desc(sched_arr_time-arr_time))
arrange(flights, desc(air_time))
arrange(flights, air_time)
arrange(flights, !is.na(arr_time))
#5.4 Select columns with select
# Select columns by name
select(flights, year, month, day)
# Select all columns between year and day (inclusive)
select(flights, year:day)
# Select all columns except those from year to day (inclusive)
select(flights, -(year:day))

#use rename(), which is a variant of select() to rename the variables
rename(flights, tail_num=tailnum)

#use select() in conjunction with the everything() helper 
# here select - time_hour, air_time, is moved to the start of the dataframe everthing else remains the same
select(flights, time_hour, air_time, everything())
#5.4.1 Exercises https://r4ds.had.co.nz/transform.html#exercises-9  
select(flights, dep_time, dep_delay, arr_time, arr_delay)
select(flights, c(dep_time,  dep_delay, arr_time, arr_delay))
flights %>% select(dep_time,  dep_delay, arr_time, arr_delay)
select(flights, dep_time, dep_time)
# 3.What does the `one_of()` function do? Why might it be helpful in conjunction with this vector?
#It returns all the variables you ask for, for example ones stored in a vector.
vars <- c("year", "month", "day", "dep_delay", "arr_delay")
flights %>% select(one_of(vars))
select(flights, one_of(vars))
select(flights, contains("TIME"))

#5.5 Add new variables with mutate()
# it’s often useful to add new columns that are functions of existing columns. That’s the job of mutate()
# mutate() always adds new columns at the end of your dataset 


mutate(flights_sml,
       gain = dep_delay-arr_delay,
       speed = distance/air_time*60
)

mutate(flights_sml,
       gain = dep_delay-arr_delay,
       hours = air_time/60,
       gain_per_hour = gain/hours
)
# if you want to keep the new variables use transmutate
transmute(flights,
       gain = dep_delay - arr_delay,
       hours = air_time/60,
       gain_per_hour = gain/hours
)
#5.5.1 Useful creation functions 
# Modular arithmetic: %/% (integer division) and %% (remainder), where x == y * (x %/% y) + (x %% y)
transmute(flights,
          dep_time,
          hour = dep_time %/% 100,
          minute = dep_time %% 100
)
# Logs: log(), log2(), log10() - Logarithms
# Offsets: lead() and lag() allow you to refer to leading or lagging values (offset them)
(x <- 1:10)
lead(x)
lag(x)

# Cumulative and rolling aggregates: R provides functions for running sums, products, mins and maxes: 
#cumsum(), cumprod(), cummin(), cummax(); and dplyr provides cummean() for cumulative means.
cumsum(x)
cummean(x)
# Logical comparisons, <, <=, >, >=, !=, and ==
# Ranking - start with min_rank()
y <- c(1, 2, 2, NA, 3, 4)
min_rank(y)
min_rank(desc(y))
# the other ranking variants row_number(), dense_rank()
row_number(y)
dense_rank(y)
View(flights)

#5.5.2 Exercises
#1
mutate(flights,
       dep_time = (dep_time %/% 100) * 60 + (dep_time %% 100),
       sched_dep_time=(sched_dep_time%/%100)*60+(sched_dep_time%%100))
#2
flights %>% 
  mutate(dep_time = (dep_time %/% 100) * 60 + (dep_time %% 100),
         sched_dep_time = (sched_dep_time %/% 100) * 60 + (sched_dep_time %% 100),
         arr_time = (arr_time %/% 100) * 60 + (arr_time %% 100),
         sched_arr_time = (sched_arr_time %/% 100) * 60 + (sched_arr_time %% 100)) %>%
  transmute((arr_time - dep_time) %% (60*24) - air_time)

#3
flights %>% 
  mutate(dep_time = (dep_time %/% 100) * 60 + (dep_time %% 100),
         sched_dep_time = (sched_dep_time %/% 100) * 60 + (sched_dep_time %% 100),
         arr_time = (arr_time %/% 100) * 60 + (arr_time %% 100),
         sched_arr_time = (sched_arr_time %/% 100) * 60 + (sched_arr_time %% 100)) %>%
  transmute(near((sched_dep_time + dep_delay) %% (60*24), dep_time, tol=1))
# 4 
filter(flights, min_rank(desc(dep_delay))<=10)
flights %>% top_n(n = 10, wt = dep_delay)
# 5
1:3+1:10
#6
?Trig

# 5.6 Grouped summaries with summarise()
#summarise a dataframe to a single row
summarise(flights, delay = mean(dep_delay, na.rm = TRUE))

# summarise() is not terribly useful unless we pair it with group_by()
by_day <- group_by(flights, year, month, day)
summarise(by_day, delay = mean(dep_delay, na.rm = TRUE))

# 5.6.1 Combining multiple operations with the pipe
by_dest <- group_by(flights, dest)
delay <- summarise(by_dest,
                   count = n(),
                   dist = mean(distance, na.rm = TRUE),
                   delay = mean(arr_delay, na.rm = TRUE)
)
delay <- filter(delay, count > 20, dest != "HNL")

ggplot(data = delay, mapping = aes(x = dist, y = delay)) +
  geom_point(aes(size = count), alpha = 1/3) +
  geom_smooth(se = FALSE)

# There’s another way to tackle the same problem with the pipe, %>%: 

delays <- flights %>% 
  group_by(dest) %>% 
  summarise(
    count = n(),
    dist = mean(distance, na.rm = TRUE),
    delay = mean(arr_delay, na.rm = TRUE)
  ) %>% 
  filter(count > 20, dest != "HNL")
#5.6.2 Missing values
flights %>% 
  group_by(year, month, day) %>% 
  summarise(mean = mean(dep_delay, na.rm = TRUE))
# remove values with cancelted flights
not_cancelled <- flights %>% 
  filter(!is.na(dep_delay), !is.na(arr_delay))
# then summirize 
not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(mean = mean(dep_delay))

# 5.6.3 Counts
#Whenever you do any aggregation, it’s always a good idea to include either a count (n()), 
# or a count of non-missing values (sum(!is.na(x))). 

delays <- not_cancelled %>% 
  group_by(tailnum) %>% 
  summarise(
    delay = mean(arr_delay)
  )

ggplot(data = delays, mapping = aes(x = delay)) + 
  geom_freqpoly(binwidth = 10)
# scatterplot of number of flights vs average delay
delays <- not_cancelled %>% 
  group_by(tailnum) %>% 
  summarise(
    delay = mean(arr_delay, na.rm = TRUE),
    n = n()
  )

ggplot(data = delays, mapping = aes(x = n, y = delay)) + 
  geom_point(alpha = 1/10)

# filtering out the groups with smalest number of observations

delays %>% 
  filter(n > 25) %>% 
  ggplot(mapping = aes(x = n, y = delay)) + 
  geom_point(alpha = 1/10)

# Convert to a tibble so it prints nicely
batting <- as_tibble(Lahman::Batting)

batters <- batting %>% 
  group_by(playerID) %>% 
  summarise(
    ba = sum(H, na.rm = TRUE) / sum(AB, na.rm = TRUE),
    ab = sum(AB, na.rm = TRUE)
  )

batters %>% 
  filter(ab > 100) %>% 
  ggplot(mapping = aes(x = ab, y = ba)) +
  geom_point() + 
  geom_smooth(se = FALSE)
#> `geom_smooth()` using method = 'gam' and formula 'y ~ s(x, bs = "cs")'

# 5.6.4 Useful summary functions
# It’s sometimes useful to combine aggregation with logical subsetting
not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(
    avg_delay1 = mean(arr_delay),
    avg_delay2 = mean(arr_delay[arr_delay > 0]) # the average positive delay
)
#Measures of spread: sd(x), IQR(x), mad(x)
# Why is distance to some destinations more variable than to others?
not_cancelled %>% 
  group_by(dest) %>% 
  summarise(distance_sd = sd(distance)) %>% 
  arrange(desc(distance_sd))
# Measures of rank: min(x), quantile(x, 0.25), max(x)
# When do the first and last flights leave each day?
not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(
    first = min(dep_time),
    last = max(dep_time)
  )
#Measures of position: first(x), nth(x, 2), last(x) 
#For example, we can find the first and last departure for each day: 
not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(
    first_dep = first(dep_time), 
    last_dep = last(dep_time)
  )
#These functions are complementary to filtering on ranks
not_cancelled %>% 
  group_by(year, month, day) %>% 
  mutate(r = min_rank(desc(dep_time))) %>% 
  filter(r %in% range(r))
#Counts: You’ve seen n(), which takes no arguments, and returns the size of the current group
#To count the number of non-missing values, use sum(!is.na(x)). 
#To count the number of distinct (unique) values, use n_distinct(x)

# Which destinations have the most carriers?
not_cancelled %>% 
  group_by(dest) %>% 
  summarise(carriers = n_distinct(carrier)) %>% 
  arrange(desc(carriers))

#Counts are so useful that dplyr provides a simple helper if all you want is a count:
not_cancelled %>% 
  count(dest)
# You can optionally provide a weight variable
not_cancelled %>% 
  count(tailnum, wt = distance)

# How many flights left before 5am? (these usually indicate delayed
# flights from the previous day)
not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(n_early = sum(dep_time < 500))

# What proportion of flights are delayed by more than an hour?
not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(hour_perc = mean(arr_delay > 60))

#5.6.5 Grouping by multiple variables
daily <- group_by(flights, year, month, day)
(per_day   <- summarise(daily, flights = n()))
(per_month <- summarise(per_day, flights = sum(flights)))
(per_year  <- summarise(per_month, flights = sum(flights)))

#5.6.6 Ungrouping
daily %>% 
  ungroup() %>%             # no longer grouped by date
  summarise(flights = n())  # all flights

#5.6.7 Exercises
# 4
flights %>%
  mutate(dep_date = lubridate::make_datetime(year, month, day)) %>%
  group_by(dep_date) %>%
  summarise(cancelled = sum(is.na(dep_delay)), 
            n = n(),
            mean_dep_delay = mean(dep_delay,na.rm=TRUE),
            mean_arr_delay = mean(arr_delay,na.rm=TRUE)) %>%
  ggplot(aes(x= cancelled/n)) + 
  geom_point(aes(y=mean_dep_delay), colour='blue', alpha=0.5) + 
  geom_point(aes(y=mean_arr_delay), colour='red', alpha=0.5) + 
  ylab('mean delay (minutes)')

#5.7 Grouped mutates (and filters)
#Grouping is most useful in conjunction with summarise(), 
#but you can also do convenient operations with mutate() and filter():

#Find the worst members of each group:
flights_sml %>% 
  group_by(year, month, day) %>%
  filter(rank(desc(arr_delay)) < 10)

# Find all groups bigger than a threshold:
popular_dests <- flights %>% 
  group_by(dest) %>% 
  filter(n() > 365)
popular_dests

#Standardise to compute per group metrics:
popular_dests %>% 
  filter(arr_delay > 0) %>% 
  mutate(prop_delay = arr_delay / sum(arr_delay)) %>% 
  select(year:day, dest, arr_delay, prop_delay)


#7 Exploratory Data Analysis
#https://r4ds.had.co.nz/exploratory-data-analysis.html 
library(tidyverse)
library (ggplot2)

#7.3.1 Visualising distributions
ggplot2::diamonds
ggplot(data=diamonds)+
geom_bar(mapping = aes(x=cut))

diamonds %>%
  count(cut)
# the continuous variable distributiion can be examined by histogram:
ggplot(data = diamonds)+
  geom_histogram(mapping = aes(x=carat), binwidth = 0.5)
# with dplyr::count()
diamonds %>%
  count(cut_width(carat, 0.5))
#diamonds of less than three carats
smaller <- diamonds %>% 
  filter(carat < 3)

ggplot(data = smaller, mapping = aes(x = carat)) +
  geom_histogram(binwidth = 0.1)

#to overlay multiple histograms in the same plot use frequepoly
ggplot(data=smaller, mapping = aes(x=carat, color=cut))+
  geom_freqpoly(binwidth=0.1)
#Typical values+
ggplot(data=smaller, mapping=aes(x=carat))+
  geom_histogram(binwidth = 0.01)
#unusual values
ggplot(data = diamonds)+
  geom_histogram(mapping = aes(x=y), binwidth = 0.5)
#and zoom into data
ggplot(diamonds)+
  geom_histogram(mapping = aes(x=y), binwidth = 0.5)+
  coord_cartesian(ylim=c(0,50))
#filtering unusual values with dplyr
unusual <- diamonds%>%
  filter(y<3|y>20)%>%
  arrange(y)
unusual
# 7.3.4 Exercises
#1
ggplot(data = diamonds)+
  geom_histogram(mapping = aes(x=x), binwidth = 0.5)+
  facet_grid(.~cut)
ggplot(data = diamonds)+
  geom_histogram(mapping = aes(x=y), binwidth = 0.5, color="blue")+
  facet_grid(. ~ cut)
ggplot(data = diamonds)+
  geom_histogram(mapping = aes(x=z), binwidth = 0.5, color="red")+
  facet_grid(. ~ cut)
#2
ggplot(data = diamonds)+
  geom_line(mapping = aes(x=price), binwidth = 0.5, color="yellow")

# 7.4 Missing values
# replacing the unusual values with missing values
diamonds2 <- diamonds %>% 
  mutate(y = ifelse(y < 3 | y > 20, NA, y))
ggplot(data = diamonds2, mapping = aes(x = x, y = y)) + 
  geom_point()
# Other times you want to understand what makes observations with missing values different 
# to observations with recorded values.

nycflights13::flights %>% 
  mutate(
    cancelled = is.na(dep_time),
    sched_hour = sched_dep_time %/% 100,
    sched_min = sched_dep_time %% 100,
    sched_dep_time = sched_hour + sched_min / 60
  ) %>% 
  ggplot(mapping = aes(sched_dep_time)) + 
  geom_freqpoly(mapping = aes(colour = cancelled), binwidth = 1/4)

# 7.5 Covariation
# 7.5.1 A categorical and continuous variable
ggplot(data = diamonds, mapping = aes(x = price)) + 
  geom_freqpoly(mapping = aes(colour = cut), binwidth = 500)
# It’s hard to see the difference in distribution because the overall counts differ so much:
ggplot(diamonds)+
  geom_bar(mapping = aes(x=cut))

ggplot(data = diamonds, mapping = aes(x = price, y = ..density..)) + 
  geom_freqpoly(mapping = aes(colour = cut), binwidth = 500)

# Boxplots
ggplot(data = diamonds, mapping = aes(x = cut, y = price)) +
  geom_boxplot()

ggplot(data = mpg, mapping = aes(x = class, y = hwy)) +
  geom_boxplot()

ggplot(data = mpg) +
  geom_boxplot(mapping = aes(x = reorder(class, hwy, FUN = median), y = hwy))

ggplot(data = mpg) +
  geom_boxplot(mapping = aes(x = reorder(class, hwy, FUN = median), y = hwy)) +
  coord_flip()

ggplot(data = mpg) +
  geom_violin(mapping = aes(x = reorder(class, hwy, FUN = median), y = hwy))+
  facet_wrap(~ class, nrow = 2)
ggplot(data = mpg) +
  geom_jitter(mapping = aes(x = reorder(class, hwy, FUN = median), y = hwy))+
  facet_wrap(~ class, nrow = 2)

# 7.5.2 Two categorical variables

ggplot(data = diamonds) +
  geom_count(mapping = aes(x = cut, y = color))

# Another approach is to compute the count with dplyr:
diamonds %>% 
  count(color, cut)
diamonds %>% 
  count(color, cut) %>%  
  ggplot(mapping = aes(x = color, y = cut)) +
  geom_tile(mapping = aes(fill = n))

# 7.5.3 Two continuous variables

ggplot(data = diamonds) +
  geom_point(mapping = aes(x = carat, y = price))
# to overcome overplottling

ggplot(data = diamonds) + 
  geom_point(mapping = aes(x = carat, y = price), alpha = 1 / 100)

ggplot(data = smaller) +
  geom_bin2d(mapping = aes(x = carat, y = price))

# use hexbin package 
install.packages("hexbin")

ggplot(data = smaller) +
  geom_hex(mapping = aes(x = carat, y = price))

# or use boxplots with binned data
ggplot(data = smaller, mapping = aes(x = carat, y = price)) + 
  geom_boxplot(mapping = aes(group = cut_width(carat, 0.1)))

ggplot(data = smaller, mapping = aes(x = carat, y = price)) + 
  geom_boxplot(mapping = aes(group = cut_number(carat, 20)))

# scatterplot
ggplot(data = diamonds) +
  geom_point(mapping = aes(x = x, y = y)) +
  coord_cartesian(xlim = c(4, 11), ylim = c(4, 11))

#7.6 Patterns and models

 # A scatterplot of Old Faithful eruption lengths versus the wait time between eruptions shows a pattern:

ggplot(data=faithful)+
  geom_point(mapping=aes(x=eruptions, y=waiting))

mod<-lm(data=faithful, waiting~eruptions)
plot(faithful$eruptions, faithful$waiting, col='yellow')
abline(mod, col="red", lty=2)

#Models are a tool for extracting patterns out of data. 

library(modelr)

mod <- lm(log(price) ~ log(carat), data = diamonds)

diamonds2 <- diamonds %>% 
  add_residuals(mod) %>% 
  mutate(resid = exp(resid))

ggplot(data = diamonds2) + 
  geom_point(mapping = aes(x = carat, y = resid))

ggplot(data = diamonds2) + 
  geom_boxplot(mapping = aes(x = cut, y = resid))

#7.7 ggplot2 calls

ggplot(data = faithful, mapping = aes(x = eruptions)) + 
  geom_freqpoly(binwidth = 0.25)

# more concise
ggplot(faithful, aes(eruptions)) + 
  geom_freqpoly(binwidth = 0.25)

diamonds %>% 
  count(cut, clarity) %>% 
  ggplot(aes(clarity, cut, fill = n)) + 
  geom_tile()

# more about ggplot2 book "ggplot2: Elegant Graphics for Data Analysis"

#10 Tibbles
library(tidyverse)
as_tibble(iris)

tibble(
  x = 1:5, 
  y = 1, 
  z = x ^ 2 + y
)
# tribble - transposed tibble
tribble(
  ~x, ~y, ~z,
  #--|--|----
  "a", 2, 3.6,
  "b", 1, 8.5
)
# 10.3 Tibbles vs. data.frame

nycflights13::flights %>% 
  print(n = 10, width = Inf)

nycflights13::flights %>% 
  View()

# subsetting
# either
df$x
# or with . with pipe
df%>% .$x

# use as.data.frame if you want ot force tibble to dataframe
class(as.data.frame(tb))

# 11 Data import with readr
#read_csv() reads comma delimited files, 
#read_csv2() reads semicolon separated files
#read_tsv() reads tab delimited files
#read_delim() reads in files with any delimiter.
# read_table() reads a common variation of fixed width files where columns are separated by white space.

heights <- read_csv("data/heights.csv")

read_csv("a,b,c
1,2,3
4,5,6")

# skip=2 - skip the first tow lines of data
read_csv("The first line of metadata
  The second line of metadata
  x,y,z
  1,2,3", skip = 2)

read_csv("# A comment I want to skip
  x,y,z
  1,2,3", comment = "#")

#You can use col_names = FALSE to tell read_csv() not to treat the first row as headings,
#and instead label them sequentially from X1 to Xn 

read_csv("1,2,3\n4,5,6", col_names = FALSE)

# alternatively col_names add a character vector
read_csv("1,2,3\n4,5,6", col_names = c("x", "y", "z"))

# na
read_csv("a,b,c\n1,2,.", na = ".")

# 11.3 Parsing a vector. parse_*() function. 
#These functions take a character vector and 
#return a more specialised vector like a logical, integer, or date:
str(parse_logical(c("TRUE", "FALSE", "NA")))
str(parse_integer(c("1", "2", "3")))
str(parse_date(c("2010-01-01", "1979-10-14"))) 
parse_integer(c("1", "231", ".", "456"), na = ".")
# problems () allows to see parsing problems in readr
x <- parse_integer(c("123", "345", "abc", "123.45"))
problems(x)

# 11.3.1 Numbers
parse_double("1.23")
parse_double("1,23", locale = locale(decimal_mark = ","))
# parse_number() ignores non-numeric characters before and after the number
parse_number("$100")
parse_number("20%")
parse_number("it costs $123.45")
# Used in America
parse_number("$123,456,789")
# Used in many parts of Europe
parse_number("123.456.789", locale = locale(grouping_mark = "."))
# Used in Switzerland
parse_number("123'456'789", locale = locale(grouping_mark = "'"))

#11.3.2 Strings
# charToRaw shows how strings are coded in R
charToRaw("Hadley")

x1 <- "El Ni\xf1o was particularly bad this year"
x2 <- "\x82\xb1\x82\xf1\x82\xc9\x82\xbf\x82\xcd"
parse_character(x1, locale = locale(encoding = "Latin1"))
parse_character(x2, locale = locale(encoding = "Shift-JIS"))

#How do you find the correct encoding? -> guess_encoding()
guess_encoding(charToRaw(x1))
guess_encoding(charToRaw(x2))

# more on encoding http://kunststube.net/encoding/. 

# 11.3.3 Factors                                    
fruit <- c("apple", "banana")
parse_factor(c("apple", "banana", "bananana"), levels = fruit)

# 11.3.4 Dates, date-times, and times

# parse_datetime() expects an ISO8601 date-time

parse_datetime("2010-10-01T2010")
# If time is omitted, it will be set to midnight

parse_datetime("20101010")
parse_date("2010-10-01")

# parse_time() expects the hour, :, minutes, 
# optionally : and seconds, and an optional am/pm specifier:

library(hms)
parse_time("01:10 am")
parse_time("20:10:01")

parse_date("01/02/15", "%m/%d/%y")
parse_date("01/02/15", "%d/%m/%y")
parse_date("01/02/15", "%y/%m/%d")

# 11.4 Parsing a file
# 11.4.3 Other strategies 

# Sometimes it’s easier to diagnose problems if you just read in all the columns 
#as character vectors:

challenge2 <- read_csv(readr_example("challenge.csv"), 
                       col_types = cols(.default = col_character())
) 

df <- tribble(
  ~x,  ~y,
  "1", "1.21",
  "2", "2.32",
  "3", "4.56"
)
df
type_convert(df)

# 11.5 Writing to a file

challenge <- read_csv(readr_example("challenge.csv"))
write_csv(challenge, "challenge.csv")

# use RDS format - R's custom binary format
write_rds(challenge, "challenge.rds")
read_rds("challenge.rds")

# 12 Tidy data

table1
table2
table3
table4a
table4b

# Compute rate per 10,000
table1 %>% 
  mutate(rate = cases / population * 10000)

# Compute cases per year      
table1 %>% 
  count(year, wt = cases)

# Visualise changes over time
library(ggplot2)
ggplot(table1, aes(year, cases)) + 
  geom_line(aes(group = country), colour = "grey50") + 
  geom_point(aes(colour = country))

# 12.3 Spreading and gathering
# 12.3.1 Gathering

table4a
table4a %>% 
  gather(`1999`, `2000`, key = "year", value = "cases")

table4b
table4b %>% 
  gather(`1999`, `2000`, key = "year", value = "population")

# combining two tables with dplyr::left_join()

tidy4a <- table4a %>% 
  gather(`1999`, `2000`, key = "year", value = "cases")
tidy4b <- table4b %>% 
  gather(`1999`, `2000`, key = "year", value = "population")
left_join(tidy4a, tidy4b)

# 12.3.2 Spreading
# Spreading is the opposite of gathering

table2

table2 %>%
  spread(key = type, value = count)

#12.3.3 Exercises
preg <- tribble(
  ~pregnant, ~male, ~female,
  "yes",     NA,    10,
  "no",      20,    12
)

View(preg)
preg %>%
  gather("male", "female", key = "sex", value = "cases")

# 12.4 Separating and uniting
# 12.4.1 Separate
# separate() pulls apart one column into multiple columns,
# by splitting wherever a separator character appears.

table3

table3 %>% 
  separate(rate, into = c("cases", "population"))

# or the same code explicitly 
table3 %>% 
  separate(rate, into = c("cases", "population"), sep = "/")

# but you need to convert column type characters into vectors

table3 %>% 
  separate(rate, into = c("cases", "population"), convert = TRUE)
# separate year into century and year
table3 %>% 
  separate(year, into = c("century", "year"), sep = 2)

# 12.4.2 Unite
# unite() is the inverse of separate():
# it combines multiple columns into a single column.


table5 %>% 
  unite(new, century, year, sep = "")

#  12.5 Missing values

# Explicitly, i.e. flagged with NA.
# Implicitly, i.e. simply not present in the data.

stocks <- tibble(
  year   = c(2015, 2015, 2015, 2015, 2016, 2016, 2016),
  qtr    = c(   1,    2,    3,    4,    2,    3,    4),
  return = c(1.88, 0.59, 0.35,   NA, 0.92, 0.17, 2.66)
)

# remove NA
stocks %>% 
  spread(year, return) %>% 
  gather(year, return, `2015`:`2016`, na.rm = TRUE)

# use 'complete'
# complete() takes a set of columns, and finds all unique combinations. 
# It then ensures the original dataset contains all those values, 
# filling in explicit NAs where necessary.

stocks %>% 
  complete(year, qtr)

# 12.6 Case Study 

# The tidyr::who dataset contains tuberculosis (TB) cases
# broken down by year, country, age, gender, and diagnosis method.

who

who1 <- who %>% 
  gather(new_sp_m014:newrel_f65, key = "key", value = "cases", na.rm = TRUE)

who1

who1 %>% 
  count(key)

# replace strings newrel with new_rel in the whole dataset
who2 <- who1 %>% 
  mutate(key = stringr::str_replace(key, "newrel", "new_rel"))
who2

# use separate to 'key'
who3 <- who2 %>% 
  separate(key, c("new", "type", "sexage"), sep = "_")
who3

who3 %>% 
  count(new)
# remove redundant columns
who4 <- who3 %>% 
  select(-new, -iso2, -iso3)
# separate sexage col
who5 <- who4 %>% 
  separate(sexage, c("sex", "age"), sep = 1)
who5

# a complete pipe with a chunk of code
who %>%
  gather(key, value, new_sp_m014:newrel_f65, na.rm = TRUE) %>% 
  mutate(key = stringr::str_replace(key, "newrel", "new_rel")) %>%
  separate(key, c("new", "var", "sexage")) %>% 
  select(-new, -iso2, -iso3) %>% 
  separate(sexage, c("sex", "age"), sep = 1)

# 13 Relational data

library(nycflights13)
airlines
airports
planes
weather
View(flights)

planes %>% 
  count(tailnum) %>% 
  filter(n > 1)

weather %>% 
  count(year, month, day, hour, origin) %>% 
  filter(n > 1)

flights %>% 
  count(year, month, day, flight) %>% 
  filter(n > 1)

flights %>% 
  count(year, month, day, tailnum) %>% 
  filter(n > 1)

# 13.4 Mutating joins

flights2 <- flights %>% 
  select(year:day, hour, origin, dest, tailnum, carrier)
View (flights2)

# imagine you want to add the full airline name to the flights2 data.
# You can combine the airlines and flights2 data frames with left_join():

flights2 %>%
  select(-origin, -dest) %>% 
  left_join(airlines, by = "carrier")

# or 
flights2 %>%
  select(-origin, -dest) %>% 
  mutate(name = airlines$name[match(carrier, airlines$carrier)])

# 13.4.1 Understanding joins

x <- tribble(
  ~key, ~val_x,
  1, "x1",
  2, "x2",
  3, "x3"
)
y <- tribble(
  ~key, ~val_y,
  1, "y1",
  2, "y2",
  4, "y3"
)
# 13.4.2 Inner join
x %>% 
  inner_join(y, by = "key")

# 13.4.4 Duplicate keys
# load data
x <- tribble(
  ~key, ~val_x,
  1, "x1",
  2, "x2",
  2, "x3",
  1, "x4"
)
y <- tribble(
  ~key, ~val_y,
  1, "y1",
  2, "y2"
)

left_join(x,y, by = "key")

#13.4.5 Defining the key columns

# by default, natural join flights2 with weather
flights2 %>% 
  left_join(weather)

#by a character vector
flights2 %>% 
  left_join(planes, by = "tailnum")

#by A named character vector: by = c("a" = "b"). 

flights2 %>% 
  left_join(airports, c("dest" = "faa"))

flights2 %>% 
  left_join(airports, c("origin" = "faa"))

# 13.4.7 Other implementations
# base::merge() can perform all four types of mutating join:p187

# semi_join(x, y) keeps all observations in x that have a match in y.
# anti_join(x, y) drops all observations in x that have a match in y.

top_dest <- flights %>%
  count(dest, sort = TRUE) %>%
  head(10)
top_dest

flights %>% 
  semi_join(top_dest)

flights_semi<-flights %>% 
  semi_join(top_dest)

# Anti-joins are useful for diagnosing join mismatches.  

flights %>%
  anti_join(planes, by = "tailnum") %>%
  count(tailnum, sort = TRUE)

#13.7 Set operations

df1 <- tribble(
  ~x, ~y,
  1,  1,
  2,  1
)

df2 <- tribble(
  ~x, ~y,
  1,  1,
  1,  2
)

intersect(df1, df2)
union (df1, df2)
setdiff(df1, df2)

# 14 Strings

library(tidyverse)
library(stringr)

string1 <- "This is a string"
string2 <- 'If I want to include a "quote" inside a string, I use single quotes'


double_quote <- "\"" # or '"'
single_quote <- '\'' # or "'"
double_quote
single_quote

# special characters
x <- "\u00b5"
x
print(x)

# combining strings
str_c("x", "y")
str_c("x", "y", sep = ", ")

x <- c("abc", NA)
str_c("|-", x, "-|")
str_c("|-", str_replace_na(x), "-|") 

# 14.2.3 Subsetting strings

x <- c("Apple", "Banana", "Pear")
str_sub(x, 1, 3)

#You can also use the assignment form of str_sub() to modify strings:
  
str_sub(x, 1, 1) <- str_to_lower(str_sub(x, 1, 1))
x

# 14.2.4 Locales

x <- c("apple", "eggplant", "banana")

str_sort(x, locale = "en")
str_sort(x, locale = "de")

#14.3 Matching patterns with regular expressions
# Regexps are a very terse language that allow you to describe patterns in strings.

#14.3.1 Basic matches

x <- c("apple", "banana", "pear")
str_view(x, "an")

str_view(x, ".a.")

# And this tells R to look for an explicit .
str_view(c("abc", "a.c", "bef"), "a\\.c")

# 14.3.2 Anchors - are needed to anchor regular expression

# ^ to match the start of the string.

x <- c("apple", "banana", "pear")
str_view(x, "^a")

# $ to match the end of the string
str_view(x, "a$")

# 14.4.5 Splitting- Use str_split() to split a string up into pieces.  
sentences %>%
  head(5) %>% 
  str_split(" ")
# to return a matrix:
sentences %>%
  head(5) %>% 
  str_split(" ", simplify = TRUE)

x <- "This is a sentence.  This is another sentence."
str_view_all(x, boundary("word"))

# 15 Factors with forcats (not part of tidyverse)
library(tidyverse)
library(forcats)

# 15.2 Creating factors

# if you create a string 
x1 <- c("Dec", "Apr", "Jan", "Mar")

# and create levels
month_levels <- c(
  "Jan", "Feb", "Mar", "Apr", "May", "Jun", 
  "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")
  
# then you can make a factor

y1 <-factor(x1, levels = month_levels)
y1
# which you can sort
sort(y1)

# making the order of levels matching the first appearance in data with unique()
f1 <- factor(x1, levels = unique(x1))
x1
#or with fct_inorder
f2 <- x1 %>% factor() %>% fct_inorder() 
levels(f2)

#15.3 General Social Survey
forcats::gss_cat

gss_cat %>%
  count(race)

ggplot(gss_cat, aes(race))+
  geom_bar()

# 15.4 Modifying factor order
# you want to explore the average number of hours 
# spent watching TV per day across religions:

relig_summary <- gss_cat %>%
  group_by(relig) %>%
  summarise(
    age = mean(age, na.rm = TRUE),
    tvhours = mean(tvhours, na.rm = TRUE),
    n = n()
  )
ggplot(relig_summary, aes(tvhours, relig)) +geom_point()

# reordering using fct_reorder()  

ggplot(relig_summary, aes(tvhours, fct_reorder(relig, tvhours))) +
  geom_point()

# the same only for age
rincome_summary <- gss_cat %>%
  group_by(rincome) %>%
  summarise(
    age = mean(age, na.rm = TRUE),
    tvhours = mean(tvhours, na.rm = TRUE),
    n = n()
  )

# coloring lines on the plot
ggplot(rincome_summary, aes(age, fct_relevel(rincome, "Not applicable"))) +
  geom_point()
by_age <- gss_cat %>%
  filter(!is.na(age)) %>%
  count(age, marital) %>%
  group_by(age) %>%
  mutate(prop = n / sum(n))

ggplot(by_age, aes(age, prop, colour = marital)) +
  geom_line(na.rm = TRUE)

ggplot(by_age, aes(age, prop, colour = fct_reorder2(marital, age, prop))) +
  geom_line() +
  labs(colour = "marital")

gss_cat %>%
  mutate(marital = marital %>% fct_infreq() %>% fct_rev()) %>%
  ggplot(aes(marital)) +
  geom_bar()

# 15.5 Modifying factor levels
gss_cat %>% count(partyid)

gss_cat %>%
  mutate(partyid = fct_recode(partyid,
                              "Republican, strong"    = "Strong republican",
                              "Republican, weak"      = "Not str republican",
                              "Independent, near rep" = "Ind,near rep",
                              "Independent, near dem" = "Ind,near dem",
                              "Democrat, weak"        = "Not str democrat",
                              "Democrat, strong"      = "Strong democrat"
  )) %>%
  count(partyid)

gss_cat %>%
  mutate(partyid = fct_recode(partyid,
                              "Republican, strong"    = "Strong republican",
                              "Republican, weak"      = "Not str republican",
                              "Independent, near rep" = "Ind,near rep",
                              "Independent, near dem" = "Ind,near dem",
                              "Democrat, weak"        = "Not str democrat",
                              "Democrat, strong"      = "Strong democrat",
                              "Other"                 = "No answer",
                              "Other"                 = "Don't know",
                              "Other"                 = "Other party"
  )) %>%
  count(partyid)

# lump together small groups with fct_lump()
gss_cat %>%
  mutate(relig = fct_lump(relig)) %>%
  count(relig)

# using parameter n
gss_cat %>%
  mutate(relig = fct_lump(relig, n = 10)) %>%
  count(relig, sort = TRUE) %>%
  print(n = Inf)

# 16 Dates and times 
# https://r4ds.had.co.nz/dates-and-times.html 

# 16.1.1 Prerequisites with lubridate

library(tidyverse)
library(lubridate)
library(nycflights13)

today()
now()

ymd_hms("2017-01-31 20:11:59")

mdy_hm("01/31/2017 08:01")

ymd(20170131, tz = "UTC")

# 16.2.2 From individual components
flights %>% 
  select(year, month, day, hour, minute)

# 
flights %>% 
  select(year, month, day, hour, minute) %>% 
  mutate(departure = make_datetime(year, month, day, hour, minute))

make_datetime_100 <- function(year, month, day, time) {
  make_datetime(year, month, day, time %/% 100, time %% 100)
}

flights_dt <- flights %>% 
  filter(!is.na(dep_time), !is.na(arr_time)) %>% 
  mutate(
    dep_time = make_datetime_100(year, month, day, dep_time),
    arr_time = make_datetime_100(year, month, day, arr_time),
    sched_dep_time = make_datetime_100(year, month, day, sched_dep_time),
    sched_arr_time = make_datetime_100(year, month, day, sched_arr_time)
  ) %>% 
  select(origin, dest, ends_with("delay"), ends_with("time"))

flights_dt

flights_dt %>% 
  ggplot(aes(dep_time)) + 
  geom_freqpoly(binwidth = 86400) # 86400 seconds = 1 day

flights_dt %>% 
  filter(dep_time < ymd(20130102)) %>% 
  ggplot(aes(dep_time)) + 
  geom_freqpoly(binwidth = 600) # 600 s = 10 minutes

# 16.2.3 From other types

as_datetime(today())
as_date(now())

# We can use wday() to see that more flights depart during the week than on the weekend:
  
  flights_dt %>% 
  mutate(wday = wday(dep_time, label = TRUE)) %>% 
  ggplot(aes(x = wday)) +
  geom_bar()

  flights_dt %>% 
    mutate(minute = minute(dep_time)) %>% 
    group_by(minute) %>% 
    summarise(
      avg_delay = mean(arr_delay, na.rm = TRUE),
      n = n()) %>% 
    ggplot(aes(minute, avg_delay)) +
    geom_line()
  
 # Interestingly, if we look at the scheduled departure time we don’t see such a strong pattern:
    
    sched_dep <- flights_dt %>% 
    mutate(minute = minute(sched_dep_time)) %>% 
    group_by(minute) %>% 
    summarise(
      avg_delay = mean(arr_delay, na.rm = TRUE),
      n = n())
  
  ggplot(sched_dep, aes(minute, avg_delay)) +
    geom_line()
  
  #16.3.2 Rounding
#  An alternative approach to plotting individual components is to round the date 
  # to a nearby unit of time, with floor_date(), round_date(), and ceiling_date().
  
  flights_dt %>% 
    count(week = floor_date(dep_time, "week")) %>% 
    ggplot(aes(week, n)) +
    geom_line()
  
# 16.4 Time spans
  
#  durations, which represent an exact number of seconds.
# periods, which represent human units like weeks and months.
# intervals, which represent a starting and ending point.
  
  
  # How old is Hadley?
  h_age <- today() - ymd(19791014)
  h_age
  
  # 16.4.1 Durations
  as.duration(h_age)

  # 16.4.2 Periods + Intervals 
# To solve this problem, lubridate provides periods. 
# Periods are time spans but don’t have a fixed length in seconds, instead they work with “human” times, like days and months. 
  

#  An interval is a duration with a starting point: that makes it precise 
  # so you can determine exactly how long it is:
    
    next_year <- today() + years(1)
  (today() %--% next_year) / ddays(1)
  
     # 16.5 Time zones
    Sys.timezone()
head(OlsonNames())    

# Unless otherwise specified, lubridate always uses UTC. UTC (Coordinated Universal Time)
# is the standard time zone used by the scientific community and roughly equivalent to its predecessor GMT (Greenwich Mean Time).
# It does not have DST


# 17 Introduction 
# Chapter 14: Pipes with magrittr

install.packages("magrittr")
library (magrittr)

# you can use the “tee” pipe. %T>% works like %>% except that it returns
# the left-hand side instead of the right-hand side.

rnorm(100) %>%
  matrix(ncol = 2) %>%
  plot() %>%
  str()


rnorm(100) %>%
  matrix(ncol = 2) %T>%
  plot() %>%
  str()

# if you work with vectors not dataframes, %$% might be usefull

mtcars %$%
   cor(disp, mpg)

# For assignment magrittr provides the %<>% operator which allows you 
# to replace code like:

mtcars <- mtcars %>% 
  transform(cyl = cyl * 2)

#to

mtcars %<>% transform(cyl = cyl * 2)

# 19 Functions - Chapter 15 RDS

# 19.2 When should you write a function?

# You should consider writing a function whenever you’ve copied and pasted a block of code 
# more than twice (i.e. you now have three copies of the same code)

df <- tibble::tibble(
  a = rnorm(10),
  b = rnorm(10),
  c = rnorm(10),
  d = rnorm(10)
)

df$a <- (df$a - min(df$a, na.rm = TRUE)) / 
  (max(df$a, na.rm = TRUE) - min(df$a, na.rm = TRUE))
df$b <- (df$b - min(df$b, na.rm = TRUE)) / 
  (max(df$b, na.rm = TRUE) - min(df$a, na.rm = TRUE))
df$c <- (df$c - min(df$c, na.rm = TRUE)) / 
  (max(df$c, na.rm = TRUE) - min(df$c, na.rm = TRUE))
df$d <- (df$d - min(df$d, na.rm = TRUE)) / 
  (max(df$d, na.rm = TRUE) - min(df$d, na.rm = TRUE))

# this way
x <- df$a
(x - min(x, na.rm = TRUE)) / (max(x, na.rm = TRUE) - min(x, na.rm = TRUE))

rng <- range(x, na.rm = TRUE)
(x - rng[1]) / (rng[2] - rng[1])


# then write a function - rescale
rescale01 <- function(x) {
  rng <- range(x, na.rm = TRUE)
  (x - rng[1]) / (rng[2] - rng[1])
}
rescale01(c(0, 5, 10))

# test the function with different inputs

rescale01(c(-10, 0, 10))

# automated tests 
# http://r-pkgs.had.co.nz/tests.html 

# now apply  the function 

df$a <- rescale01(df$a)
df$b <- rescale01(df$b)
df$c <- rescale01(df$c)
df$d <- rescale01(df$d)

df

# 21 Iteration 

# 21.2 For loops

df <- tibble(
  a = rnorm(10),
  b = rnorm(10),
  c = rnorm(10),
  d = rnorm(10)
)

# if we want to compute medians for each column we can use loop

output <- vector("double", ncol(df))  # 1. output
for (i in seq_along(df)) {            # 2. sequence
  output[[i]] <- median(df[[i]])      # 3. body
}

# compute medians for every column in mtcars dataset

output <-vector("double", ncol(mtcars))
for (i in seq_along(mtcars)) {
  output[[i]] <-median(mtcars[[i]])
}
  
# load the required packages
library(nycflights13)

#explore nycflights 
nycflights13::flights


# a commit to resolve the conflict

# use while
# while (condition) {
# body
# }



# 21.5 The map functions

# map() makes a list.
# map_lgl() makes a logical vector.
# map_int() makes an integer vector.
# map_dbl() makes a double vector.
# map_chr() makes a character vector

# Each function takes a vector as input, applies a function to each piece, and then returns a new vector that’s the same length 
# (and has the same names) as the input

map_dbl(df, median)

map_dbl(df, mean)

# or using the pipe

df %>% map_dbl(mean)

df %>% map_dbl(median)

# Shortcuts

# e.g. fitting a linear model to a dataset

models <- mtcars %>% 
  split(.$cyl) %>% 
  map(function(df) lm(mpg ~ wt, data = df))

# with purr shortcut

models <- mtcars %>% 
  split(.$cyl) %>% 
  map(~lm(mpg ~ wt, data = .))

# adding R2
models %>% 
  map(summary) %>% 
  map_dbl(~.$r.squared)

# using  a sting as a shortcut

models %>% 
  map(summary) %>% 
  map_dbl("r.squared")

# 23 Model basics with modeler

# prerequisites
library(tidyverse)
library(modelr)
options(na.action = na.warn)

# simple model

ggplot(sim1, aes(x, y)) + 
  geom_point() + 
  theme_bw()


models <- tibble(
  a1 = runif(250, -20, 40),
  a2 = runif(250, -5, 5)
)

ggplot(sim1, aes(x, y)) + 
  geom_abline(aes(intercept = a1, slope = a2), data = models, alpha = 1/4) +
  geom_point()+
  theme_test()

#  we first turn our model family into an R function
model1 <- function(a, data) {
  a[1] + data$x * a[2]
}
model1(c(7, 1.5), sim1)

# next is to compute RMSE

measure_distance <- function(mod, data) {
  diff <- data$y - model1(mod, data)
  sqrt(mean(diff ^ 2))
}
measure_distance(c(7, 1.5), sim1)

# Now we can use purrr to compute the distance for all the models defined above

sim1_dist <- function(a1, a2) {
  measure_distance(c(a1, a2), sim1)
}

models <- models %>% 
  mutate(dist = purrr::map2_dbl(a1, a2, sim1_dist))
models

# Next, let’s overlay the 10 best models on to the data.

ggplot(sim1, aes(x, y)) + 
  geom_point(size = 2, colour = "grey30") + 
  geom_abline(
    aes(intercept = a1, slope = a2, colour = -dist), 
    data = filter(models, rank(dist) <= 10)
  ) +
  theme_test()

# We can also think about these models as observations,
#and visualising with a scatterplot of a1 vs a2, again coloured by -dist

ggplot(models, aes(a1, a2)) +
  geom_point(data = filter(models, rank(dist) <= 10), size = 4, colour = "red") +
  geom_point(aes(colour = -dist))+
  theme_linedraw()

# use grid search to select the best models

grid <- expand.grid(
  a1 = seq(-5, 20, length = 25),
  a2 = seq(1, 3, length = 25)
) %>% 
  mutate(dist = purrr::map2_dbl(a1, a2, sim1_dist))

grid %>% 
  ggplot(aes(a1, a2)) +
  geom_point(data = filter(grid, rank(dist) <= 10), size = 4, colour = "red") +
  geom_point(aes(colour = -dist)) +
               theme_test()

# When you overlay the best 10 models back on the original data, they all look pretty good:

ggplot(sim1, aes(x, y)) + 
  geom_point(size = 2, colour = "grey30") + 
  geom_abline(
    aes(intercept = a1, slope = a2, colour = -dist), 
    data = filter(grid, rank(dist) <= 10)
  )+
  theme_light()

# a numerical minimisation tool called Newton-Raphson search

best <- optim(c(0, 0), measure_distance, data = sim1)
best$par

ggplot(sim1, aes(x, y)) + 
  geom_point(size = 2, colour = "grey30") + 
  geom_abline(intercept = best$par[1], slope = best$par[2])+
  theme_test()

# linear models using lm () function of R

sim1_mod <- lm(y ~ x, data = sim1)
coef(sim1_mod)

# exercise 
sim1a <- tibble(
  x = rep(1:10, each = 3),
  y = x * 1.5 + 6 + rt(length(x), df = 2)
)

ggplot(sim1a, aes(x, y)) + 
  geom_point(size = 2, colour = "red") + 
  geom_abline(intercept = best$par[1], slope = best$par[2])+
  theme_test()

best1 <- optim(c(0, 0), measure_distance, data = sim1a)

ggplot(sim1a, aes(x, y)) + 
  geom_point(size = 2, colour = "blue") + 
  geom_abline(intercept = best1$par[1], slope = best1$par[2])+
  theme_test()

#instead of root-mean-squared distance, you could use mean-absolute distance:

measure_distance <- function(mod, data) {
  diff <- data$y - model1(mod, data)
  mean(abs(diff))
}

best2 <- optim(c(0, 0), measure_distance, data = sim1a)
best$par

ggplot(sim1a, aes(x, y)) + 
  geom_point(size = 2, colour = "yellow") + 
  geom_abline(intercept = best2$par[1], slope = best2$par[2])+
  theme_test()

model1 <- function(a, data) {
  a[1] + data$x * a[2] + a[3]
}

# 23.3 Visualising models 

# It’s also useful to see what the model doesn’t capture, the so-called residuals 
#which are left after subtracting the predictions from the data. #
#Residuals are powerful because they allow us to use models to remove striking patterns so
# we can study the subtler trends that remain.

# Predictions

# The easiest way to do generate a grid of values  is to use modelr::data_grid()

grid <- sim1 %>% 
  data_grid(x) 
grid

# add predictions  and plot them

grid <- grid %>% 
  add_predictions(sim1_mod) 
grid

ggplot(sim1, aes(x)) +
  geom_point(aes(y = y)) +
  geom_line(aes(y = pred), data = grid, colour = "red", size = 1)+
  theme_test()

# how to visualise more complex models
# http://vita.had.co.nz/papers/model-vis.html
# the paper http://vita.had.co.nz/papers/model-vis.pdf 

sim1 <-sim1 %>% 
  add_residuals(sim1_mod)
sim1

# add frequency polygon to understand the spread of the residuals

ggplot(sim1, aes(resid)) + 
  geom_freqpoly(binwidth = 0.5)

# recreating the plot with residuals
ggplot(sim1, aes(x, resid)) + 
  geom_ref_line(h = 0) +
  geom_point()

# Exercises
# using loess() to fit the smooth curve

sim2_mod <- loess(y ~ x, data = sim1)
ggplot(sim1, aes(x, y)) + 
  geom_point(size = 2, colour = "blue") + 
  geom_smooth() +
    theme_test()

# adding horizontal line with geom_ref_line ()

sim2_mod <- loess(y ~ x, data = sim1)
ggplot(sim1, aes(x, y)) + 
  geom_point(size = 2, colour = "blue") + 
  geom_smooth() +
  geom_ref_line(h=15,  v=5, colour = "black", size = 1)+
  theme_test()

# 23.4 Formulas and model families

df <- tribble(
  ~y, ~x1, ~x2,
  4, 2, 5,
  5, 1, 6
)

# using model matrix () the model_matrix() function. 
# it takes a data frame and a formula and returns a tibble that defines the model equation: 

model_matrix(df, y ~ x1)
model_matrix(df, y ~ x1 - 1)
model_matrix(df, y ~ x1 + x2)

#“Wilkinson-Rogers notation”, and was initially described in 
# Symbolic Description of Factorial Models for Analysis of Variance, by
# G. N. Wilkinson and C. E. Rogers
# https://www.jstor.org/stable/2346786?seq=1 

# 23.4.1 Categorical variables 

#coding categorical into a number
df <- tribble(
  ~ sex, ~ response,
  "male", 1,
  "female", 2,
  "male", 1
)
df

model_matrix(df, response ~ sex)

# the sim2 dataset from modelr:
  
  ggplot(sim2) + 
  geom_point(aes(x, y))

  # fitting the model
  
  mod2 <- lm(y ~ x, data = sim2)
  
  grid <- sim2 %>% 
    data_grid(x) %>% 
    add_predictions(mod2)
  grid
  
  ggplot(sim2, aes(x)) + 
    geom_point(aes(y = y)) +
    geom_point(data = grid, aes(y = pred), colour = "red", size = 4)

  # 23.4.2 Interactions (continuous and categorical) 
  
  head(sim3)
  
  ggplot(sim3, aes(x1, y)) + 
    geom_point(aes(colour = x2))
  
  ggplot(sim3, aes(x1, y)) + 
    geom_boxplot(aes(colour = x2))
  
  ggplot(sim3, aes(x1, y)) + 
    geom_violin(aes(colour = x2))
    
# There are two possible models you could fit to this data:
  
# When you add variables with +, the model will estimate each effect independent of all the others.
  mod1 <- lm(y ~ x1 + x2, data = sim3)
  # It’s possible to fit the so-called interaction by using *
  mod2 <- lm(y ~ x1 * x2, data = sim3)

# use data_grid() for 2 variables + gather_prediction() & spread_predictions() to add rows, columns
  grid <- sim3 %>% 
    data_grid(x1, x2) %>% 
    gather_predictions(mod1, mod2)
  grid  

  ggplot(sim3, aes(x1, y, colour = x2)) + 
    geom_point() + 
    geom_line(data = grid, aes(y = pred)) + 
    facet_wrap(~ model)+
    theme_test()

  # which model is the best?
  # gather the residuals
  sim3 <- sim3 %>% 
    gather_residuals(mod1, mod2)
  # plot the residuals
    ggplot(sim3, aes(x1, resid, colour = x2)) + 
    geom_point() + 
    facet_grid(model ~ x2)+
      theme_minimal()
    
# 23.4.3 Interactions (two continuous) with sim4
    library(modelr)
    
    head(sim4)
    mod1 <- lm(y ~ x1 + x2, data = sim4)
    mod2 <- lm(y ~ x1 * x2, data = sim4)

    # Note my use of seq_range() inside data_grid(). Instead of using every unique value of x
    grid <- sim4 %>% 
      data_grid(
        x1 = seq_range(x1, 5), 
        x2 = seq_range(x2, 5) 
      ) %>% 
      gather_predictions(mod1, mod2)
    grid

    # on using seq_range()  
    # pretty = TRUE will generate a “pretty” sequence
    
    seq_range(c(0.0123, 0.923423), n = 5)
    seq_range(c(0.0123, 0.923423), n = 5, pretty = TRUE)
    
    # trim = 0.1 will trim off 10% of the tail values
    
    x1 <- rcauchy(100)
    seq_range(x1, n = 5)
    seq_range(x1, n = 5, trim = 0.10)
    seq_range(x1, n = 5, trim = 0.25)
    seq_range(x1, n = 5, trim = 0.50)
    
    # expand = 0.1 is in some sense the opposite of trim() it expands the range by 10%
    
# Next let’s try and visualise that model.
    
    ggplot(grid, aes(x1, x2)) + 
      geom_tile(aes(fill = pred)) + 
      facet_wrap(~ model)

    ggplot(grid, aes(x1, pred, colour = x2, group = x2)) + 
      geom_line() +
      facet_wrap(~ model)
    ggplot(grid, aes(x2, pred, colour = x1, group = x1)) + 
      geom_line() +
      facet_wrap(~ model)    

#23.4.4 Transformations 
    # You can also perform transformations inside the model formula.
    # If your transformation involves +, *, ^, or -, you’ll need to wrap it in I() 
    # so R doesn’t treat it like part of the model specification.
    
    df <- tribble(
      ~y, ~x,
      1,  1,
      2,  2, 
      3,  3
    )
  # use model_matrix () to see what the model is fitting
        model_matrix(df, y ~ x^2 + x)
        model_matrix(df, y ~ I(x^2) + x) 
  # Transformations are useful because you can use them to approximate non-linear functions. 
  # use poly() to fit a polynomial function 
        
        model_matrix(df, y ~ poly(x, 2))
  # poly(): outside the range of the data
  # polynomials rapidly shoot off to positive or negative infinity.    
        # then use natural spline
        
        library(splines)
        model_matrix(df, y ~ ns(x, 2))      
    
        # Let’s see what that looks like when we try and approximate a non-linear function: 
        sim5 <- tibble(
          x = seq(0, 3.5 * pi, length = 50),
          y = 4 * sin(x) + rnorm(length(x))
        )
        
        ggplot(sim5, aes(x, y)) +
          geom_point()
        
    # I’m going to fit five models to this data.
        
        mod1 <- lm(y ~ ns(x, 1), data = sim5)
        mod2 <- lm(y ~ ns(x, 2), data = sim5)
        mod3 <- lm(y ~ ns(x, 3), data = sim5)
        mod4 <- lm(y ~ ns(x, 4), data = sim5)
        mod5 <- lm(y ~ ns(x, 5), data = sim5)
        
        grid <- sim5 %>% 
          data_grid(x = seq_range(x, n = 50, expand = 0.1)) %>% 
          gather_predictions(mod1, mod2, mod3, mod4, mod5, .pred = "y")
        
        ggplot(sim5, aes(x, y)) + 
          geom_point() +
          geom_line(data = grid, colour = "red") +
          facet_wrap(~ model)
#  23.5 Missing values
        # R’s default behaviour is to silently drop them, but options(na.action = na.warn)
        
        df <- tribble(
          ~x, ~y,
          1, 2.2,
          2, NA,
          3, 3.5,
          4, 8.3,
          NA, 10
        )
        
        mod <- lm(y ~ x, data = df)
#  To suppress the warning, set na.action = na.exclude 
        
        mod <- lm(y ~ x, data = df, na.action = na.exclude) 
        mod <- lm(y ~ x, data = df, na.action = na.warn) 
        mod <- lm(y ~ x, data = df) 
# You can always see exactly how many observations were used with nobs():
          
          nobs(mod)
# 23.6 Other model families
          
# Generalised linear models, e.g. stats::glm() 
          
# Generalised additive models, e.g. mgcv::gam()
          #extend generalised linear models to incorporate arbitrary smooth functions.
          
# Penalised linear models, e.g. glmnet::glmnet()
          # add a penalty term to the distance that penalises complex models
          
# Robust linear models, e.g. MASS::rlm(), tweak the distance to downweight points that are very far away. 

# Trees, e.g. rpart::rpart(), attack the problem in a completely different way than linear models.
          
          
          # 24 Model building
    # https://r4ds.had.co.nz/model-building.html 
          
  # Prerequisites
          
          library(tidyverse)
          library(modelr)
          options(na.action = na.warn)
          
          library(nycflights13)
          library(lubridate)
          
# 24.2 Why are low quality diamonds more expensive?
          
          ggplot(diamonds, aes(cut, price)) + geom_boxplot()+theme_test()
          ggplot(diamonds, aes(color, price)) + geom_boxplot()+theme_test()
          ggplot(diamonds, aes(clarity, price)) + geom_boxplot()+theme_test()

    # 24.2.1 Price and carat
          ggplot(diamonds, aes(carat, price)) + 
            geom_hex(bins = 50)+
            theme_test()
    # Focus on diamonds smaller than 2.5 carats (99.7% of the data)
    #Log-transform the carat and price variables.
  
           diamonds2 <- diamonds %>% 
            filter(carat <= 2.5) %>% 
            mutate(lprice = log2(price), lcarat = log2(carat))            
          
           # and look at the dataset again
           ggplot(diamonds2, aes(lcarat, lprice)) + 
             geom_hex(bins = 50)+
             theme_test()
           
 # first let's fit the model           
           mod_diamond <- lm(lprice ~ lcarat, data = diamonds2)
           
           # undo the log transform and add prediction on the data

           grid <- diamonds2 %>% 
             data_grid(carat = seq_range(carat, 20)) %>% 
             mutate(lcarat = log2(carat)) %>% 
             add_predictions(mod_diamond, "lprice") %>% 
             mutate(price = 2 ^ lprice)
           
           ggplot(diamonds2, aes(carat, price)) + 
             geom_hex(bins = 50) + 
             geom_line(data = grid, colour = "red", size = 1)+
             theme_test()
           
      # Now we can look at the residuals
           
           diamonds2 <- diamonds2 %>% 
             add_residuals(mod_diamond, "lresid")
           
           ggplot(diamonds2, aes(lcarat, lresid)) + 
             geom_hex(bins = 50)+ 
             theme_test()
# redoing our boxplots using residuals instead of price
           ggplot(diamonds2, aes(cut, lresid)) + geom_boxplot()+theme_test()
           ggplot(diamonds2, aes(color, lresid)) + geom_boxplot()+theme_test()
           ggplot(diamonds2, aes(clarity, lresid)) + geom_boxplot()+theme_test()
           
        #24.2.2 A more complicated model
           
# we could include color, cut, and clarity into the model (+ means predictors are independent)
mod_diamond2 <- lm(lprice ~ lcarat + color + cut + clarity, data = diamonds2)

# To make the process a little easier, we’re going to use the .model argument to data_grid:
grid <- diamonds2 %>% 
  data_grid(cut, .model = mod_diamond2) %>% 
  add_predictions(mod_diamond2)
grid

ggplot(grid, aes(cut, pred)) + 
  geom_point()
   
diamonds2 <- diamonds2 %>% 
  add_residuals(mod_diamond2, "lresid2")

ggplot(diamonds2, aes(lcarat, lresid2)) + 
  geom_hex(bins = 50)+
  theme_test()

# look at the diamonds with large residuals 

diamonds2 %>% 
  filter(abs(lresid2) > 1) %>% 
  add_predictions(mod_diamond2) %>% 
  mutate(pred = round(2 ^ pred)) %>% 
  select(price, pred, carat:table, x:z) %>% 
  arrange(price)

# 24.3 What affects the number of daily flights? 
 #Let’s work through a similar process for a dataset that seems even simpler at first glance: 
 # the number of flights that leave NYC per day.

head(flights)

daily <- flights %>% 
  mutate(date = make_date(year, month, day)) %>% 
  group_by(date) %>% 
  summarise(n = n())

ggplot(daily, aes(date, n)) + 
  geom_line()

# Day of the week
# Note: wday() returns the day of the week as a decimal number or an ordered factor if label is TRUE. (lubridate)
daily <- daily %>% 
  mutate(wday = wday(date, label = TRUE))
ggplot(daily, aes(wday, n)) + 
  geom_boxplot()+
  theme_test()

is.Date(daily$date)

# Sunday is least busiest day for flights
# let' fit the model and adde predictions to the origianal data
mod <- lm(n ~ wday, data = daily)

grid <- daily %>% 
  data_grid(wday) %>% 
  add_predictions(mod, "n")

ggplot(daily, aes(wday, n)) + 
  geom_boxplot() +
  geom_point(data = grid, colour = "red", size = 4)+
  theme_linedraw()
# next compute and visualize the residuals

daily <- daily %>% 
  add_residuals(mod)
daily %>% 
  ggplot(aes(date, resid)) + 
  geom_ref_line(h = 0) + 
  geom_line()

# the residuals show that the model fail starting around June
# let's draw the lines for each day of the week

ggplot(daily, aes(date, resid, colour = wday)) + 
  geom_ref_line(h = 0) + 
  geom_line() 

# There are some days with far fewer flights than expected: puplic holiday the other days
  
  daily %>% 
  filter(resid < -100)

# there is a smoother long-term trend:
  
  daily %>% 
    ggplot(aes(date, resid)) + 
    geom_ref_line(h = 0) + 
    geom_line(colour = "grey50") + 
    geom_smooth(se = FALSE, span = 0.20)
  
  # 24.3.2 Seasonal Saturday effect: filtering Sundays and making time-series 

  daily %>% 
    filter(wday == "Sat") %>% 
    ggplot(aes(date, n)) + 
    geom_point() + 
    geom_line() +
    scale_x_date(NULL, date_breaks = "1 month", date_labels = "%b")+
    theme_bw()
# Lets create a “term” variable that roughly captures the three school terms, and check our work with a plot:
  
  term <- function(date) {
    cut(date, 
        breaks = ymd(20130101, 20130605, 20130825, 20140101),
        labels = c("spring", "summer", "fall") 
    )
  }
  
  daily <- daily %>% 
    mutate(term = term(date)) 
  
  daily %>% 
    filter(wday == "Sat") %>% 
    ggplot(aes(date, n, colour = term)) +
    geom_point(alpha = 1/3) + 
    geom_line() +
    scale_x_date(NULL, date_breaks = "1 month", date_labels = "%b")+
    theme_classic()
# using boxlots with terms varialbe 
  
  daily %>% 
    ggplot(aes(wday, n, colour = term)) +
    geom_boxplot()+
    theme_test()
  
#  so fitting a separate day of week effect for each term is reasonable, but
# it does not significantly improves the model
  
  mod1 <- lm(n ~ wday, data = daily)
  mod2 <- lm(n ~ wday * term, data = daily)
  
  daily %>% 
    gather_residuals(without_term = mod1, with_term = mod2) %>% 
    ggplot(aes(date, resid, colour = model)) +
    geom_line(alpha = 0.75)+
    theme_test()
  
  grid <- daily %>% 
    data_grid(wday, term) %>% 
    add_predictions(mod2, "n")
  
  ggplot(daily, aes(wday, n)) +
    geom_boxplot() + 
    geom_point(data = grid, colour = "red") + 
    facet_wrap(~ term)+
    theme_test()
# Our model is finding the mean effect, but we have a lot of big outliers
# We can alleviate this problem by using a model that is robust to the effect of outliers: MASS::rlm()
  mod3 <- MASS::rlm(n ~ wday * term, data = daily)
  
  daily %>% 
    add_residuals(mod3, "resid") %>% 
    ggplot(aes(date, resid)) + 
    geom_hline(yintercept = 0, size = 2, colour = "white") + 
    geom_line()+ 
    theme_bw()
  
#24.3.3 Computed variables
  # Bundling the computed variables into a function
  
  compute_vars <- function(data) {
    data %>% 
      mutate(
        term = term(date), 
        wday = wday(date, label = TRUE)
      )
  }
  
  # another option is to put transformation directly into  the model formula
  
  wday2 <- function(x) wday(x, label = TRUE)
  mod3 <- lm(n ~ wday2(date) * term(date), data = daily)
  
# 24.3.4 Time of year: an alternative approach
#  simple linear trend isn’t adequate, so we could try using 
# a natural spline to fit a smooth curve across the year: 
  
  library(splines)
  mod <- MASS::rlm(n ~ wday * ns(date, 5), data = daily)
  
  daily %>% 
    data_grid(wday, date = seq_range(date, n = 13)) %>% 
    add_predictions(mod) %>% 
    ggplot(aes(date, pred, colour = wday)) + 
    geom_line() +
    geom_point()+ 
    theme_test()
  
# 24.4 Learning more about models
  
  
  #25 Many models
  
  # 1. In list-columns, you’ll learn more about the list-column data structure
  # 2. In creating list-columns, you’ll learn the three main ways in which you’ll create list-columns.
  # 3. In simplifying list-columns you’ll learn how to convert list-columns back to regular atomic vectors
  # 4. In making tidy data with broom, you’ll learn about the full set of tools provided by broom 
  
  library(modelr)
  library(tidyverse)

  # 25.2 gapminder
  
 # Hans Rosling's 200 Countries, 200 Years, 4 Minutes - The Joy of Stats - BBC Four 
 # https://www.youtube.com/watch?v=jbkSRLYSojo
  install.packages("gapminder")

  library(gapminder)
  
  # How does life expectancy (lifeExp) change over time (year) for each country (country)?
  
  gapminder %>% 
    ggplot(aes(year, lifeExp, group = country)) +
    geom_line(alpha = 1/3)+
    theme_test()

  nz <- filter(gapminder, country == "New Zealand")
  nz %>% 
    ggplot(aes(year, lifeExp)) + 
    geom_line() + 
    ggtitle("Full data = ")
  
  nz_mod <- lm(lifeExp ~ year, data = nz)
  nz %>% 
    add_predictions(nz_mod) %>%
    ggplot(aes(year, pred)) + 
    geom_line() + 
    ggtitle("Linear trend + ")
  
  nz %>% 
    add_residuals(nz_mod) %>% 
    ggplot(aes(year, resid)) + 
    geom_hline(yintercept = 0, colour = "red", size = 0.1) + 
    geom_line() + 
    theme_test()+
    ggtitle("Remaining pattern")
  
  
  # 25.2.1 Nested data
  # nested data frame  - that is important 
  
  by_country <- gapminder %>% 
    group_by(country, continent) %>% 
    nest()
  
  by_country
  by_country$data[[1]]

# a nested dataset is we now have a meta-observation: a row that represents 
# the complete time course for a country, rather than a single point in time!
  
  # 25.2.2 List-columns 
  # now fitting the model into nested dataframe
  
  country_model <- function(df) {
    lm(lifeExp ~ year, data = df)
  }

#The data frames are in a list, so we can use purrr::map() 
# to apply country_model to each element:
    
    models <- map(by_country$data, country_model)  
  
# however, instead of creating a new object in the global environment,
# we’re going to create a new variable in the by_country data frame.
# That’s a job for dplyr::mutate():

    by_country <- by_country %>% 
      mutate(model = map(data, country_model))
    by_country

    # now you can filter and arrange 
    
    by_country %>% 
      filter(continent == "Europe")
    
    by_country %>% 
      arrange(continent, country)
    
    # 25.2.3 Unnesting  
# To compute the residuals, we need to call add_residuals() with each model-data pair:
    
    by_country <- by_country %>% 
      mutate(
        resids = map2(data, model, add_residuals)
      )
    by_country

# let's turn the list of DFs into a regular DF with unnest()
    
    resids <- unnest(by_country, resids)
    resids    
    
    # now we can plot residusals 
    resids %>% 
      ggplot(aes(year, resid)) +
      geom_line(aes(group = country), alpha = 1 / 3) + 
      geom_smooth(se = FALSE)+
      theme_test()
    
    # Facetting by continent is particularly revealing:
      
      resids %>% 
      ggplot(aes(year, resid, group = country)) +
      geom_line(alpha = 1 / 3) + 
      facet_wrap(~continent)+
        theme_light()

     # 25.2.4 Model quality
      
      #The broom package provides a general set of functions to turn models into tidy data.
      #Here we’ll use broom::glance() to extract some model quality metrics. 
      
      broom::glance(nz_mod)
      
 #We can use mutate() and unnest() to create a data frame with a row for each country:
      
      by_country %>% 
        mutate(glance = map(model, broom::glance)) %>% 
        unnest(glance)
  # it still includes all the list columns. 
  # To suppress these columns we use .drop = TRUE:
      
      glance <- by_country %>% 
        mutate(glance = map(model, broom::glance)) %>% 
        unnest(glance, .drop = TRUE)
      
      glance

# With this data frame in hand, we can start to look for models that don’t fit well:
        
        glance %>% 
        arrange(r.squared)
# The worst models all appear to be in Africa. Let’s double check that with a plot. 
        
        glance %>% 
          ggplot(aes(continent, r.squared)) + 
          geom_jitter(width = 0.5)+
          theme_test()
      
        glance %>% 
          ggplot(aes(continent, r.squared)) + 
          geom_boxplot(width = 0.5)+
          theme_test()
        
# let's filter out bad R2 data and plot it
        bad_fit <- filter(glance, r.squared < 0.25)
        
          gapminder %>% 
          semi_join(bad_fit, by = "country") %>% 
          ggplot(aes(year, lifeExp, colour = country)) +
          geom_line()+
          theme_test()
         
    # 25.3 List-columns
    # https://r4ds.had.co.nz/many-models.html#list-columns-1    
      
          # data.frame() treats a list as a list of columns:    
          data.frame(x = list(1:3, 3:5))
          
          # you can prevent data.frame() from doing this with I()
          
          data.frame(
            x = I(list(1:3, 3:5)), 
            y = c("1, 2", "3, 4, 5")
          )
          
# Tibble alleviates this problem by being lazier (tibble() doesn’t modify its inputs) 
# and by providing a better print method:
          
          tibble(
            x = list(1:3, 3:5), 
            y = c("1, 2", "3, 4, 5")
          )
          
          tribble(
            ~x, ~y,
            1:3, "1, 2",
            3:5, "3, 4, 5"
          )
          
 # List-columns are often most useful as intermediate data structure
          # 25.4 Creating list-columns
.            
# 25.4.1 With nesting
      # 1 tidyr::nest()
# nest() creates a nested data frame, which is a data frame with a list-column of data frames. 
# There are two ways to use nest()

gapminder %>% 
  group_by(country, continent) %>% 
  nest()

# You can also use it on an ungrouped data frame, specifying which columns you want to nest:
  
  gapminder %>% 
  nest(data = c(year:gdpPercap))
          
  # 25.4.2 From vectorised functions        
  # Some useful functions take an atomic vector and return a list.            
  
  df <- tribble(
    ~x1,
    "a,b,c", 
    "d,e,f,g"
  )         

df %>% 
  mutate(x2 = stringr::str_split(x1, ","))

# unnest() knows how to handle these lists of vectors:          
df %>% 
  mutate(x2 = stringr::str_split(x1, ",")) %>% 
  unnest(x2)

#Another example of this pattern is using the map(), map2(), pmap() from purrr. 

sim <- tribble(
  ~f,      ~params,
  "runif", list(min = -1, max = 1),
  "rnorm", list(sd = 5),
  "rpois", list(lambda = 10)
)

sim %>%
  mutate(sims = invoke_map(f, params, n = 10))

# 25.4.3 From multivalued summaries
# you can wrap the summarise() results in the list 

mtcars %>% 
  group_by(cyl) %>% 
  summarise(q = list(quantile(mpg)))
# To make useful results with unnest, you’ll also need to capture the probabilities:

probs <- c(0.01, 0.25, 0.5, 0.75, 0.99)
mtcars %>% 
  group_by(cyl) %>% 
  summarise(p = list(probs), q = list(quantile(mpg, probs))) %>% 
  unnest(c(p, q))

# 25.4.4 From a named list

x <- list(
  a = 1:5,
  b = 3:4, 
  c = 5:6
) 

df <- enframe(x)
df

# Now if you want to iterate over names and values in parallel, you can use map2():
  
  df %>% 
  mutate(
    smry = map2_chr(name, value, ~ stringr::str_c(.x, ": ", .y[1]))
  )

# 25.5 Simplifying list-columns 
  
#  If you want a single value, use mutate() with map_lgl(), map_int(), map_dbl(), and map_chr() 
# to create an atomic vector.
  
  # 25.5.1 List to vector
  
  df <- tribble(
    ~x,
    letters[1:5],
    1:3,
    runif(5)
  )
  
  df %>% mutate(
    type = map_chr(x, typeof),
    length = map_int(x, length)
  )
# Don’t forget about the map_*() shortcuts - you can use map_chr(x, "apple")
# to extract the string stored in apple for each element of x.   
  
  df <- tribble(
    ~x,
    list(a = 1, b = 2),
    list(a = 2, c = 4)
  )
  df %>% mutate(
    a = map_dbl(x, "a"),
    b = map_dbl(x, "b", .null = NA_real_)
  )
  
  # If you want many values, use unnest() to convert list-columns back to regular columns,
  # repeating the rows as many times as necessary.
  
  
  tibble(x = 1:2, y = list(1:4, 1)) %>% unnest(y)
  
  # Ok, because y and z have the same number of elements in
  # every row
  df1 <- tribble(
    ~x, ~y,           ~z,
    1, c("a", "b"), 1:2,
    2, "c",           3
  )
  df1

  df1 %>% unnest(c(y, z))
  
  
  # Doesn't work because y and z have different number of elements
  df2 <- tribble(
    ~x, ~y,           ~z,
    1, "a",         1:2,  
    2, c("b", "c"),   3
  )
  df2
  df2 %>% unnest(c(y, z))
  
  
  # 25.6 Making tidy data with broom 
  
  # The broom package provides three general tools
  
  # 1.broom::glance(model) returns a row for each model. 
  # 2. broom::tidy(model) returns a row for each coefficient in the model. 
  # 3. broom::augment(model, data) returns a row for each row in data, 
  # adding extra values like residuals, and influence statistics.
  
  

  # 27 R Markdown
  
  #  https://rstudio.com/resources/cheatsheets/ 
  
  # 27.2 R Markdown basics
    library(knitr)
  # http://yihui.name/knitr/
  # I made a test rds.Rmd file with some test for markdown
  
  #  28 Graphics for communication with ggplot2
  # https://r4ds.had.co.nz/graphics-for-communication.html 
  
  
  library(tidyverse) 
  
  # 28.2 Label
  
# You add labels with the labs() function.  
  
  ggplot(mpg, aes(displ, hwy)) +
    geom_point(aes(color = class)) +
    geom_smooth(se = FALSE) +
    labs(title = "Fuel efficiency generally decreases with engine size")+
    theme_test ()
    
  ggplot(mpg, aes(displ, hwy)) +
    geom_point(aes(color = class)) +
    geom_smooth(se = TRUE) +
    labs(title = "Fuel efficiency generally decreases with engine size")+
    theme_test ()

  # subtitle adds additional detail in a smaller font beneath the title.
  # caption adds text at the bottom right of the plot, often used to describe the source of the data.
    
  ggplot(mpg, aes(displ, hwy)) +
    geom_point(aes(color = class)) +
    geom_smooth(se = FALSE) +
    labs(
      title = "Fuel efficiency generally decreases with engine size",
      subtitle = "Two seaters (sports cars) are an exception because of their light weight",
      caption = "Data from fueleconomy.gov"
    )+
    theme_test()
  
  # You can also use labs() to replace the axis and legend titles.
  
  ggplot(mpg, aes(displ, hwy)) +
    geom_point(aes(colour = class)) +
    geom_smooth(se = FALSE) +
    labs(
      x = "Engine displacement (L)",
      y = "Highway fuel economy (mpg)",
      colour = "Car type"
    )+
    theme_classic()
# It’s possible to use mathematical equations instead of text strings. 
# Just switch "" out for quote() and read about the available options in ?plotmath:  
  
  df <- tibble(
    x = runif(10),
    y = runif(10)
  )
  ggplot(df, aes(x, y)) +
    geom_point() +
    labs(
      x = quote(sum(x[i] ^ 2, i == 1, n)),
      y = quote(alpha + beta + frac(delta, theta))
    )+
    theme_test()

# 28.3 Annotations
  
  #  https://r4ds.had.co.nz/graphics-for-communication.html#annotations 
  #  geom_text() is similar to geom_point(), but it has an additional aesthetic: label.
  
  best_in_class <- mpg %>%
    group_by(class) %>%
    filter(row_number(desc(hwy)) == 1)
  
  ggplot(mpg, aes(displ, hwy)) +
    geom_point(aes(colour = class)) +
    geom_text(aes(label = model), data = best_in_class)+
    theme_test()
  
  ggplot(mpg, aes(displ, hwy)) +
    geom_point(aes(colour = class)) +
    geom_label(aes(label = model), data = best_in_class, nudge_y = 2, alpha = 0.5)+
    theme_test()
  
  # use use the ggrepel package to adjust lable positions
  
  ggplot(mpg, aes(displ, hwy)) +
    geom_point(aes(colour = class)) +
    geom_point(size = 3, shape = 1, data = best_in_class) +
    ggrepel::geom_label_repel(aes(label = model), data = best_in_class)+
    theme_test()
  
  # theme(legend.position = "none")
  
  class_avg <- mpg %>%
    group_by(class) %>%
    summarise(
      displ = median(displ),
      hwy = median(hwy)
    )
  #> `summarise()` ungrouping output (override with `.groups` argument)
  
  ggplot(mpg, aes(displ, hwy, colour = class)) +
    ggrepel::geom_label_repel(aes(label = class),
                              data = class_avg,
                              size = 6,
                              label.size = 0,
                              segment.color = NA
    ) +
    geom_point() +
    theme(legend.position = "none")+
    theme_test()
# reate a new data frame using summarise() to compute the maximum values of x and y.
  
  label <- mpg %>%
    summarise(
      displ = max(displ),
      hwy = max(hwy),
      label = "Increasing engine size is \nrelated to decreasing fuel economy."
    )
  
  ggplot(mpg, aes(displ, hwy)) +
    geom_point() +
    geom_text(aes(label = label), data = label, vjust = "top", hjust = "right")+
    theme_test()
  
# If you want to place the text exactly on the borders of the plot, you can use +Inf and -Inf.
  
  label <- tibble(
    displ = Inf,
    hwy = Inf,
    label = "Increasing engine size is \nrelated to decreasing fuel economy."
  )
  
  ggplot(mpg, aes(displ, hwy)) +
    geom_point() +
    geom_text(aes(label = label), data = label, vjust = "top", hjust = "right")+
    theme_test()
  
# Another approach is to use stringr::str_wrap() to automatically add line breaks
  
  "Increasing engine size is related to decreasing fuel economy." %>%
    stringr::str_wrap(width = 40) %>%
    writeLines()
  #> Increasing engine size is related to
  #> decreasing fuel economy.
  
 # Use geom_hline() and geom_vline() to add reference lines. 
  
 # Use geom_rect() to draw a rectangle around points of interest. 
 # The boundaries of the rectangle are defined by aesthetics xmin, xmax, ymin, ymax.
  
 # Use geom_segment() with the arrow argument to draw attention to a point with an arrow. 
  
  # 28.4 Scales 
  
  ggplot(mpg, aes(displ, hwy)) +
    geom_point(aes(colour = class))+
    theme_test()

  # that means that ggplot added
  
  ggplot(mpg, aes(displ, hwy)) +
    geom_point(aes(colour = class)) +
    scale_x_continuous() +
    scale_y_continuous() +
    scale_colour_discrete()
  
  # 28.4.1 Axis ticks and legend keys
  # arguments breaks() controll the ticks
  
  ggplot(mpg, aes(displ, hwy)) +
    geom_point() +
    scale_y_continuous(breaks = seq(15, 40, by = 5))+
    theme_test()
  
  # labels can be use in the same way 
  
  ggplot(mpg, aes(displ, hwy)) +
    geom_point() +
    scale_x_continuous(labels = NULL) +
    scale_y_continuous(labels = NULL)+
    theme_bw()
  
# this is an interesting plot
    presidential %>%
    mutate(id = 33 + row_number()) %>%
    ggplot(aes(start, id)) +
    geom_point() +
    geom_segment(aes(xend = end, yend = id)) +
    scale_x_date(NULL, breaks = presidential$start, date_labels = "'%y")+
    theme_bw()
  
  # date_labels takes a format specification, in the same form as parse_datetime().
  # date_breaks (not shown here), takes a string like “2 days” or “1 month”.
    
    # 28.4.2 Legend layout
    # control the theme() setting
    
    base <- ggplot(mpg, aes(displ, hwy)) +
      geom_point(aes(colour = class))
    
    base + theme(legend.position = "left")
    base + theme(legend.position = "top")
    base + theme(legend.position = "bottom")
    base + theme(legend.position = "right") # default
    
    #To control the display of individual legends, use guides() along with guide_legend() 
    # or guide_colourbar(). 
    
    ggplot(mpg, aes(displ, hwy)) +
      geom_point(aes(colour = class)) +
      geom_smooth(se = FALSE) +
      theme(legend.position = "bottom") +
      guides(colour = guide_legend(nrow = 1, override.aes = list(size = 4)))
         #> `geom_smooth()` using method = 'loess' and formula 'y ~ x'
    
    # 28.4.3 Replacing a scale
    ggplot(diamonds, aes(carat, price)) +
      geom_bin2d()+
      theme_bw()
    
    ggplot(diamonds, aes(log10(carat), log10(price))) +
      geom_bin2d()+
      theme_test()
    
    # log transfroming the scale instead
    ggplot(diamonds, aes(carat, price)) +
      geom_bin2d() + 
      scale_x_log10() + 
      scale_y_log10()
  
    # alternatives are the ColorBrewer scales
    
    ggplot(mpg, aes(displ, hwy)) +
      geom_point(aes(color = drv))
    
    ggplot(mpg, aes(displ, hwy)) +
      geom_point(aes(color = drv)) +
      scale_colour_brewer(palette = "Set1")+
      theme_test()
    
  # Don’t forget simpler techniques like mapping the shape 
    
    ggplot(mpg, aes(displ, hwy)) +
      geom_point(aes(color = drv, shape = drv)) +
      scale_colour_brewer(palette = "Set1")+
      theme_test()
    # The ColorBrewer scales are documented online at http://colorbrewer2.org/
    # and made available in R via the RColorBrewer package
    
    
    # scale_color_manual()
    
    presidential %>%
      mutate(id = 33 + row_number()) %>%
      ggplot(aes(start, id, colour = party)) +
      geom_point() +
      geom_segment(aes(xend = end, yend = id)) +
      scale_colour_manual(values = c(Republican = "red", Democratic = "blue"))+
      theme_bw()
# For continuous colour, you can use the built-in scale_colour_gradient() 
# or scale_fill_gradient().     
    
# Another option is scale_colour_viridis() provided by the viridis package. 
    df <- tibble(
      x = rnorm(10000),
      y = rnorm(10000)
    )
    ggplot(df, aes(x, y)) +
      geom_hex() +
      coord_fixed()+
      theme_classic()
    
    ggplot(df, aes(x, y)) +
      geom_hex() +
      viridis::scale_fill_viridis() +
      coord_fixed()+
      theme_bw()

    # 28.5 Zooming
    
# controlling the plot limits
    
    ggplot(mpg, mapping = aes(displ, hwy)) +
      geom_point(aes(color = class)) +
      geom_smooth() +
      coord_cartesian(xlim = c(5, 7), ylim = c(10, 30))
    
    mpg %>%
      filter(displ >= 5, displ <= 7, hwy >= 10, hwy <= 30) %>%
      ggplot(aes(displ, hwy)) +
      geom_point(aes(color = class)) +
      geom_smooth()
    
    suv <- mpg %>% filter(class == "suv")
    compact <- mpg %>% filter(class == "compact")
    
    ggplot(suv, aes(displ, hwy, colour = drv)) +
      geom_point()
    
    ggplot(compact, aes(displ, hwy, colour = drv)) +
      geom_point()
    
      # One way to overcome this problem is to share scales across multiple plot
    x_scale <- scale_x_continuous(limits = range(mpg$displ))
    y_scale <- scale_y_continuous(limits = range(mpg$hwy))
    col_scale <- scale_colour_discrete(limits = unique(mpg$drv))
    
    ggplot(suv, aes(displ, hwy, colour = drv)) +
      geom_point() +
      x_scale +
      y_scale +
      col_scale
    
    ggplot(compact, aes(displ, hwy, colour = drv)) +
      geom_point() +
      x_scale +
      y_scale +
      col_scale
  
    # 28.6 Themes
    
    ggplot(mpg, aes(displ, hwy)) +
      geom_point(aes(color = class)) +
      geom_smooth(se = FALSE) +
      theme_bw()
     # read the ggplot2 book for the full details
    # https://github.com/hadley/ggplot2-book 
    
      # the extensions https://exts.ggplot2.tidyverse.org/gallery/ 
    
      # 28.7 Saving your plots 
    # ggsave() and knitr. ggsave() will save the most recent plot to disk: 
  
    ggplot(mpg, aes(displ, hwy)) + geom_point()
    ggsave("my-plot.png")
    
# 28.7.1 Figure sizing 
    #There are five main options that control figure sizing: 
    #fig.width, fig.height, fig.asp, out.width and out.height. 
    
    # I set fig.width = 6 (6") and fig.asp = 0.618 (the golden ratio) in the defaults
    
    ggedit(p)
    
    # 29.7.1 htmlwidgets 
    
    install.packages("leaflet")
    
    library(leaflet)
    leaflet() %>%
      setView(174.764, -36.877, zoom = 16) %>% 
      addTiles() %>%
      addMarkers(174.764, -36.877, popup = "Maungawhau") 
  
    library(leaflet)
    leaflet() %>%
      setView(70.27190, 53.07894, zoom = 13) %>% 
      addTiles() %>%
      addMarkers(70.27190, 53.07894, popup = "Borovoe")
    
    
   # dygraphs, http://rstudio.github.io/dygraphs/, for interactive time series visualisations.
    
    
   # DT, http://rstudio.github.io/DT/, for interactive tables.
    
   # threejs, https://github.com/bwlewis/rthreejs for interactive 3d plots.
    
  # DiagrammeR, http://rich-iannone.github.io/DiagrammeR/ for diagrams 
    #(like flow charts and simple node-link diagrams).
    
    
    # 29.7.2 Shiny 
  # https://r4ds.had.co.nz/r-markdown-formats.html#shiny
   #  Learn more about Shiny at http://shiny.rstudio.com/. 
    
  
    