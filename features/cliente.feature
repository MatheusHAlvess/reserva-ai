Feature: Gerenciamento de clientes
  As a Usuario do sistema
  I want to registrar, editar e remover um cliente
  So that eu mantenha os clientes do hotel atualizados

  Scenario: Registrar um novo cliente
    Given eu estou na página de cadastro de clientes
    When preencho o formulário com nome "Genario Correia", data de nascimento "1993-08-18", CPF "12345678901" e e-mail "genarioazevedo@gmail.com"
    And eu clico no botão Create Cliente
    Then eu vejo o cliente "Genario Correia" cadastrado

  Scenario: Editar os dados de um cliente
    Given existe um cliente cadastrado com nome "Genario Correia"
    And eu vejo "Genario Correia" e clico em Visualizar Cliente
    And eu clico na opção Editar
    When eu atualizo o formulário com nome "Genario Correia de Azevedo" e e-mail "genarioazevedo@hotmail.com"
    And eu clico no botão Update Cliente
    Then o cliente "Genario Correia de Azevedo" deve constar na lista de clientes cadastrados


  Scenario: Tentar cadastrar cliente com CPF invalido
    Given eu estou na página de cadastro de clientes
    When eu preencho o formulário com nome "Genario Correia de Azevedo", data de nascimento "1993-08-18", CPF inválido "123456789" e e-mail "genarioazevedo@gmail.com"
    And eu clico no botão Create Cliente
    Then devo ver uma mensagem de erro informando que o CPF deve conter 11 dígitos numéricos

  Scenario: Tentar cadastrar cliente com e-mail inválido
    Given eu estou na página de cadastro de clientes
    When preencho o formulário com nome "Genario Correia de Azevedo", data de nascimento "1993-08-18", CPF "98765432109" e e-mail inválido "genarioazevedo@"
    And eu clico no botão Create Cliente
    Then devo ver uma mensagem de erro informando que o e-mail é inválido

  Scenario: Remover um cliente cadastrado
    Given estou na lista de clientes cadastrados
    And existe um cliente cadastrado com nome "Genario Correia de Azevedo"
    And eu vejo "Genario Correia de Azevedo" e clico em Visualizar Cliente
    When clico no botão Deletar do cliente
    Then o cliente "Genario Correia de Azevedo" não deve constar na lista de clientes cadastrados


