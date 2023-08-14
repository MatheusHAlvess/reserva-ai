Feature: Gerenciamento de quarto
  As a Usuario do sistema
  I want to registrar, editar, exibir e remover um quarto
  So that eu mantenha os quartos do hotel atualizados

  Scenario: Registrar um novo quarto
    Given estou na pagina de cadastro de quartos
    When preencho o formulario com numero 1 preco 9.99 e capacidade 1
    And eu clico no botao Cadastrar quarto
    Then eu vejo o quarto 1 cadastrado

  Scenario: Editar um quarto
    Given existe um quarto cadastrado com numero 1
    And estou na lista de quartos
    When eu vejo o quarto 1
    And eu clico na opcao Visualizar quarto
    And eu clico na opcao Editar
    And preencho o formulario com numero 2 preco 9.99 e capacidade 1
    And eu clico no botao Cadastrar quarto
    Then eu vejo o quarto 2 cadastrado

  Scenario: Tentar cadastrar um quarto com numero negativo
    Given estou na pagina de cadastro de quartos
    When preencho o formulario com numero -1 preco 9.99 e capacidade 1
    And eu clico no botao Cadastrar quarto
    Then devo ver uma mensagem de erro informando que o "numero" do quarto e invalido

  Scenario: Tentar cadastrar um quarto com preco negativo
    Given estou na pagina de cadastro de quartos
    When preencho o formulario com numero 1 preco -9.99 e capacidade 1
    And eu clico no botao Cadastrar quarto
    Then devo ver uma mensagem de erro informando que o "preco" do quarto e invalido

  Scenario: Remover um quarto
    Given existe um quarto cadastrado com numero 1
    And estou na lista de quartos
    When eu vejo o quarto 1
    And eu clico na opcao Visualizar quarto
    And eu clico no botao Deletar
    Then o quarto 1 nao deve constar na lista de quartos