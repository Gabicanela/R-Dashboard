install.packages("readxl")
install.packages("shiny")
install.packages("shinydashboard")
install.packages("ggplot2")
install.packages("janitor")


library(shiny)
library(shinydashboard)
library(readxl)
library(janitor)
library(dplyr)
library(ggplot2)

# Carregando os dados
dados <- read_xlsx("./dados/estudantes.xlsx")

# Limpeza e transformação dos dados
dados <- dados %>%
  mutate(
    sexo = as.factor(sexo),    # Convertendo 'sexo' para fator
    idade = as.integer(idade), # Convertendo 'idade' para inteiro
    disciplinas = as.factor(disciplinas), # Convertendo 'disciplinas' para fator
    cor = as.factor(cor)       # Convertendo 'cor' para fator
  )

glimpse(dados)


# Gerando médias dos dados separados por sexo
medias_sexo <- dados %>%
  group_by(sexo) %>%
  summarise(
    media_idade = round(mean(idade, na.rm = TRUE), 1),
    media_nota = round(mean(nota, na.rm = TRUE), 1),
    media_altura = round(mean(altura, na.rm = TRUE), 1),
    media_peso = round(mean(peso, na.rm = TRUE), 1)
  )


# Contando a quantidade de estudantes por sexo
contagem_sexo <- dados %>%
  group_by(sexo) %>%
  summarise(quantidade = n())


server <- function(input, output, session) {
  observe({
    metrica <- input$metrica
    valor_metrica <- NULL
    
    if (metrica == "Idade") {
      valor_metrica <- medias_sexo %>% select(sexo, media_idade) %>% rename(media = media_idade)
    } else if (metrica == "Nota") {
      valor_metrica <- medias_sexo %>% select(sexo, media_nota) %>% rename(media = media_nota)
    } else if (metrica == "Altura") {
      valor_metrica <- medias_sexo %>% select(sexo, media_altura) %>% rename(media = media_altura)
    } else if (metrica == "Peso") {
      valor_metrica <- medias_sexo %>% select(sexo, media_peso) %>% rename(media = media_peso)
    }
    
    output$valor_metrica <- renderText({
      HTML(paste("Masculino:", valor_metrica$media[valor_metrica$sexo == "masculino"], 
                 "<br>Feminino:", valor_metrica$media[valor_metrica$sexo == "feminino"]))
      
    })
   
  })
  
  output$total_estudantes <- renderText({
    total <- nrow(dados)
    total_masculino <- contagem_sexo$quantidade[contagem_sexo$sexo == "masculino"]
    total_feminino <- contagem_sexo$quantidade[contagem_sexo$sexo == "feminino"]
  
   HTML(paste("Total de Estudantes:", total, 
              "<br>Masculino:", total_masculino, 
              "<br>Feminino:", total_feminino)) 
  })
    
  # Gráfico Notas por Sexo
  output$plot_notas_sexo <- renderPlot({
    ggplot(dados, aes(x = idade, y = nota, color = sexo, group = sexo)) +
      geom_line() +
      geom_point() +
      labs(title = "Notas dos Estudantes por Sexo e Idade", 
           x = "Idade", 
           y = "Nota") +
      theme_minimal()
  })
  
  # Gráfico Idade - Masculino
  output$plot_idade_masculino <- renderPlot({
    dados_masculinos <- dados[dados$sexo == "masculino",]
    hist(dados_masculinos$idade,
         main = "Idade - Masculino",
         xlab = "Idade",
         breaks = "Sturges")
  })
  
  # Gráfico Altura - Masculino
  output$plot_altura_masculino <- renderPlot({
    dados_masculinos <- dados[dados$sexo == "masculino",]
    hist(dados_masculinos$altura,
         main = "Altura - Masculino",
         xlab = "Altura",
         breaks = "Sturges")
  })
  
  # Gráfico Frequência Cor - Masculino
  output$plot_freq_cor_masc <- renderPlot({
    # Filtra dados masculinos
    dados_masculinos <- dados[dados$sexo == "masculino", ]
    
    freq_data <- dados_masculinos %>%
      group_by(cor) %>%
      summarise(Freq = n()) %>%
      mutate(perc = Freq / sum(Freq) * 100,
             ypos = cumsum(perc) - 0.5 * perc)
    
    ggplot(freq_data, aes(x="", y=perc, fill=cor)) +
      geom_bar(stat="identity", width=1, color="white") +
      coord_polar("y", start=0) +
      theme_void() + 
      geom_text(aes(y = cumsum(perc) - perc / 2, label = paste0(round(perc, 1), "%")), color = "white", size=6) +
      scale_fill_brewer(palette="Set2") + 
      guides(fill=guide_legend(title="Cores"))+
      ggtitle("Proporção de preferência de cor - Masculino")
  })
  
  # Gráfico Idade - Feminino
  output$plot_idade_feminino <- renderPlot({
    dados_femininos <- dados[dados$sexo == "feminino", ]
    hist(dados_femininos$idade,
         main = "Idade - Feminino",
         xlab = "Idade",
         breaks = "Sturges")
  })
  
  # Gráfico Altura - Feminino
  output$plot_altura_feminino <- renderPlot({
    dados_femininos <- dados[dados$sexo == "feminino", ]
    hist(dados_femininos$altura,
         main = "Altura - Feminino",
         xlab = "Altura",
         breaks = "Sturges")
  })
  
  # Gráfico Frequência Cor - Feminino
  output$plot_freq_cor_femi <- renderPlot({
    # Filtra dados femininos
    dados_femininos <- dados[dados$sexo == "feminino", ]
  
    freq_data <- dados_femininos %>%
      group_by(cor) %>%
      summarise(Freq = n()) %>%
      mutate(perc = Freq / sum(Freq) * 100,
             ypos = cumsum(perc) - 0.5 * perc)
    
    ggplot(freq_data, aes(x="", y=perc, fill=cor)) +
      geom_bar(stat="identity", width=1, color="white") +
      coord_polar("y", start=0) +
      theme_void() + 
      geom_text(aes(y = cumsum(perc) - perc / 2, label = paste0(round(perc, 1), "%")), color = "white", size=6) +
      scale_fill_brewer(palette="Set1") + 
      guides(fill=guide_legend(title="Cores"))+
      ggtitle("Proporção de preferência de cor - Feminino")
    
  })
}