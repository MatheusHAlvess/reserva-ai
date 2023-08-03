require "test_helper"

class ClienteTest < ActiveSupport::TestCase

  test "Salvar um cliente" do
    cliente = Cliente.new(
      nome_completo: "Lucas Da Silva",
      data_nascimento: Date.new(2000, 5, 15),
      cpf: "98765432100",
      email: "lucassilva@gmail.com"
    )
    assert cliente.save
  end

  test "Não salvar cliente sem nome" do
    cliente = Cliente.new(
      data_nascimento: Date.new(1990, 5, 15),
      cpf: "34219876543",
      email: "joao@example.com")
    assert_not cliente.save
  end

  test "Não salvar dois clientes com mesmo CPF" do
    clienteTemp = Cliente.new(
      nome_completo: "José Maria",
      data_nascimento: Date.new(2007, 5, 30),
      cpf: "34219833543",
      email: "jose@gmail.com"
    )
    clienteTemp.save
    cliente = Cliente.new(
      nome_completo: "Maria Souza",
      data_nascimento: Date.new(1985, 8, 20),
      cpf: "34219833543",
      email: "maria@gmail.com"
    )
    assert_not cliente.save
  end

  test "não Salvar cliente com CPF invalido" do
    cliente = Cliente.new(
      nome_completo: "Carlos Pereira",
      data_nascimento: Date.new(1975, 12, 10),
      cpf: "ABC1234223",
      email: "carlos@example.com"
    )
    assert_not cliente.save
  end

  test "não deve salvar cliente com  email invalido" do
    cliente = Cliente.new(
      nome_completo: "Ana Lima",
      data_nascimento: Date.new(1995, 3, 25),
      cpf: "98765432100",
      email: "3333333333.com"
    )
    assert_not cliente.save
  end


end
