class Quarto < ApplicationRecord
  has_many :reservas, dependent: :destroy, inverse_of: :quarto
  has_many :clientes, through: :reservas

  validates :numero,
            presence: true,
            comparison: {
              greater_than: 0
            }
  validates :preco,
            presence: true,
            comparison: {
              greater_than: 0
            }
  validates :capacidade,
            presence: true,
            comparison: {
              greater_than: 0
            }

  def quarto_ocupado?(entrada, saida)
    reservas.each do |reserva|
      next unless (entrada < reserva.saida) and (saida > reserva.entrada)
      return true
    end
    false
  end
end
