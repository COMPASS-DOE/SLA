## Script to process Specific Leaf Area data at SERC
# Created 06-13-2019

# Load necessary packages
library(dplyr)
library(tidyr)
library(readr)
library(ggrepel)
library(ggplot2)
library(knitr)
theme_set(theme_bw())

## ----- Read in the SLA csv -----

sla <- read.csv("../SLA Data.csv", stringsAsFactors = FALSE) %>% 
  mutate(Tag = as.character(Tag))
print(sla)
print(summary(sla))

## ----- Create SLA column -----

sla <- sla %>% 
  mutate(specific_leaf_area = round(Leaf_Area_cm2 / Leaf_Mass_g, 3)) 
head(sla)

## ----- Join with inventory data -----

## Read in the storm surge inventory data
ss_inventory <- read.csv("../ss-inventory.csv", stringsAsFactors = FALSE) %>% 
  select(Plot, Species_code, Tag, DBH) %>% 
  mutate(Tag = as.character(Tag))
summary(ss_inventory)

## The 'shore' plot at GCREW overlaps with the PREMIS-ghg HSLE plot,
## so use that inventory data too
inventory <- read.csv("../inventory.csv", stringsAsFactors = FALSE) %>% 
  select(Plot, Tag, Species_code, DBH = DBH_cm_2019) %>% 
  filter(Plot == "HSLE") %>%  # GCREW only
  mutate(Plot = "Shore") %>% 
  bind_rows(ss_inventory)

# Create new dataset with plot, species, and tag columns
# by joining with the storm surge inventory data
sla %>% 
  left_join(inventory, by = "Tag") %>% 
  # if NA DBH, then get information from what we measured in field
  mutate(DBH = if_else(is.na(DBH), No_Tag_DBH, DBH),
         Species_code = if_else(is.na(Species_code), No_Tag_Species_code, Species_code),
         Plot = if_else(is.na(Plot), No_Tag_Plot, Plot)) %>% 
  # We only want four letter species codes
  mutate(Species_code = substr(Species_code, 1,4)) ->
  sla_joined
# NEW: Want ONLY ACRU, FAGR, LIST, NYSY species!
sla_joined_simple <- sla_joined %>% 
  filter(Species_code %in% c("ACRU", "FAGR", "LIST", "NYSY"))

# At this point there should be NO data with an NA for Plot or DBH or Species_code
# Warn if this occurs
if(any(is.na(sla_joined_simple$DBH))) {
  warning("We still have unmatched trees!")  
}
if(any(sla_joined_simple$Species_code == "")) {
  warning("We have blank species codes!")  
}

## Join sla_joined_simple with plot species_codes
species_codes <- read.csv(file = "../Design/species_codes.csv", stringsAsFactors = FALSE) 
sla_joined_names <- left_join(sla_joined_simple, species_codes, by = "Species_code")

## ----- Plots -----

# Plot comparing number of leaves to corresponding leaf area, color by date
# Kinda irrelevant 
leaves_v_area <- ggplot(data = sla, aes(n_Leaves, Leaf_Area_cm2, color = Date)) +
  geom_jitter() +
  labs(title = "Number of Leaves vs. Leaf Area", 
       x = "Number of Leaves Per Sample", y = "Leaf Area (cm2)")
print(leaves_v_area)

## SLA by Plot
sla_by_plot <- sla_joined_names %>% 
  ggplot(aes(Species_code, specific_leaf_area, color = Position)) +
  geom_point() +
  geom_jitter() +
  facet_wrap(~Plot) +
  theme(axis.text.x = element_text(angle = 90)) +
  labs(title = "Specific Leaf Area by Plot", x = "Species", y = "Specific Leaf Area")
print(sla_by_plot)

<<<<<<< HEAD

## Join sla_joined with plot species_codes
sla_joined_names <- left_join(sla_joined, species_code, by = "Species_code")
## SLA by species box plot

sla_with_tag <- sla_joined_names %>%
  ggplot(aes(Species_common, specific_leaf_area, label = Tag, color = Position)) +
  geom_boxplot() +
  geom_text_repel() +
  geom_point() + 
  labs(title = "Specific Leaf Area by Species and Tag Number", y = "Specific Leaf Area")
