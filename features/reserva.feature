Feature: Gerenciamento de reservas
  As a Usuario do sistema
  I want to registrar, editar e remover uma reserva
  So that eu saiba qual cliente reserva qual quarto

  Scenario Outline: Reservar um quarto
    Given existe um cliente cadastrado com nome "<nome_completo>"
    And estou na página de cadastro de reservas
    When preencho o formulário com cliente "<nome_completo>", quarto <quarto>, data de entrada "<entrada>" e saída "<saida>"
    And eu clico no botão Reservar quarto
    Then eu vejo a reserva do quarto <quarto> cadastrada no nome de "<nome_completo>"

  Examples:
    | nome_completo | quarto | entrada    | saida      |
    | José João     | 1      | 3000-01-01 | 3000-12-12 |
    | ABCD          | 100    | 2100-05-06 | 2150-08-09 |
    | DCBA          | 101    | 2100-01-01 | 2100-02-02 |


  Scenario Outline: Editar uma reserva
    Given existe um cliente cadastrado com nome "<nome_completo>"
    And o quarto <quarto> está reservado para "<nome_completo>", com entrada em "<entrada>" e saída "<saida>"
    And estou na lista de reservas
    When eu vejo a reserva do quarto <quarto> cadastrada no nome de "<nome_completo>"
    And eu clico na opção Visualizar reserva
    And eu clico na opção Editar
    And eu atualizo o formulário com o quarto <novo_quarto>
    And eu clico no botão Reservar quarto
    Then o quarto <novo_quarto> deve estar reservado para "<nome_completo>"

  Examples:
    | nome_completo | quarto | novo_quarto | entrada    | saida      |
    | José João     | 1      | 2           | 3000-01-01 | 3000-12-12 |
    | ABCD          | 100    | 200         | 2100-05-06 | 2150-08-09 |
    | DCBA          | 101    | 300         | 2100-01-01 | 2100-02-02 |

  Scenario Outline: Tentar reservar um quarto para uma data passada
    Given existe um cliente cadastrado com nome "<nome_completo>"
    And estou na página de cadastro de reservas
    When preencho o formulário com cliente "<nome_completo>", quarto <quarto>, data de entrada "<entrada>" e saída "<saida>"
    And eu clico no botão Reservar quarto
    Then devo ver uma mensagem de erro informando que a data "<data>" é inválida

  Examples:
    | nome_completo | quarto | entrada    | saida      | data            |
    | José João     | 1      | 3000-01-01 | 2000-01-01 | Saida           |
    | ABCD          | 100    | 2000-01-01 | 3000-01-01 | Entrada         |
    | DCBA          | 101    | 2000-12-12 | 2000-01-01 | Entrada/Saida   |

  Scenario Outline: Tentar reservar um quarto já reservado
    Given existe um cliente cadastrado com nome "<nome_completo>"
    And o quarto <quarto> está reservado para "<nome_completo>", com entrada em "<entrada>" e saída "<saida>"
    And estou na página de cadastro de reservas
    When preencho o formulário com cliente "<nome_completo>", quarto <quarto>, data de entrada "<nova_entrada>" e saída "<nova_saida>"
    And eu clico no botão Reservar quarto
    Then devo ver uma mensagem de erro informando que o quarto <quarto> já está reservado de "<entrada>" até "<saida>"

  Examples:
    | nome_completo | quarto | entrada    | saida      | nova_entrada | nova_saida |
    | José João     | 1      | 3000-01-05 | 3000-01-10 | 3000-01-01   | 3000-01-06 |
    | ABCD          | 100    | 3000-01-05 | 3000-01-10 | 3000-01-09   | 3000-01-15 |
    | DCBA          | 101    | 3000-01-05 | 3000-01-10 | 3000-01-01   | 3000-01-15 |

  Scenario Outline: Remover uma reserva
    Given existe um cliente cadastrado com nome "<nome_completo>"
    And o quarto <quarto> está reservado para "<nome_completo>", com entrada em "<entrada>" e saída "<saida>"
    And estou na lista de reservas
    When eu vejo a reserva do quarto <quarto> cadastrada no nome de "<nome_completo>"
    And eu clico na opção Visualizar reserva
    And eu clico no botão Deletar
    Then a reserva do quarto <quarto> de "<nome_completo>" não deve constar na lista de reservas

  Examples:
    | nome_completo | quarto | entrada    | saida      |
    | José João     | 1      | 3000-01-01 | 3000-12-12 |
    | ABCD          | 100    | 2100-05-06 | 2150-08-09 |
    | DCBA          | 101    | 2100-01-01 | 2100-02-02 |