class Reserva < ApplicationRecord
  belongs_to :cliente
  belongs_to :quarto

  validates :entrada,
            presence: true,
            comparison: {
              greater_than: Time.zone.today,
              message: 'deve ser futura a hoje'
            }
  validates :saida,
            presence: true,
            comparison: {
              greater_than: :entrada,
              message: 'deve ser futura a entrada'
            }

  validate :quarto_reservado_duas_vezes

  def quarto_reservado_duas_vezes
    unless quarto.nil?
      quarto.reservas.each do |reserva|
        next unless (entrada < reserva.saida) and (saida > reserva.entrada)
        eformat = reserva.entrada.strftime('%d/%m/%Y')
        sformat = reserva.saida.strftime('%d/%m/%Y')
        errors.add(:quarto, "#{quarto.numero} ja esta reservado de #{eformat} ate #{sformat}")
      end
    end
  end

  def self.buscar_por_cpf(cpf)
    cliente = Cliente.find_by(cpf: cpf)
    return [] unless cliente

    where(cliente: cliente)
  end
end
