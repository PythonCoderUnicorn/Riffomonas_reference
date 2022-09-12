
# ------- Riffomonas Project
# dumbbell chart
# https://www.youtube.com/watch?v=qaksmQabMUI&list=LL&index=1

# library(tidytuesdayR)
library(tidyverse)
library(scales)
library(ggplot2)
library(janitor)
library(ggtext)
library(systemfonts)
library(showtext)
library(ggdark)
library(glue)


# font_add_google(family="patua-one", "Patua One")
# showtext_auto()

theme_set(theme_bw(base_family = "Lato"))


vax_attitudes = tribble(
  ~'X.1', ~'Total Agree - August 2020', ~'Total Agree - October 2020',
  'Total',77,73,
  'India',87,87,
  'China',97,85,
  'South Korea',84,83,
  'Brazil',88,81,
  'Australia',88,79,
  'United Kingdom',85,79,
  'Mexico',75,78,
  'Canada',76,76,
  'Germany',67,69,
  'Japan',75,69,
  'South Africa',64,68,
  'Italy',67,65,
  'Spain',72,64,
  'United States',67,64,
  'France',59,54
  
)

# https://riffomonas.org/code_club/2021-08-12-aug-oct-ipsos

# https://github.com/riffomonas/vaccination_attitudes





# remotes::install_github()





