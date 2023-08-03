require "test_helper"

class ReservaTest < ActiveSupport::TestCase
  test "Salvar uma reserva válida" do
    cliente = Cliente.create(
      nome_completo: "Lucas Da Silva",
      data_nascimento: Date.new(2000, 5, 15),
      cpf: "98765432100",
      email: "lucassilva@gmail.com"
    )
    reserva = Reserva.new(
      cliente: cliente,
      quarto: 101,
      entrada: Date.tomorrow,
      saida: Date.tomorrow + 3
    )
    assert reserva.save
  end

  test "Não salvar reserva sem número de quarto" do
    cliente = Cliente.create(
      nome_completo: "Lucas Da Silva",
      data_nascimento: Date.new(2000, 5, 15),
      cpf: "98765432100",
      email: "lucassilva@gmail.com"
    )
    reserva = Reserva.new(
      cliente: cliente,
      entrada: Date.tomorrow,
      saida: Date.tomorrow + 3
    )
    assert_not reserva.save
  end

  test "Não salvar reserva com data de entrada inválida (passada)" do
    cliente = Cliente.create(
      nome_completo: "Lucas Da Silva",
      data_nascimento: Date.new(2000, 5, 15),
      cpf: "98765432100",
      email: "lucassilva@gmail.com"
    )
    reserva = Reserva.new(
      cliente: cliente,
      quarto: 101,
      entrada: Date.yesterday,
      saida: Date.tomorrow
    )
    assert_not reserva.save
  end

  test "Não salvar reserva com data de saída antes da data de entrada" do
    cliente = Cliente.create(
      nome_completo: "Lucas Da Silva",
      data_nascimento: Date.new(2000, 5, 15),
      cpf: "98765432100",
      email: "lucassilva@gmail.com"
    )
    reserva = Reserva.new(
      cliente: cliente,
      quarto: 101,
      entrada: Date.tomorrow,
      saida: Date.yesterday
    )
    assert_not reserva.save
  end

end
