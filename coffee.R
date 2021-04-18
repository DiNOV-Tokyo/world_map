# https://en.wikipedia.org/wiki/List_of_countries_by_coffee_production

library(tidyverse)
library(rvest)
library(DT)

coffee_html <- read_html("https://en.wikipedia.org/wiki/List_of_countries_by_coffee_production")

results <- coffee_html %>% 
  html_table(fill=TRUE)
coffee_df <- results[1] %>% 
  as.data.frame() 

coffee_dat <- coffee_df %>% 
  rename(sovereignt=Country) %>% 
  mutate(Metric.Tons = str_remove_all(Metric.Tons, ",")) %>% 
  select(Rank, sovereignt, Metric.Tons)

world <- ne_countries(scale = "medium", returnclass = "sf")
world_joined <- left_join(world, coffee_dat, key = sovereignt)

ggplot(data =  world_joined)+
  geom_sf(aes(fill = as.numeric(world_joined$Metric.Tons)), 
          color = "black")+ 
  labs(fill='Coffee production')  +
  scale_fill_viridis_c(option = "viridis")

datatable(coffee_df)

library(kableExtra)
library(clipr)
coffee_df %>% 
  kable(align = "c", row.names=FALSE) %>%
  kable_styling(full_width = F) %>%
  column_spec(1, bold = T) %>%
  collapse_rows(columns = 1, valign = "middle") %>% 
  write_clip



