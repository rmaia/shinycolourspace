library(shiny)
library(rgl)
library(pavo)


shinyUI(pageWithSidebar(
  # Application title
  headerPanel("Animal colorspaces: how birds see the world"),

  # Sidebar with a slider input for number of points

  sidebarPanel(
  
    fileInput('indat', 'Load spectrometer files', multiple = TRUE),
    
    selectInput('vissystem', 'Select visual system:', c(
      'Average UV system' = 'avg.uv',
      'Blue Tit' = 'bluetit',
      'European Starling' = 'star',
      'Average VIS system' = 'avg.v',
      'Peafowl' = 'pfowl'
    )),
    
    helpText(
      "Don't have your own spectral data? No problem! Click ",
      a(href="https://github.com/rmaia/pavo/blob/master/vignette_data/vignette_data.zip?raw=true", target="_blank", "here"),
      "to download the pavo vignette dataset."
    ),
  
    radioButtons('ptcol', 'Point color:',
      c('Black' = 'black',
        'Approximate color' = 'varcol')),


    checkboxGroupInput('options', 'Colorspace options:', c(
    'Achromatic center' = 'achro',
    'Tetrahedron floor' = 'floor',
    'Color volume' = 'grid',
    'Color volume fill' = 'fill'
    ), selected=c('achro')),
    
    
    sliderInput('ptsize', 'point size',
      min = 1,
      max = 10,
      value=1, step = 0.5
    ),
    

    HTML("<hr />"),
    helpText(HTML("designed by Rafael Maia"))
  ),
  



  mainPanel(
      rglwidgetOutput('tcs', height='700px', width='700px')
  )
))
