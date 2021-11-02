# HOW TO LOAD FONTS INTO RSTUDIO


library(ggtext)
library(showtext)
# library(systemfonts)  # another package


# default fonts: sans, serif, mono 


#--- showtext 
font_paths()

# [1] "/Library/Fonts"                    
# [2] "/System/Library/Fonts"             
# [3] "/System/Library/Fonts/Supplemental"

# find specific font
font_files() %>% 
  tibble() %>% 
  filter(str_detect(family,"Montserrat"))

# load font installed on computer into RStudio
font_add(family = "Montserrat", regular = "Montserrat-Regular.ttf")

showtext_auto()

#-- premade data visualization
covid_plot.2


# ====== load fonts from Google
font_add_google(family = "Poppins","Poppins")
showtext_auto()

covid_plot.2
