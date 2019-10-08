source('styleguide.R')
house = read.csv("house_elections.csv")

# CLEANING
party.temp = as.character(house$party)
party.temp[house$party != "democrat" & house$party != "republican"] = "other"
party.temp[house$writein] = "writein"
house$party = factor(party.temp, levels = c("democrat", 'republican', 'other', 'writein'))
table(house$party)

mi = house[house$electiondistrict == "MI3",] 

mi = mi[mi$party != 'writein',]
mi = mi[mi$party != 'other',]

# Plotting 
a <- ggplot(data=mi, aes(x=year, y=candidatevotes)) +
  geom_line(aes(colour = factor(party))) +
  geom_point(aes(colour = factor(party))) + 
  scale_color_manual(values = c("#0015bc", "#E9141D"),name="Party", labels = c('Democrat', 'Republican')) +
  labs(title="MI-3 Elections") +
  xlab("Year") +
  ylab("Votes") +
  ylim(c(0,225000)) + 
  xlim(c(1975,2019)) +
  theme(legend.position="bottom") + 
  labs(subtitle = "1976 - 2018", caption = "Source: https://electionlab.mit.edu/data") + 
  theme_hodp() 
a
 
# Add logo
grid::grid.raster(logo, x = 0.01, y = 0.01, just = c('left', 'bottom'), width = unit(2, 'cm'))

# Interactive Graphic
ggplotly(a)
