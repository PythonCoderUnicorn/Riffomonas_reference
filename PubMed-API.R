


# this is to get data on PubMed articles such as keyword and counts
# National Library of Medicine (PubMed.gov)


# method 1 ----------------------------------------------------------------


library(tidyverse)

# downloaded csv for keyword 'microbiome'
# 1st line has `Search query: microbiome`, need to skip= 1
read_csv('~/Downloads/PubMed_Timeline_Results_by_Year.csv', skip = 1) %>% 
  ggplot(
    aes(x= Year, y= Count)
  )+ 
  geom_line()+
  geom_point()




# method 2 ----------------------------------------------------------------

# use PubMed API
# install.packages('rentrez')
library(rentrez)

# show list of databases available
entrez_dbs()

# get basic info about a database
entrez_db_summary(db='pubmed')

# searchable fields within PubMed 
entrez_db_searchable(db= 'pubmed')

# search pubmed for term 'microbiome'
# returns number of hits, and search terms
entrez_search(db= 'pubmed', term = 'microbiome')


# search for specific author
entrez_search(db= 'pubmed', term = 'Schloss PD [AUTH]')

# just get the number of papers
entrez_search(db= 'pubmed', term = 'Schloss PD [AUTH]')$count

# search author and search term
entrez_search(db= 'pubmed', term = 'Schloss PD [AUTH] AND microbiome')$count

# search for authors and term
non_microbiome = entrez_search(db= 'pubmed', 
              term = '(Schloss PD [AUTH] AND Young VB [AUTH]) NOT microbiome ')$id

# grab the abstracts for the 2 non-microbiome papers (actually are microbiome papers)
entrez_fetch(db='pubmed', id= non_microbiome, rettype = 'abstract')

# search pubmed for term for specific year
query = 'microbiome AND 2020[PDAT]'
entrez_search(db='pubmed', term = query)$count



# map function ------------------------------------------------------------

year = 2000:2021

query_search = glue::glue("microbiome AND {year}[PDAT]")
# add cancer as search term
cancer_search = glue::glue("cancer AND {year}[PDAT]")


# add our cancer query to our search
search_counts = tibble(
  year = year,
  query_search = query_search,
  cancer_search = cancer_search ) %>% 
  mutate(query_search = map_dbl(query_search, ~entrez_search(db='pubmed', term = .x)$count),
         cancer_search = map_dbl(cancer_search, ~entrez_search(db='pubmed', term = .x)$count)
         )



search_counts %>% 
  ggplot(
    aes(x= year,
        y=query_search)
  )+
  geom_line()

# update query search


search_counts %>% 
  select(year, query_search, cancer_search) %>% 
  # mopve query search into middle column then count on right
  pivot_longer(-year) %>% 
  ggplot(
    aes(x= year,
        y= value,
        group= name,
        color= name)
  )+
  geom_line()+
  geom_point()



# now search for all papers given a year

year = 2000:2021

query_search = glue::glue("microbiome AND {year}[PDAT]")
cancer_search = glue::glue("cancer AND {year}[PDAT]")
all_search = glue::glue("{year}[PDAT]")

# 
search_counts = tibble(
  year = year,
  query_search = query_search,
  cancer_search = cancer_search,
  all_search = all_search
  ) %>% 
  mutate(query_search = map_dbl(query_search, ~entrez_search(db='pubmed', term = .x)$count),
         cancer_search = map_dbl(cancer_search, ~entrez_search(db='pubmed', term = .x)$count),
         all_search = map_dbl(all_search, ~entrez_search(db='pubmed', term = .x)$count)
  )


search_counts %>% 
  select(year, query_search, cancer_search, all_search) %>% 
  # mopve query search into middle column then count on right
  pivot_longer(-year) %>% 
  ggplot(
    aes(x= year,
        y= value,
        group= name,
        color= name)
  )+
  geom_line()+
  geom_point()


# the amount of papers has grown but what does that mean for microbiology vs cancer?

search_counts %>% 
  select(year, query_search, cancer_search, all_search) %>% 
  mutate(rel_microbio = 100* query_search / all_search ) %>% 
  ggplot( aes(year, y= rel_microbio))+
  geom_line() +
  scale_y_log10()

# for microbio papers the number of papers has grown exponentially
















