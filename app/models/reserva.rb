class Reserva < ApplicationRecord
  belongs_to :cliente

  validates :entrada,
            presence: true,
            comparison: {
              greater_than: Date.today,
              message: 'deve ser futura a hoje'
            }
  validates :saida,
            presence: true,
            comparison: {
              greater_than: :entrada,
              message: 'deve ser futura à entrada'
            }
  validates :quarto,
            presence: true

  validate :quarto_reservado_duas_vezes

  def quarto_reservado_duas_vezes
    Reserva.where(quarto: quarto).each do |reserva|
      next unless (entrada < reserva.saida) and (saida > reserva.entrada)

      eformat = reserva.entrada.strftime('%d/%m/%Y')
      sformat = reserva.saida.strftime('%d/%m/%Y')
      errors.add(:quarto, "#{quarto} já está reservado entre #{eformat} e #{sformat}")
    end
  end

  def self.buscar_por_cpf(cpf)
    cliente = Cliente.find_by(cpf: cpf)
    return [] unless cliente

    where(cliente: cliente)
  end
end
