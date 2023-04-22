# Script to produce a randomly arranged list of trees for SLA sampling at transplant plots
# Created 11 June 2019 | Updated 12 August 2019

library(readr)
library(dplyr)

inventory_list <- read_csv("../inventory.csv")

# We only want live trees for this
inventory_list %>%
  filter(!is.na(Plot), State_2019 == "Alive") ->
inv

# Ensures you get the same random sampling data set order every time
set.seed(12345)

# Randomly arrange the inventory data
inv %>%
  #  mutate(Species = substr(Species_code, 1, 4)) %>%
  filter(Species_code %in% c("ACRU", "FAGR", "LIST", "NYSY")) %>%
  # with group by, the list will randomly resample first by Plot, then by Species_code
  group_by(Plot, Species_code) %>%
  # sample_frac()'s default is to sample all data = randomly resample rows
  sample_frac() ->
random_sampling_list

# Create new CSV with randomlized list
write_csv(random_sampling_list, "../transplant_inv_randomized.csv")
