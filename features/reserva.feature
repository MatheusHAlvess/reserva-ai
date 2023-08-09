Feature: Gerenciamento de reservas
  As a Usuario do sistema
  I want to registrar, editar e remover uma reserva
  So that eu saiba qual cliente reserva qual quarto

  Scenario Outline: Reservar um quarto
    Given existe um cliente cadastrado com nome "<nome_completo>"
    And estou na pagina de cadastro de reservas
    When preencho o formulario com cliente "<nome_completo>", quarto <quarto>, data de entrada "<entrada>" e saida "<saida>"
    And eu clico no botao Reservar quarto
    Then eu vejo a reserva do quarto <quarto> cadastrada no nome de "<nome_completo>"

  Examples:
    | nome_completo | quarto | entrada    | saida      |
    | Jose Joao     | 1      | 3000-01-01 | 3000-12-12 |
    | ABCD ABCD     | 100    | 2100-05-06 | 2150-08-09 |
    | DCBA DCBA     | 101    | 2100-01-01 | 2100-02-02 |


  Scenario Outline: Editar uma reserva
    Given existe um cliente cadastrado com nome "<nome_completo>"
    And o quarto <quarto> esta reservado para "<nome_completo>", com entrada em "<entrada>" e saida "<saida>"
    And estou na lista de reservas
    When eu vejo a reserva do quarto <quarto> cadastrada no nome de "<nome_completo>"
    And eu clico na opcao Visualizar reserva
    And eu clico na opcao Editar
    And eu atualizo o formulário com o quarto <novo_quarto>
    And eu clico no botao Reservar quarto
    Then o quarto <novo_quarto> deve estar reservado para "<nome_completo>"

  Examples:
    | nome_completo | quarto | novo_quarto | entrada    | saida      |
    | Jose Joao     | 1      | 2           | 3000-01-01 | 3000-12-12 |
    | ABCD ABCD     | 100    | 200         | 2100-05-06 | 2150-08-09 |
    | DCBA DCBA     | 101    | 300         | 2100-01-01 | 2100-02-02 |

  Scenario Outline: Tentar reservar um quarto para uma data passada
    Given existe um cliente cadastrado com nome "<nome_completo>"
    And estou na pagina de cadastro de reservas
    When preencho o formulario com cliente "<nome_completo>", quarto <quarto>, data de entrada "<entrada>" e saida "<saida>"
    And eu clico no botao Reservar quarto
    Then devo ver uma mensagem de erro informando que a data "<data>" é invalida

  Examples:
    | nome_completo | quarto | entrada    | saida      | data            |
    | Jose Joao     | 1      | 3000-01-01 | 2000-01-01 | Saida           |
    | ABCD ABCD     | 100    | 2000-01-01 | 3000-01-01 | Entrada         |
    | DCBA DCBA     | 101    | 2000-12-12 | 2000-01-01 | Entrada/Saida   |

  Scenario Outline: Tentar reservar um quarto ja reservado
    Given existe um cliente cadastrado com nome "<nome_completo>"
    And o quarto <quarto> esta reservado para "<nome_completo>", com entrada em "<entrada>" e saida "<saida>"
    And estou na pagina de cadastro de reservas
    When preencho o formulario com cliente "<nome_completo>", quarto <quarto>, data de entrada "<nova_entrada>" e saida "<nova_saida>"
    And eu clico no botao Reservar quarto
    Then devo ver uma mensagem de erro informando que o quarto <quarto> já está reservado de "<entrada>" até "<saida>"

  Examples:
    | nome_completo | quarto | entrada    | saida      | nova_entrada | nova_saida |
    | Jose Joao     | 1      | 3000-01-05 | 3000-01-10 | 3000-01-01   | 3000-01-06 |
    | ABCD ABCD     | 100    | 3000-01-05 | 3000-01-10 | 3000-01-09   | 3000-01-15 |
    | DCBA DCBA     | 101    | 3000-01-05 | 3000-01-10 | 3000-01-01   | 3000-01-15 |

  Scenario Outline: Remover uma reserva
    Given existe um cliente cadastrado com nome "<nome_completo>"
    And o quarto <quarto> esta reservado para "<nome_completo>", com entrada em "<entrada>" e saida "<saida>"
    And estou na lista de reservas
    When eu vejo a reserva do quarto <quarto> cadastrada no nome de "<nome_completo>"
    And eu clico na opcao Visualizar reserva
    And eu clico no botao Deletar
    Then a reserva do quarto <quarto> de "<nome_completo>" não deve constar na lista de reservas

  Examples:
    | nome_completo | quarto | entrada    | saida      |
    | Jose Joao     | 1      | 3000-01-01 | 3000-12-12 |
    | ABCD ABCD     | 100    | 2100-05-06 | 2150-08-09 |
    | DCBA DCBA     | 101    | 2100-01-01 | 2100-02-02 |