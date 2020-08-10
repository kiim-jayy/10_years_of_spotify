function(input, output, session) {
  output$titleBox = renderInfoBox({
    song = spotify %>%
      arrange(., desc(Popularity)) %>%
      top_n(1)
    title = 'The Most Popular Song: '
    artist = song$Artist
    infoBox(title, song$Title, artist, icon = icon('music'), color = 'blue')
  })
  
  output$artistBox = renderInfoBox({
    artist = names(table(spotify$Artist))[table(spotify$Artist) == max(table(spotify$Artist))]
    title = 'The Most Popular Artist: '
    infoBox(title, artist, icon = icon('microphone'), color = 'blue')
  })
  
  output$genreBox = renderInfoBox({
    genre = names(table(spotify$Genre))[table(spotify$Genre) == max(table(spotify$Genre))]
    title = 'The Most Popular Genre: '
    infoBox(title, str_to_title(genre), icon = icon('sliders-h'), color = 'blue')
  })
  
  output$popularHistogram = renderPlotly({
    selection = toString(input$selected)
    ggplotly(spotify %>%
               group_by(., Year) %>%
               select(., Year, Feature = input$selected) %>%
      ggplot(., aes(x = Feature)) +
      geom_histogram(fill = 'steelblue', color = 'lightblue') +
      ylab('Count') + 
      xlab(selection)
    )
  })
  
  output$yearLine = renderPlotly({
    selection = toString(input$selected_feature_y)
    print(selection)
    ggplotly(spotify %>%
               select(., Year, Feature = input$selected_feature_y) %>%
               group_by(., Year) %>% 
               summarize(., Year, Average = mean(Feature)) %>%
               distinct(., Year, .keep_all = TRUE) %>%
      ggplot(., aes(x = Year, y = Average)) +
      geom_line() +
      ylab(paste('Average of', toString(selection))) + 
      xlab('Year')
    )
  })

  output$popularityPlot = renderPlotly({
    feature_name = toString(input$selected_feature_p)
    ggplotly(spotify %>% select(., Popularity, Feature = input$selected_feature_p) %>%
      ggplot(aes(x = Popularity, y = Feature)) +
      stat_density2d(aes(fill = ..level.., alpha = ..level..), size = 2, bins = 10, geom = "polygon") + 
      geom_point(alpha = 0.4) +
      ylab(feature_name) + 
      xlab('Popularity')
    )
  })
  
  output$correlationChart = renderPlot({
    spotify_corr = spotify %>%
      select(., Year, BPM, Energy, Danceability, Loudness, Liveness, Valence, Duration, Acousticness, Speechiness, Popularity)
    ggcorr(spotify_corr, label = TRUE, size = 3.2)
  })
  
  output$database = renderDataTable(
    datatable(spotify, rownames = F) %>%
      formatStyle(input$selected, background = "skyblue", fontWeight = "bold")
  )
}