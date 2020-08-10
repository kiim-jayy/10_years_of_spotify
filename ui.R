shinyUI(dashboardPage(
  skin = "black",
  dashboardHeader(title = '10 Years of Spotify'),
  dashboardSidebar(
    sidebarUserPanel('Jay Kim', image = 'spotify.png'),
    sidebarMenu(
      menuItem('Home', tabName = 'home', icon = icon('list')),
      menuItem('Year', tabName = 'year', icon = icon('calendar-minus')),
      menuItem('Popularity', tabName = 'popularity', icon = icon('fire')),
      menuItem('Analysis', tabName = 'analysis', icon = icon('chart-line')),
      menuItem('Data', tabName = 'data', icon = icon('columns'))
    ),
    selectizeInput('selected', 'Select the Feature to Display', choices = colnames(spotify)[c(-1, -2, -3, -4, -5, -15)])
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "home", 
              fluidRow(
                infoBoxOutput("titleBox"),
                infoBoxOutput('artistBox'),
                infoBoxOutput('genreBox')),
              fluidRow(h3('Popular Trends in Features over the Past 10 Years : ', align = 'center'), width = '100%'),
              br(),
              column(12, box(plotlyOutput('popularHistogram'), width = 'auto', height = 'auto'))),
      tabItem(tabName = "year",
              fluidRow(h3('Trends in Features over the Years : ', align = 'center'), width = '100%'),
              br(),
              column(3, selectizeInput(
                'selected_feature_y', 'Features: ', choices = colnames(spotify)[c(-1, -2, -3, -4, -5, -15)]
              ),
                fluidRow(p('BPM : Beats Per Minute - The tempo of the song'), 
                         p('Energy : The higher the value, the more energetic'),
                         p('Danceability : The higher the value, the easier it is to dance to the song'),
                         p('Loudness : The higher the value, the louder the song'),
                         p('Liveness : The higher the value, the more likely the song is a live recording'),
                         p('Valence : The higher the value, the more positive mood for the song'),
                         p('Duration : The length of the song'),
                         p('Acousticness : The higher the value, the more acoustic the song is'),
                         p('Speechiness : The higher the value, the more spoken word the song contains'))),
              column(9, box(plotlyOutput('yearLine'), width = 'auto', height = 'auto'))),
      tabItem(tabName = "popularity",
              fluidRow(h3('Trends in Features over the Popularity : ', align = 'center'), width = '100%'),
              br(),
              column(3, selectizeInput(
                'selected_feature_p', 'Features: ', choices = colnames(spotify)[c(-1, -2, -3, -4, -5, -15)]
              ),
                fluidRow(p('BPM : Beats Per Minute - The tempo of the song'), 
                         p('Energy : The higher the value, the more energetic'),
                         p('Danceability : The higher the value, the easier it is to dance to the song'),
                         p('Loudness : The higher the value, the louder the song'),
                         p('Liveness : The higher the value, the more likely the song is a live recording'),
                         p('Valence : The higher the value, the more positive mood for the song'),
                         p('Duration : The length of the song'),
                         p('Acousticness : The higher the value, the more acoustic the song is'),
                         p('Speechiness : The higher the value, the more spoken word the song contains'))),
              column(9, box(plotlyOutput('popularityPlot'), width = 'auto', height = 'auto'))),
      tabItem(tabName = 'analysis', 
              fluidRow(h3('The Correlation between All the Features : ', align = 'center'), width = '100%'),
              br(),
              fluidRow(box(plotOutput('correlationChart'), width = 12))),
      tabItem(tabName = 'data', fluidRow(box(dataTableOutput('database'), width = 12)))
    )
  )
))