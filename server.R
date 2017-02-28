library(shiny)
library(DT)
library(fmsb)
library(ggplot2)
library(ggrepel)

shinyServer(function(input, output, session) {
  
  pokemon <- read.csv("Pokemon_r.csv")

  pokemonSubset <- reactive({
    subset(pokemon, 
           Number >= input$number[1] & 
           Number <= input$number[2] &
           Total >= input$total[1] &
           Total <= input$total[2] &
           HP >= input$hp[1] &
           HP <= input$hp[2]&
           Attack >= input$attack[1] &
           Attack <= input$attack[2] &
           Defense >= input$defense[1] &
           Defense <= input$defense[2] &
           SpecialAtk >= input$spatk[1] &
           SpecialAtk <= input$spatk[2] &
           SpecialDef >= input$spdef[1] &
           SpecialDef <= input$spdef[2] & 
           Speed >= input$speed[1] &
           Speed <= input$speed[2] &
           (
            (input$normal1 & (Type1 == "Normal")) |
            (input$grass1 & (Type1 == "Grass")) |
            (input$fire1 & (Type1 == "Fire")) |
            (input$water1 & (Type1 == "Water")) |
            (input$bug1 & (Type1 == "Bug")) |
            (input$flying1 & (Type1 == "Flying")) |
            (input$electric1 & (Type1 == "Electric")) |
            (input$ice1 & (Type1 == "Ice")) |
            (input$rock1 & (Type1 == "Rock")) |
            (input$ground1 & (Type1 == "Ground")) |
            (input$poison1 & (Type1 == "Poison")) |
            (input$fighting1 & (Type1 == "Fighting")) |
            (input$psychic1 & (Type1 == "Psychic")) |
            (input$ghost1 & (Type1 == "Ghost")) |
            (input$dark1 & (Type1 == "Dark")) |
            (input$dragon1 & (Type1 == "Dragon")) |
            (input$steel1 & (Type1 == "Steel")) |
            (input$fairy1 & (Type1 == "Fairy"))
           ))
  })
  
  output$dt1 <- DT::renderDataTable(pokemonSubset(), selection = list(mode = 'single', selected = 1))

  output$radarPlot <- renderPlot({
    ps <- pokemonSubset()

    maxmin <- data.frame(
      hp = c(120, 1),
      attack = c(120, 1),
      defense = c(120, 1),
      spattack = c(120, 1),
      spdefense = c(120, 1),
      speed = c(120, 1))
 
    dat <- data.frame(
      hp = ps[1,"HP"],
      attack = ps[max(1,input$dt1_rows_selected),"Attack"],
      defense = ps[max(1,input$dt1_rows_selected),"Defense"],
      spattack = ps[max(1,input$dt1_rows_selected),"SpecialAtk"],
      spdefense = ps[max(1,input$dt1_rows_selected),"SpecialDef"],
      speed = ps[max(1,input$dt1_rows_selected),"Speed"])  
  
    dat <- rbind(maxmin, dat)
       
    radarchart(dat, axistype = 2, 
               seg = 5, plty = 1, 
               pfcol = "#FF00004C",
               vlcex = 1.5,centerzero = TRUE, 
               title = ps[max(1,input$dt1_rows_selected),"Name"])
  })
  
  output$scatterPlot <- renderPlot({
    ps <- pokemonSubset()
    ggplot() + 
      geom_point(data = ps, aes(x = Speed, y = Total, color = Type1)) +
      geom_point(data = ps[max(1,input$dt1_rows_selected),], aes(x = Speed, y = Total), color = 'black', size = 3) + 
      geom_label_repel(data = ps[max(1,input$dt1_rows_selected),], aes(x = Speed, y = Total), label = ps[max(1,input$dt1_rows_selected),"Name"])
  })
})