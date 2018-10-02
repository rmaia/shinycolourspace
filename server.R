options(rgl.useNULL = TRUE)

library(shiny)
library(rgl)
library(pavo)

shinyServer(function(input, output, session) {

spcs <- reactive({

  # Load sicalis data if user doesn't add data

  if(is.null(input$indat)){
    data(flowers)
    spcs <- flowers
  }

  # Load user data
  
  if(!is.null(input$indat)){
  	
  	df <- input$indat
  	pt <- df$datapath
  	
    spcs <- try(getspec(where = dirname(pt[1]) , ext=c('txt','ttt', 'TXT', 'Txt', 'TTT', 'Ttt')), silent=TRUE)
    
    if('try-error' %in% class(spcs))
      spcs <- try(getspec(where = dirname(pt[1]) , ext=c('txt','ttt', 'TXT', 'Txt', 'TTT', 'Ttt'), dec=','), silent=TRUE)
      
    if('try-error' %in% class(spcs))
      stop('Could not open spectral files.')
  }
  
  spcs

})

res <- reactive({colspace(vismodel(spcs(), visual=input$vissystem, achro=FALSE))})


  
  ptcol <- reactive({
    ptcol <- switch(input$ptcol,
      black = 'black',
      varcol = spec2rgb(spcs())
    )
  })
  
  apt <- reactive({'achro' %in% input$options})
  flr <- reactive({'floor' %in% input$options})
  grd <- reactive({'grid' %in% input$options})
  fil <- reactive({'fill' %in% input$options})
    
  output$tcs <- renderRglwidget({
  	
    tcsplot(res(), 
      size = input$ptsize/100, 
      col=ptcol(), 
      achro=apt(),
      floor = flr(), 
      achrosize=0.015, lwd=3, lcol='grey')
      
      if(any(c(grd(),fil()))) tcsvol(res(), grid = grd(), fill= fil())
      
    rglwidget()
  }
  )


})

