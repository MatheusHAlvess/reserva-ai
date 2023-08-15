require "test_helper"

class QuartoTest < ActiveSupport::TestCase

  test "Criar um quarto válido" do
    quarto = Quarto.new(
      numero: 101,
      preco: 100.0,
      capacidade: 2
    )

    assert quarto.save
  end

  test "Editar um quarto" do
    quarto = Quarto.create(
      numero: 101,
      preco: 100.0,
      capacidade: 2
    )
    quarto.save()
    novo_preco = 120.0
    quarto.update(preco: novo_preco)
    quarto.save()

    assert_equal novo_preco, quarto.reload.preco
  end

  test "Remover um quarto" do
    quarto = Quarto.create(
      numero: 101,
      preco: 100.0,
      capacidade: 2
    )
    quarto.save()
    id_quarto = quarto.id
    quarto.destroy

    assert_not Quarto.exists?(id_quarto)
  end

  test "Filtrar quartos por faixa de preço" do
    quarto1 = Quarto.create(numero: 101, preco: 101.0, capacidade: 2)
    quarto2 = Quarto.create(numero: 102, preco: 200.0, capacidade: 5)
    quarto3 = Quarto.create(numero: 103, preco: 52.0, capacidade: 1)

    resultado = Quarto.filtrar_quartos(nil, nil, "51-100")

    assert_not_includes resultado, quarto1
    assert_not_includes resultado, quarto2
    assert_includes resultado, quarto3
  end

  test "Filtrar quartos por quantidade de hóspedes" do
    quarto1 = Quarto.create(numero: 101, preco: 100.0, capacidade: 2)
    quarto2 = Quarto.create(numero: 102, preco: 200.0, capacidade: 5)
    quarto3 = Quarto.create(numero: 103, preco: 50.0, capacidade: 1)

    resultado = Quarto.filtrar_quartos(nil, "0-4", nil)

    assert_includes resultado, quarto1
    assert_not_includes resultado, quarto2
    assert_includes resultado, quarto3
  end

  test "Filtrar quartos por número" do
    quarto1 = Quarto.create(numero: 101, preco: 100.0, capacidade: 2)
    quarto2 = Quarto.create(numero: 102, preco: 200.0, capacidade: 5)
    quarto3 = Quarto.create(numero: 103, preco: 50.0, capacidade: 1)

    resultado = Quarto.filtrar_quartos(101, nil, nil)

    assert_includes resultado, quarto1
    assert_not_includes resultado, quarto2
    assert_not_includes resultado, quarto3
  end

end
