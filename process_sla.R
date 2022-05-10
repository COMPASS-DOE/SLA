## SLA Data processing for use in analysis.Rmd
## Code created by Lillie Haddock in 2019

# Read in main data file and compute SLA

read_csv("sla_data.csv", col_types = "ccccdcdddc") %>%
  mutate(SLA = Leaf_Area_cm2 / Leaf_Mass_g) %>% 
  separate(Position, into = c("Position", "Light"), sep = "/")->
sla_raw


## Inventory Data


## Read in the TEMPEST inventory data
# This doesn't include the shore plot at GCREW!
  tempest_inventory <- read_csv("inventory/tempest-inventory.csv", col_types = "c-cd-c----")
  
  if (any(duplicated(tempest_inventory$Tag))) {
    warning(
      "We have duplicate tree tags in TEMPEST inventory: ",
      paste(which(duplicated(tempest_inventory$Tag)), collapse = ", ")
    )
  }
  
  # Read in transplant inventory data
  transplant_inventory <- read_csv("inventory/transplant-inventory.csv",
                                   col_types = "-cc-c---d--c"
  ) %>%
    select(Plot, Tag, Species_code, DBH = DBH_cm_2019, Notes)
  
  # Check that no tag numbers are duplicated
  if (any(duplicated(transplant_inventory$Tag))) {
    warning(
      "We have duplicate tree tags in transplant inventory: ",
      paste(which(duplicated(transplant_inventory$Tag)), collapse = ", ")
    )
  }
  
  # Combine storm surge inventory with transplant inventory
  bind_rows(transplant_inventory, tempest_inventory) %>%
    filter(!is.na(Tag)) ->
    inventory
  
  # Check that no tag numbers are duplicated
  # This is DEFENSIVE PROGRAMMING
  if (any(duplicated(inventory$Tag))) {
    warning(
      "We have duplicate tree tags in the combined inventory: ",
      paste(which(duplicated(inventory$Tag)), collapse = ", ")
    )
  }

  
  ## Join SLA and inventory data

  sla_raw %>%
    # Make blank Tag values NAs to stop duplicates when joining
    mutate(Tag = if_else(Tag == "", NA_character_, Tag)) %>%
    left_join(inventory, by = "Tag") ->
    sla_joined
  
  n_sla_premerge <- nrow(sla_raw)
  n_sla_joined <- nrow(sla_joined)
  if (n_sla_joined != n_sla_premerge) {
    stop("We have a problem!\n")
  }
  
  shoreline_plots <- c("Shore", "HSLE", "MSLE", "LSLE")
  
  sla_joined <- sla_joined %>%
    # if NA DBH, then get information from what we measured in field
    mutate(
      DBH = if_else(is.na(DBH), No_Tag_DBH, DBH),
      Species_code = if_else(is.na(Species_code), No_Tag_Species_code, Species_code),
      Plot = if_else(is.na(Plot), No_Tag_Plot, Plot)
    ) %>%
    # We only want four letter species codes, and want to add an elevation column
    mutate(
      Species_code = substr(Species_code, 1, 4),
      Elevation = if_else(Plot %in% shoreline_plots, "Shoreline", "Upland")
    )
  n_sla_joined <- nrow(sla_joined)
  
  # At this point, everything should have a DBH entry
  if (any(is.na(sla_joined$DBH))) {
    warning("Missing DBH!\n")
    paste("Tag:", sla_joined$Tag[which(is.na(sla_joined$DBH))])
  }
  
  # Filter for ACRU, FAGR, LIST, NYSY, QUAL, LITU; others (CA?? and COFL and <= 2)
  sla_joined_simple <- sla_joined %>%
    filter(Species_code %in% c("ACRU", "FAGR", "LIST", "NYSY", "QUAL", "LITU", "CAGL"))
  
  # At this point there should be NO data with an NA for Plot or DBH or Species_code
  # Warn if this occurs
  if (any(is.na(sla_joined_simple$DBH))) {
    warning("We still have unmatched trees!\n")
    paste("Tag:", sla_joined_simple$Tag[which(is.na(sla_joined_simple$DBH))])
  }
  if (any(sla_joined_simple$Species_code == "")) {
    warning("We have blank species codes!")
  }
  
  ## Join sla_joined_simple with plot species_codes
  species_codes <- read_csv("Design/species_codes.csv", col_types = "ccc")
  sla <- left_join(sla_joined_simple, species_codes, by = "Species_code")
  
  # QC
  n_sla_joined_simple <- nrow(sla_joined_simple)
  n_sla <- nrow(sla)
  message("Rows in sla_joined_simple: ", n_sla_joined_simple)
  message("Rows in sla: ", n_sla)
  if (n_sla_joined_simple != n_sla) {
    warning("We have a problem!\n")
  }
  
  ## Add salinity information
  salinities <- tibble(
    Plot = shoreline_plots,
    Salinity = c("High", "High", "Medium", "Low")
  )
  sla %>%
    left_join(salinities, by = "Plot") %>%
    mutate(Salinity = factor(Salinity, levels = c("Low", "Medium", "High"))) %>%
    select(-starts_with("No_"), Notes.x, Notes.y) ->
    sla

  