print(sla_with_tag)

## SLA by species faceting by plot
sla_with_tag_by_plot <- sla_joined %>%
  ggplot(aes(Species_code, specific_leaf_area, label = Tag, color = Position)) +
=======
## SLA by species and position box plot
sla_by_position <- sla_joined_names %>%
  ggplot(aes(Species_common, specific_leaf_area, color = Position)) +
>>>>>>> a3f4722df12acb169763b85a2226fb877cd245f2
  geom_boxplot() +
  labs(title = "Specific Leaf Area by Species", x = "Species", y = "Specific Leaf Area") +
  theme(axis.text.x = element_text(angle = 90))
print(sla_by_position)

## SLA faceted by species
sla_by_species <- sla_joined_names %>%
  ggplot(aes(Plot, specific_leaf_area, color = Position)) +
  geom_point() + 
  geom_jitter() +
  facet_wrap(~Species_common) +
  theme(axis.text.x = element_text(angle = 90)) +
  labs(title = "Specific Leaf Area by Species and Plot", y = "Specific Leaf Area (cm2/g)")
print(sla_by_species)

## DBH vs sla colored by species
sla_vs_dbh <- sla_joined_names %>% 
  ggplot(aes(DBH, specific_leaf_area, color = Species_common)) +
  geom_point() + 
  facet_wrap(~Species_common) +
  geom_smooth(method = "lm") +
  labs(title = "Specific Leaf Area vs. Tree Diameter", y = "Specific Leaf Area (cm2/g)", x = "Diameter at Breast Height (cm)",
       color = "Species")
print(sla_vs_dbh)

## average SLA of each species table
sla_averages <- sla_joined_names %>%
  group_by(Species_common) %>%
  summarise(sla_mean_species = mean(specific_leaf_area))

## average SLA box plot
sla_averages_plot <- sla_joined_names %>% 
  ggplot(aes(Species_common, specific_leaf_area)) +
  labs(title = "Average Specific Leaf Area", x = "Species", y = "Average SLA (cm2/g)") +
  geom_boxplot(aes(fill = Species_common)) + 
  #geom_text(aes(label = round(Specific, 2)), vjust = 1.6, size = 3.3) +
  theme(axis.text.x = element_text(angle = 90)) +
  guides(fill=guide_legend(title="Species"))
print(sla_averages_plot)

cat("All done.")


## ------ Table of species characteristics -------

species_characteristics <- sla_joined_names %>% 
  select(Species, Species_common, DBH) %>% 
  group_by(Species, Species_common) %>% 
  summarise("Number of Trees Sampled" = n(), "Average Diameter (cm)" = mean(DBH)) %>% 
print(species_characteristics)

## ------ Try Database Submission -------

plot_lon_lat <- read.csv(file = "../Design/plot-lon-lat.csv", stringsAsFactors = FALSE)

try_dataset <- sla_joined %>% 
  left_join(species_codes, by = "Species_code") %>% 
  left_join(plot_lon_lat, by = "Plot") %>% 
  mutate(Exposition = "Natural Forest", 
           `Forest Age (yrs)` = 60, 
           `Area per Leaf (cm2)` = round(Leaf_Area_cm2 / n_Leaves, 3),
           `Mass per Leaf (g)` = round(Leaf_Mass_g / n_Leaves, 3)) %>% 
  select(`Date Collected` = Date, 
         Exposition, 
         `Forest Age (yrs)`,
         Species,
         `Species Common` = Species_common, 
         `Diameter at Breast Height (cm)` = DBH,
         `Longitude E` = Longitude,
         `Latitude N` = Latitude,
         `Leaf Position` = Position, 
         `N Leaves` = n_Leaves, 
         `Total Fresh Leaf Area (cm2)` = Leaf_Area_cm2, 
         `Total Dry Mass (g)` = Leaf_Mass_g, 
         `Area per Leaf (cm2)`, 
         `Mass per Leaf (g)`,
         `Specific Leaf Area (cm2/g)` = specific_leaf_area)

write.csv(try_dataset, "Haddock_SLA_20190628.csv")


