library(shiny)

fluidPage(
  
  titlePanel("Pokemon search"),
  
  sidebarLayout(
    sidebarPanel(
      
      tags$div(class="header", checked=NA,
               tags$a(href="http://r-tips.hatenablog.com", "Blog"),
               tags$p("If you want to know this application in detail, check out my blog"),
               tags$a(href="https://www.kaggle.com/abcsds/pokemon", "Kaggle datasets"),
               tags$p("Data is from Kaggle datasets"),
               
               tags$p("Source repository is on Github")
      ),
      
      # sliders to select status of 6 parameters
      sliderInput("number", "Number:",
                  min = 1, max = 721, value = c(1,721)),
      sliderInput("total", "Total:",
                  min = 180, max = 780, value = c(180,780)),
      sliderInput("hp", "HP:",
                  min = 1, max = 255, value = c(5,255)),
      sliderInput("attack", "Attack:",
                  min = 5, max = 190, value = c(5,190)),
      sliderInput("defense", "Defense:",
                  min = 5, max = 230, value = c(5,230)),
      sliderInput("spatk", "Special Atk:",
                  min = 10, max = 194, value = c(10,194)),
      sliderInput("spdef", "Spcial Def:",
                  min = 20, max = 230, value = c(20,230)),
      sliderInput("speed", "Speed:",
                  min = 5, max = 180, value = c(5,180)),
      
      # checkboxes to select type
      tags$p("Type 1"),
      checkboxInput("normal1", "Normal", TRUE),
      checkboxInput("grass1", "Grass", TRUE),
      checkboxInput("fire1", "Fire", TRUE),
      checkboxInput("water1", "Water", TRUE),
      checkboxInput("bug1", "Bug", TRUE),
      checkboxInput("flying1", "Flying", TRUE),
      checkboxInput("electric1", "Electric", TRUE),
      checkboxInput("ice1", "Ice", TRUE),
      checkboxInput("rock1", "Rock", TRUE),
      checkboxInput("ground1", "Ground", TRUE),
      checkboxInput("poison1", "Poison", TRUE),
      checkboxInput("fighting1", "Fighting", TRUE),
      checkboxInput("psychic1", "Psychic", TRUE),
      checkboxInput("ghost1", "Ghost", TRUE),
      checkboxInput("dark1", "Dark", TRUE),
      checkboxInput("dragon1", "Dragon", TRUE),
      checkboxInput("steel1", "Steel", TRUE),
      checkboxInput("fairy1", "Fairy", TRUE)
    ),
    
    mainPanel(
      DT::dataTableOutput('dt1'),
      plotOutput('radarPlot'),
      plotOutput('scatterPlot')
    )
  )
  

  
)