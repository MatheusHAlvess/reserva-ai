class Quarto < ApplicationRecord
  has_many :reservas, dependent: :destroy, inverse_of: :quarto
  has_many :clientes, through: :reservas

  validates :numero,
            presence: true,
            comparison: {
              greater_than: 0,
              message: 'deve ser maior que 0'
            }
  validates :preco,
            presence: true,
            comparison: {
              greater_than: 0,
              message: 'deve ser maior que 0'
            }
  validates :capacidade,
            presence: true,
            comparison: {
              greater_than: 0,
              message: 'deve ser maior que 0'
            }
end
