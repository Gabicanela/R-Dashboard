# Análise de Dados de Estudantes - Dashboard em R

## Visão Geral

Este projeto tem como objetivo analisar dados de estudantes de uma escola e apresentar os resultados através de dashboards interativos construídos na linguagem R. O foco deste trabalho é aplicar e aprimorar habilidades na criação de dashboards, utilizando bibliotecas específicas do R para visualização de dados.

## Objetivos

- **Analisar Dados:** Explorar e analisar dados demográficos, acadêmicos e comportamentais dos estudantes.
- **Visualização:** Criar dashboards interativos para visualizar os insights obtidos na análise.
- **Aplicação Prática:** Colocar em prática o aprendizado de construção de dashboards com R.

## Estrutura do Projeto

- **`data/`**: Contém os datasets utilizados para a análise.
  - `students_data.csv`: Dados dos estudantes, incluindo informações pessoais, notas, frequência, etc.
- **`scripts/`**: Scripts em R para análise e construção dos dashboards.
  - `data_cleaning.R`: Script para limpeza e pré-processamento dos dados.
  - `data_analysis.R`: Script para a análise exploratória dos dados.
  - `dashboard_creation.R`: Script para a construção dos dashboards.
- **`outputs/`**: Relatórios e gráficos gerados a partir da análise.
- **`README.md`**: Documento explicativo sobre o projeto.

## Tecnologias Utilizadas

- **R**: Linguagem de programação utilizada para análise de dados e construção dos dashboards.
- **Shiny**: Framework utilizado para criar aplicações web interativas diretamente no R.
- **ggplot2**: Biblioteca para visualização de dados.
- **dplyr**: Pacote utilizado para manipulação de dados.

## Etapas do Projeto

1. **Coleta e Preparação dos Dados**: Importação e limpeza dos dados de estudantes.
2. **Análise Exploratória dos Dados (EDA)**: Exploração das variáveis e identificação de padrões ou outliers.
3. **Criação dos Dashboards**: Desenvolvimento dos dashboards para visualização dos resultados da análise.
4. **Interpretação e Conclusões**: Interpretação dos resultados obtidos e possíveis recomendações baseadas nos insights.

## Como Executar

1. Clone o repositório:
   ```bash
   git clone https://github.com/seu-usuario/seu-repositorio.git
   
2. Instale os pacotes necessários:
   ```bash
    install.packages(c("shiny", "ggplot2", "dplyr"))

3. Execute o script de criação dos dashboards:
   ```bash
    source("scripts/dashboard_creation.R")

4.Acesse o dashboard através do navegador para interagir com as visualizações.


![image](https://github.com/user-attachments/assets/bb2eaefc-5482-41c8-ab04-ba4a6f544519)

![image](https://github.com/user-attachments/assets/81aaef8d-97f5-4317-b222-78582e0e7387)

![image](https://github.com/user-attachments/assets/5ff7b744-5db6-45aa-822d-d9370c453cef)
