# Riffomonas Project

library(tidyverse)
library(ggplot2)
library(glue)






covid = read_csv('covid19.csv')

covid %>% janitor::clean_names()

covid_clean = covid %>% 
  rename(country = X.1,
         august = `Total Agree - August 2020`,
         october = `Total Agree - October 2020`
         )

covid_clean

covid_plot = covid_clean %>% 
  pivot_longer(
    cols = -country,
    names_to = "month",
    values_to = "percentage"
  ) %>% 
  ggplot(
    aes(x = percentage,
        y= country,
        color= month)
  )+
  geom_line(color='grey60')+
  geom_point(size= 3)+
  ggdark::dark_mode()


covid_plot



covid_clean.2 = covid_clean %>% 
  rename(country = country,
         percent_august = august,
         percent_october = october) %>% 
  mutate(
    bump_august = if_else(percent_august < percent_october,
                          percent_august - 2,
                          percent_august + 2),
    bump_october = if_else(percent_august < percent_october,
                           percent_october + 2,
                           percent_october - 2)
  )

covid_plot.2 = covid_clean.2 %>% 
  pivot_longer(
    cols =  -country,
    names_to =  c('.value','month'),
    names_sep = '_'
  ) %>% 
  mutate(country = factor(country, levels = rev(covid_clean.2$country) )) %>% 
  ggplot(
    aes(x= percent, y= country, color= month)
  )+ 
  geom_line(
    color='grey20',
    size= 1.75
    )+
  geom_point(size= 3, show.legend = F)+
  geom_text( aes(label= glue("{percent}%"), 
                 x= bump),
             show.legend = F
             ) +
  scale_color_manual(name=NULL,
                     breaks =  c('august','october'),
                     values = c('#fca151','#d6abff'),
                     labels= c('august','october'))+
  scale_x_continuous(limits =  c(50 , 100),
                     breaks =  seq(50, 100, by= 5),
                     labels = glue("{seq(50,100,5)}%")
                     ) +
  ggdark::dark_mode()+
  labs(title = "Covid-19 vaccine acceptance by country",
       subtitle = "Oct 2020 and Aug 2020",
       caption = "Base: 18,526 online adults aged 16-24 in 15 countries <br> Source: Ipsos"
       )+
  theme(
    plot.title = element_markdown(size = 16, face = 'bold'),
    # plot.subtitle = element_markdown( ),
    plot.caption = element_markdown(hjust = 0, 
                                    face = 'italic', 
                                    color = 'grey50',
                                    size = 11),
    plot.caption.position = 'plot'
  )

covid_plot.2
