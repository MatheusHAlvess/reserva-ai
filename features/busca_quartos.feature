Feature: Busca de quartos
  As a Usuario do sistema
  I want to buscar quartos pelo numero, quantidade de hospedes e faixa de preco
  So that eu visualize os quartos que atendem aos criterios informados

  Scenario: Buscar quarto existente por numero
    Given eu estou na tela de busca de quartos
    And existe um quarto ja cadastrado com numero 101
    When eu informo o numero "101" e clico em Buscar
    Then o sistema deve retornar o "101" quarto encontrado na lista de resultados

  Scenario: Buscar quartos por numero inexistente
    Given eu estou na tela de busca de quartos
    And nao existe um quarto cadastrado com numero 102
    When eu informo o numero "155" e clico em Buscar
    Then o sistema deve mostrar que nenhum quarto foi encontrado

  Scenario: O sistema deve retornar o quarto encontrado com capacidade de {string} na lista de resultados
    Given eu estou na tela de busca de quartos
    And existe um quarto cadastrado com capacidade para 2 hospedes
    When eu informo a quantidade de hospedes "0 - 4" e clico em Buscar
    Then o sistema deve retornar o quarto encontrado com capacidade de "2" na lista de resultados

  Scenario: Busca de quarto por intervalo de hospedes que nao existe
    Given eu estou na tela de busca de quartos
    And nao existe um quarto cadastrado com capacidade para 5 hospedes
    When eu informo a quantidade de hospedes "5 - 10" e clico em Buscar
    Then o sistema deve mostrar que nenhum quarto foi encontrado

  Scenario: Buscar quartos por faixa de preco valida
    Given eu estou na tela de busca de quartos
    And existe um quarto cadastrado com preco de 40 reais
    When eu informo a faixa de preco "Até R$50" e clico em Buscar
    Then o sistema deve retornar o quarto encontrado com valor de 40 reais na lista de resultados
