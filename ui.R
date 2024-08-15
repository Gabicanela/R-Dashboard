install.packages("shiny")
install.packages("shinydashboard")
install.packages("ggplot2")



library(shiny)
library(shinydashboard)


ui <- dashboardPage(
  dashboardHeader(title = "Dashboard"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Home", tabName = "principal", icon = icon("home")),
      menuItem("Masculino", tabName = "masculino", icon = icon("male")),
      menuItem("Feminino", tabName = "feminino", icon = icon("female"))
    )
                   
  ),
  dashboardBody(
    tabItems(
      
      # Página principal
      tabItem(
                tabName = "principal",
                h2("Home"),
                fluidRow(
                  # Caixa de texto para selecionar a métrica
                  box(
                    title = "Selecione a métrica",
                    status = "primary",
                    solidHeader = TRUE,
                    width = 3,
                    selectInput("metrica", "",
                                choices = c("Idade", "Nota", "Altura", "Peso"),
                                selected = "Idade")
                  ),
                  # Saída que mostra o valor digitado pelo usuário
                  box(
                    title = "Médias selecionadas",
                    status = "primary",
                    solidHeader = TRUE,
                    width = 3,
                    height = "130px",
                    uiOutput("valor_metrica")
                  ),
                  box(
                    title = "Total de Estudantes",
                    status = "primary",
                    solidHeader = TRUE,
                    width = 6,
                    height = "130px",
                    uiOutput("total_estudantes")
                  ),
                  box(plotOutput("plot_notas_sexo"), width = 12)
                )
              ),
      
      # Página de dados Masculinos
      tabItem(
        tabName = "masculino",
        h2("Masculino"),
        tabsetPanel(
          tabPanel("Idade", plotOutput("plot_idade_masculino"), title = "Idade"),
          tabPanel("Altura", plotOutput("plot_altura_masculino"), title = "Altura"),
          tabPanel("Cor", plotOutput("plot_freq_cor_masc"), title = "Cor")
          ),
      ),
      # Página de dados Femininos
      tabItem(tabName = "feminino",
              h2("Feminino"),
              tabsetPanel(
                tabPanel("Idade", plotOutput("plot_idade_feminino"), title = "Idade"),
                tabPanel("Altura", plotOutput("plot_altura_feminino"), title = "Altura"),
                tabPanel("Cor", plotOutput("plot_freq_cor_femi"), title = "Cor")
                )
      )  
      )
    )
  )
