# load tidyvese 
libarary (tidyverse)

# load ggplot
library (ggplot2)

# exloring mpg dataset
ggplot2::mpg

ggplot(mpg, aes(x=cyl,y=hwy))+
         geom_point()

ggplot(mpg, aes(x=class,y=drv))+
  geom_point()

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = class))