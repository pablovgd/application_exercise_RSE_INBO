##################################
## Title: exercise RSE INBO  
## Author: Pablo Vangeenderhuysen
## Date: 29/01/2026
## R version 4.5.2. 
##################################

# Set working directory to folder containing provided data
## The data is expected to be in a folder named "data" within the working directory
## Please change this to your own relevant working directory
setwd("ENTER WORKING DIRECTORY HERE")

# Check for, and install, required packages
## n2kha
if (!require("n2khab", quietly = TRUE)){
  install.packages("n2khab", repos = c(inbo = "https://inbo.r-universe.dev", 
                                       CRAN = "https://cloud.r-project.org"))
}
library(n2khab)

## dplyr
if (!require("dplyr", quietly = TRUE)){
  install.packages("dplyr")
}
library(dplyr)

## ggplot2
if (!require("ggplot2", quietly = TRUE)){
  install.packages("ggplot2")
}
library(ggplot2)

## tidyr
if (!require("tidyr", quietly = TRUE)){
  install.packages("tidyr")
}
library(tidyr)

## forcats
if (!require("forcats", quietly = TRUE)){
  install.packages("forcats")
}
library(forcats)



# PART 1: load and filter data ### 
folders_wd <- list.files()
if("data" %in% folders_wd == FALSE ){
  stop("Please make sure a folder named data is present in the working directory")
}
## Load required data
### Acquire relevant file locations from data folder
files <- list.files("data", 
                         pattern = "spatial_samples.csv", 
                         recursive =T,
                         full.names = T)

file_names <- sub("^data/([^/]+)/samples.*$", "\\1", files)
names(files) <- file_names

### Load .csv files as separate objects
for(i in file_names){
  file <- files[i]
  assign(i,read.csv2(file,sep = ","))
} 

## Clean data
### Remove unnecessary columns
poc_0.10.0[,c("module_combo_code","panel_set","sp_poststratum")] <- list(NULL)
poc_0.11.0[,c("module_combo_code","panel_set","sp_poststratum")] <- list(NULL)
poc_0.12.0[,c("module_combo_code","panel_set","sp_poststratum")] <- list(NULL)
poc_0.13.0[,c("module_combo_code","panel_set","sp_poststratum")] <- list(NULL)
poc_0.13.1[,c("module_combo_code","panel_set","sp_poststratum")] <- list(NULL)
poc_0.14.0[,c("module_combo_code","panel_set","sp_poststratum")] <- list(NULL)

### Add hydration class info by merging dataframes
hydr_cls <- n2khab::read_types()[, c("type", "hydr_class")]
poc_0.10.0 <- merge(poc_0.10.0, hydr_cls, by.x = "stratum",by.y = "type")
poc_0.11.0 <- merge(poc_0.11.0, hydr_cls, by.x = "stratum",by.y = "type")
poc_0.12.0 <- merge(poc_0.12.0, hydr_cls, by.x = "stratum",by.y = "type")
poc_0.13.0 <- merge(poc_0.13.0, hydr_cls, by.x = "stratum",by.y = "type")
poc_0.13.1 <- merge(poc_0.13.1, hydr_cls, by.x = "stratum",by.y = "type")
poc_0.14.0 <- merge(poc_0.14.0, hydr_cls, by.x = "stratum",by.y = "type")

## Filtering data
### The different versions can now be filtered by scheme and hydration class
### example: filter poc_0.10.0 to contain only "HC1" from scheme "SOIL_03.2"
hydr <- "HC1"
schm <- "SOIL_03.2"
poc_0.10.0_filtered <- dplyr::filter(poc_0.10.0,
                              hydr_class == hydr) |>
                      dplyr::filter(scheme == schm)
                              
### Test filtering
all(poc_0.10.0_filtered$scheme == schm) & all(poc_0.10.0_filtered$hydr_class == hydr)

# PART 2: plot data ###
# Plot sample sizes per stratum for poc_0.13.1 and poc_0.14.0, in scheme GW_03.3 for 
# HC1, HC12 and HC2

## Choose data of interest 
version_1 <- poc_0.13.1
version_2 <- poc_0.14.0
schm <- "GW_03.3"
hydr_classes <- c("HC1", "HC12", "HC2")

## Filter data of interest
version_1_filtered <- dplyr::filter(version_1,
                                     hydr_class %in% hydr_classes) |>
  dplyr::filter(scheme == schm)

version_2_filtered <- dplyr::filter(version_2,
                                    hydr_class %in% hydr_classes) |>
  dplyr::filter(scheme == schm)

## Summarise number of samples per stratum
v1_sum <- version_1_filtered |>
  group_by(stratum) |>
  summarise(v1_count = n_distinct(grts_address))

v2_sum <- version_2_filtered |>
  group_by(stratum) |>
  summarise(v2_count = n_distinct(grts_address))

## Combine dataframes to get sample size per stratum and total n 
counts <- full_join(v1_sum, v2_sum, by = "stratum") |>
  mutate(total_n = v1_count + v2_count) 

counts <- merge(counts, hydr_cls, by.x = "stratum",by.y = "type")
# reorder 
counts <- counts |>
  mutate(stratum = fct_reorder(stratum, total_n))


## Generate plot 
ggplot(counts) +
  geom_segment(aes(x = v1_count, xend = v2_count, y = stratum, yend = stratum),
               color = "grey70", linewidth = 1) +
  geom_point(aes(x = v1_count, y = stratum, colour = "poc_0.13.1", shape = hydr_class), size = 3) +
  geom_point(aes(x = v2_count, y = stratum, colour = "poc_0.14.0", shape = hydr_class), size = 3) +
  scale_colour_manual(name = "Version", values = c("poc_0.13.1" = "#356095", "poc_0.14.0" = "#c04384")) +
  scale_shape_manual(name = "Hydration class", values =  c("HC1" = 17, "HC2" = 15, "HC12" = 16),drop = FALSE)+
  labs(
    x = "Sample size",
    y = "Habitat (sub)type",
    title = "Sample sizes per habitat (sub)type for hydration classes HC1, HC12 and HC2 in scheme GW_03.3"
  ) +
  scale_x_continuous(breaks = round(seq(0 , max(counts$v2_count)+5, by = 10),1)) +
  theme_light() +
  coord_flip() +
  theme(axis.text.x=element_text(angle = 45, vjust = 0.5))

