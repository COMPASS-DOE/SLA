# Read the SERC storm surge experiment inventory, and randomly sample
# to produce a list of trees for SLA sampling
# 11 June 2019

library(readr)
library(dplyr)

# Inventory_list is a .csv, plot_name is 
randomizer <- function(inventory_list, plot_name) {
  inventory_list %>% 
    filter(!is.na(Plot), State_2019 == "Alive") ->
    inv
  
  # Ensures you get the same random sampling data set order every time
  set.seed(12345)
  
  # Randomly arrange the inventory data
  inv %>%
    mutate(Species = substr(Species_code, 1, 4)) %>% 
    filter(Species_code %in% c("ACRU", "FAGR", "LIST", "NYSY")) %>% 
    group_by(Plot, Species_code) %>% 
    # sample_frac()'s default is to sample all data = randomly resample rows
    sample_frac() ->
    random_sampling_list
  
  new_file <- paste0("../", plot_name, ".csv")
  write_csv(random_sampling_list, new_file)
}

gcrew_transplant <- read_csv("../transplant_inventory.csv")
#gcrew_transplant %>% 
#  select(Plot, tidyselect::starts_with("^HS"), Tag, Species_code, State_2019) -> gcrew
  
randomizer(gcrew_transplant, "GCREW")
