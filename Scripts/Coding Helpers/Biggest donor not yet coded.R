# Progress report

# Setup -------------------------------------------------------------------
library(tidyverse)
library(leebunce)

# Update data file --------------------------------------------------------
source('Scripts/Data processing/3 - Produce output data.R')

# Data --------------------------------------------------------------------
load("Output/info_democracy.Rdata")

# Not yet coded -----------------------------------------------------------
not_yet_coded <- info_democracy %>% 
  filter(interest_code == 'ZZZZZ',
         !is.na(donor_id)) %>% # Focus on those that have already been researched
  group_by(donor_id, x_donor_name) %>%
  summarise(n = n(),
            Total = sum(dntn_value)) %>%
  arrange(-Total) %>% 
  ungroup() %>% 
  mutate(Percent = percent(Total/sum(Total), digits = 3),
         `Cumulative percent` = cumsum(Percent),
         Total = format(Total, big.mark = ","))

View(not_yet_coded)
