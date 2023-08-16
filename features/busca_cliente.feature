Feature: Busca de clientes
  As a Usuario do sistema
  I want to buscar um cliente pelo email, nome ou CPF
  So that eu visualize o cliente correto para realizar uma reserva

  Scenario: Buscar cliente por email valido
    Given que eu seja usuario do sistema
    When o usuario busca por um cliente com o email "cliente@example.com"
    Then o sistema exibe as informacoes do cliente "Cliente Exemplo"

  Scenario: Buscar cliente por nome valido
    Given que eu seja usuario do sistema
    When o usuario busca por um cliente com o nome "Cliente Exemplo"
    Then o sistema exibe as informacoes do cliente "Cliente Exemplo"

  Scenario: Buscar cliente por CPF valido
    Given que eu seja usuario do sistema
    When o usuario busca por um cliente com o CPF valido "03135892751"
    Then o sistema exibe as informacoes do cliente "Cliente Exemplo"

  Scenario: Buscar cliente por nome inexistente
    Given que eu seja usuario do sistema
    When o usuario busca por um cliente com o nome "Maria Oliveira"
    Then o sistema exibe uma mensagem de cliente não encontrado

  Scenario: Buscar cliente por CPF inexistente
    Given que eu seja usuario do sistema
    When o usuario busca por um cliente com o CPF inexistente "98765432100"
    Then o sistema exibe uma mensagem de cliente não encontrado
