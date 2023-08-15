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

end
