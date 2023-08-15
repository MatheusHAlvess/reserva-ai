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
  def self.filtrar_quartos(numero, quantidade_hospedes_intervalo, faixa_preco_intervalo)
    query = self.all

    query = query.where(numero: numero) if numero.present?

    if quantidade_hospedes_intervalo.present?
      min_capacidade, max_capacidade = parse_intervalo(quantidade_hospedes_intervalo)
      query = query.where(capacidade: min_capacidade..max_capacidade)
    end

    if faixa_preco_intervalo.present?
      min_preco, max_preco = parse_intervalo_preco(faixa_preco_intervalo)
      query = query.where(preco: min_preco..max_preco)
    end

    query
  end

  def self.parse_intervalo_preco(intervalo)
    case intervalo
    when '0-50'
      [0, 50]
    when '51-100'
      [51, 100]
    when '101+'
      [101, Float::INFINITY]
    else
      [0, Float::INFINITY]
    end
  end

  def self.parse_intervalo(intervalo)
    case intervalo
    when '0-4'
      [0, 4]
    when '5-10'
      [5, 10]
    when '11+'
      [11, Float::INFINITY]
    else
      [0, Float::INFINITY]
    end
  end
end
