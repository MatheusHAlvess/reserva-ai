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
            presence: true,
            numericality: {
              greater_than: 0,
              message: 'deve ser maior que 0'
            }

  validate :quarto_reservado_duas_vezes

  def quarto_reservado_duas_vezes
    Reserva.where(quarto: quarto).each do |reserva|
      next unless (entrada < reserva.saida) and (saida > reserva.entrada)

      eformat = reserva.entrada.strftime('%d/%m/%Y')
      sformat = reserva.saida.strftime('%d/%m/%Y')
      errors.add(:quarto, "#{quarto} já está reservado de #{eformat} até #{sformat}")
    end
  end
end
