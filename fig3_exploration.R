
library(ggalt)

hsd_species$groups %>%
  mutate(species = rownames(hsd_species$groups)) %>%
  separate(species, into = c("Species_code", "Position"), sep = "\\.", remove = FALSE) %>%
  #mutate(species = forcats::fct_reorder(species, SLA)) %>%
  left_join(xx, by = c("Species_code", "Position")) %>% 
  arrange(Species_code, Position) ->
  species_position

# Bar chart arranged by species and position
species_position %>%
  ggplot(aes(species, SLA, fill = Position)) +
  geom_col() +
  geom_errorbar(aes(ymin = SLA - sd_sla, ymax = SLA + sd_sla), alpha = 0.33) +
  geom_text(aes(label = groups), vjust = -1) +
  scale_x_discrete("Species", labels = species_position$Species_code) +
  ylab(expression(SLA ~ (cm^2 ~ g^-1))) +
  scale_fill_brewer() +
  theme(
    legend.position = c(0.10, 0.9),
    axis.text.x = element_text(size = 8)
  )

# Dumbbell plot

species_position %>% 
  pivot_wider(id_cols = Species_code, names_from = Position, values_from = sd_sla) %>% 
  rename(Sun = `High/Sun`, Shade = `Low/Shade`) %>% 
  #filter(Species_code != "CAGL") %>% 
  #mutate(Species_code = forcats::fct_reorder(Species_code, `High/Sun`, .na_rm = TRUE))  
  arrange(Species_code) -> positions_wide

cols <- c("Sun" = "#FF9D1F", "Shade" = "#0e668b")

ggplot(positions_wide, aes(x = Sun, xend = Shade , y = Species_code)) + 
  geom_dumbbell(colour_x = "#FF9D1F", 
                size = 3,
                color = "lightgrey",
                size_x = 3, size_xend = 3, 
                colour_xend = "#0e668b") + 
  #add in CAGL value that got dropped
  geom_point(data = filter(positions_wide, Species_code == "CAGL"), aes(x = Shade, y = Species_code),
             color = "#0e668b", size = 3) +
  #add color legend to top dumbbell
  geom_text(data=filter(positions_wide, Species_code=="QUAL"),
            aes(x=Sun, y=Species_code, label="High/Sun"),
            color="#FF9D1F", size=5, vjust=-1.5, fontface="bold") +
  geom_text(data=filter(positions_wide, Species_code=="QUAL"),
            aes(x=Shade, y=Species_code, label="Low/Shade"),
            color="#0e668b", size=5, vjust=-1.5, fontface="bold") +
  #add SLA values
  geom_text(color="#FF9D1F", size=5, vjust=2.5, 
            aes(x=Sun, y=Species_code, label=round(Sun, digits = 1))) +
  geom_text(color="#0e668b", size=5, vjust=2.5, 
            aes(x=Shade, y=Species_code, label=round(Shade, digits = 1))) +
  # scale_color_manual(name='Leaf Position',
  #                    values=cols) + 
  labs(x= expression(SLA ~ (cm^2 ~ g^-1)), 
       y= "Species Code") 
 
