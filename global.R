library(shiny)
library(shinydashboard)
library(googleVis)
library(dplyr)
library(DT)
library(stringr)
library(plotly)
library(ggplot2)
library(GGally)

spotify = read.csv('top10s.csv')
spotify = spotify %>%
  filter(., Popularity > 0)