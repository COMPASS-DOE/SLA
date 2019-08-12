## Script to process Specific Leaf Area data at SERC
# Created 06-13-2019

# Load necessary packages
library(dplyr)
library(tidyr)
library(readr)
library(ggrepel)
library(ggplot2)

## ================ Read in the SLA csv and make some basic plots

sla <- read.csv("SLA Data.csv", stringsAsFactors = FALSE) %>% 
  mutate(Tag = as.character(Tag))
print(sla)
print(summary(sla))

# Simple plot comparing number of leaves to the corresponding leaf area
p <- qplot(n_Leaves, Leaf_Area_cm2, data = sla)
print(p)

# Plot comparing number of leaves to corresponding leaf area, color by date but pretty!
leaves_v_area <- ggplot(data = sla, aes(n_Leaves, Leaf_Area_cm2, color = Date)) +
  geom_point() +
  geom_jitter()+
  labs(title = "Number of Leaves vs. Leaf Area", 
       subtitle = paste("Lillie Haddock", date()), 
       x = "Number of Leaves Per Sample", y = "Leaf Area (cm2)")
print(leaves_v_area)

# Plot comparing number of leaves to corresponding leaf area but pretty, faceted by date!
split_by_date <- ggplot(data = sla, aes(n_Leaves, Leaf_Area_cm2, color = Date)) + 
  geom_point() +
  labs(title = "Number of Leaves vs. Leaf Area by Date", 
       subtitle = paste("Lillie Haddock", date()), 
       x = "Number of Leaves Per Sample", y = "Leaf Area (cm2)") +
  facet_wrap(~Date)
print(split_by_date)

## Create an SLA column
sla <- sla %>% 
  mutate(specific_leaf_area = round(Leaf_Area_cm2 / Leaf_Mass_g, 3)) 
head(sla)

## ================ Join with inventory data

## Read in the storm surge inventory data
ss_inventory <- read.csv("ss-inventory.csv", stringsAsFactors = FALSE) %>% 
  select(Plot, Species_code, Tag, DBH) %>% 
  mutate(Tag = as.character(Tag))
summary(ss_inventory)

## The 'shore' plot at GCREW overlaps with the PREMIS-ghg HSLE plot,
## so use that inventory data too
inventory <- read.csv("transplant_inventory.csv", stringsAsFactors = FALSE) %>% 
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

# At this point there should be NO data with an NA for Plot or DBH or Species_code
# Warn if this occurs
if(any(is.na(sla_joined$DBH))) {
  warning("We still have unmatched trees!")  
}
if(any(sla_joined$Species_code == "")) {
  warning("We blank species codes!")  
}

## SLA by Plot
sla_by_plot <- sla_joined %>% 
  ggplot(aes(Species_code, specific_leaf_area, color = Position)) +
  geom_point() +
  geom_jitter() +
  facet_wrap(~Plot) +
  theme(axis.text.x = element_text(angle = 90)) +
  labs(title = "Specific Leaf Area by Plot", y = "Specific Leaf Area", 
       subtitle = paste("Lillie Haddock", date()))
print(sla_by_plot)

## SLA by species box plot
sla_with_tag <- sla_joined %>%
  ggplot(aes(Species_code, specific_leaf_area, label = Tag, color = Position)) +
  geom_boxplot() +
  geom_text_repel() +
  geom_point() + 
  labs(title = "Specific Leaf Area by Species and Tag Number", y = "Specific Leaf Area")
print(sla_with_tag)

## SLA by species faceting by plot
sla_with_tag_by_plot <- sla_joined %>%
  ggplot(aes(Species_code, specific_leaf_area, label = Tag, color = Position)) +
  geom_boxplot() +
  geom_text_repel() +
  geom_point() +
  facet_wrap(~Plot) +
  theme(axis.text.x = element_text(angle = 90)) +
  labs(title = "Specific Leaf Area by Species, Plot, and Tag Number", y = "Specific Leaf Area")
print(sla_with_tag_by_plot)

## SLA faceted by species
sla_by_species <- sla_joined %>%
  ggplot(aes(Plot, specific_leaf_area, color = Position)) +
  geom_point() + 
  geom_jitter() +
  facet_wrap(~Species_code) +
  theme(axis.text.x = element_text(angle = 90)) +
  labs(title = "Specific Leaf Area by Species and Plot", y = "Specific Leaf Area")
print(sla_by_species)

## DBH vs sla colored by species
sla_vs_dbh <- sla_joined %>% 
  ggplot(aes(DBH, specific_leaf_area, color = Species_code)) +
  geom_point() + 
  facet_wrap(~Species_code) +
  geom_smooth(method = "lm") +
  labs(title = "Specific Leaf Area vs. DBH", y = "Specific Leaf Area")
print(sla_vs_dbh)

## leaves vs mass
leaves_vs_mass <- sla_joined %>% 
  ggplot(aes(n_Leaves, Leaf_Mass_g, color = Species_code)) +
  geom_point() +
  facet_wrap(~Species_code) +
  geom_smooth(method = lm) +
  labs(title = "Number of Leaves vs. Leaf Dry Mass")
print(leaves_vs_mass)

## leaves vs area
leaves_vs_area <- sla_joined %>% 
  ggplot(aes(n_Leaves, Leaf_Area_cm2, color = Species_code)) +
  geom_point() +
  facet_wrap(~Species_code) +
  geom_smooth(method = lm) + 
  labs(title = "Number of Leaves vs. Leaf Area")
print(leaves_vs_area)

## sla vs position by species
sla_vs_position <- sla_joined %>% 
  ggplot(aes(Position, specific_leaf_area, color = Species_code)) +
  geom_jitter() +
  labs(title = "Specific Leaf Area vs. Canopy Position", x = "Canopy Position", y = "Specific Leaf Area")
print(sla_vs_position)

## average sla of each species
sla_averages <- sla_joined %>%
  group_by(Species_code) %>%
  summarise(sla_mean_species = mean(specific_leaf_area))
sla_averages_plot <- sla_averages %>% 
  ggplot(aes(Species_code, sla_mean_species)) +
  geom_point()
print(sla_averages_plot)

sla_joined %>% 
  ggplot(aes(Species_code, specific_leaf_area, color = Position)) +
  geom_boxplot()


cat("All done.")


## ------ Try Database Submission -------

species_codes <- read.csv(file = "species_codes.csv", stringsAsFactors = FALSE) 
plot_lon_lat <- read.csv(file = "plot-lon-lat.csv", stringsAsFactors = FALSE)

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
 
         
