Feature: Gerenciamento de reservas
  As a Usuario do sistema
  I want to registrar, editar e remover uma reserva
  So that eu saiba qual cliente reserva qual quarto

  Scenario Outline: Reservar um quarto
    Given existe um cliente cadastrado com nome "<nome_completo>"
    And existe um quarto cadastrado com numero <quarto>
    And estou na pagina de cadastro de reservas
    When preencho o formulario com cliente "<nome_completo>", quarto <quarto>, data de entrada "<entrada>" e saida "<saida>"
    And eu clico no botao Reservar quarto
    Then eu vejo a reserva do quarto <quarto> cadastrada no nome de "<nome_completo>"

    Examples:
      | nome_completo | quarto | entrada    | saida      |
      | Jose Joao     | 1      | 3000-01-01 | 3000-12-12 |
      | ABCD          | 100    | 2100-05-06 | 2150-08-09 |
      | DCBA          | 101    | 2100-01-01 | 2100-02-02 |


  Scenario Outline: Editar uma reserva
    Given existe um cliente cadastrado com nome "<nome_completo>"
    And existe um quarto cadastrado com numero <quarto>
    And o quarto <quarto> esta reservado para "<nome_completo>", com entrada em "<entrada>" e saida "<saida>"
    And estou na lista de reservas
    When eu vejo a reserva do quarto <quarto> cadastrada no nome de "<nome_completo>"
    And eu clico na opcao Visualizar reserva
    And eu clico na opcao Editar
    And eu atualizo o formulario com a entrada "<nova_entrada>"
    And eu clico no botao Reservar quarto
    Then o quarto <quarto> deve estar reservado para "<nome_completo>"

    Examples:
      | nome_completo | quarto | entrada    | saida      | nova_entrada |
      | Jose Joao     | 1      | 3000-01-01 | 3000-12-12 | 3000-01-02   |
      | ABCD          | 100    | 2100-05-06 | 2150-08-09 | 2100-05-07   |
      | DCBA          | 101    | 2100-01-01 | 2100-02-02 | 2100-01-02   |

  Scenario Outline: Tentar reservar um quarto para uma data passada
    Given existe um cliente cadastrado com nome "<nome_completo>"
    And existe um quarto cadastrado com numero <quarto>
    And estou na pagina de cadastro de reservas
    When preencho o formulario com cliente "<nome_completo>", quarto <quarto>, data de entrada "<entrada>" e saida "<saida>"
    And eu clico no botao Reservar quarto
    Then devo ver uma mensagem de erro informando que a data "<data>" e invalida

    Examples:
      | nome_completo | quarto | entrada    | saida      | data            |
      | Jose Joao     | 1      | 3000-01-01 | 2000-01-01 | Saida           |
      | ABCD          | 100    | 2000-01-01 | 3000-01-01 | Entrada         |
      | DCBA          | 101    | 2000-12-12 | 2000-01-01 | Entrada/Saida   |

  Scenario Outline: Tentar reservar um quarto ja reservado
    Given existe um cliente cadastrado com nome "<nome_completo>"
    And existe um quarto cadastrado com numero <quarto>
    And o quarto <quarto> esta reservado para "<nome_completo>", com entrada em "<entrada>" e saida "<saida>"
    And estou na pagina de cadastro de reservas
    When preencho o formulario com cliente "<nome_completo>", quarto <quarto>, data de entrada "<nova_entrada>" e saida "<nova_saida>"
    And eu clico no botao Reservar quarto
    Then devo ver uma mensagem de erro informando que o quarto <quarto> ja esta reservado de "<entrada>" ate "<saida>"

    Examples:
      | nome_completo | quarto | entrada    | saida      | nova_entrada | nova_saida |
      | Jose Joao     | 1      | 3000-01-05 | 3000-01-10 | 3000-01-01   | 3000-01-06 |
      | ABCD          | 100    | 3000-01-05 | 3000-01-10 | 3000-01-09   | 3000-01-15 |
      | DCBA          | 101    | 3000-01-05 | 3000-01-10 | 3000-01-01   | 3000-01-15 |

  Scenario Outline: Remover uma reserva
    Given existe um cliente cadastrado com nome "<nome_completo>"
    And existe um quarto cadastrado com numero <quarto>
    And o quarto <quarto> esta reservado para "<nome_completo>", com entrada em "<entrada>" e saida "<saida>"
    And estou na lista de reservas
    When eu vejo a reserva do quarto <quarto> cadastrada no nome de "<nome_completo>"
    And eu clico na opcao Visualizar reserva
    And eu clico no botao Deletar
    Then a reserva do quarto <quarto> de "<nome_completo>" nao deve constar na lista de reservas

    Examples:
      | nome_completo | quarto | entrada    | saida      |
      | Jose Joao     | 1      | 3000-01-01 | 3000-12-12 |
      | ABCD          | 100    | 2100-05-06 | 2150-08-09 |
      | DCBA          | 101    | 2100-01-01 | 2100-02-02 |