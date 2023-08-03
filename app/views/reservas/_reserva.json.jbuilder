json.extract! reserva, :id, :cliente_id, :quarto, :entrada, :saida, :created_at, :updated_at
json.url reserva_url(reserva, format: :json)
