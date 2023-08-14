class AddQuartoToReservas < ActiveRecord::Migration[7.0]
  def change
    add_reference :reservas, :quarto, null: false, foreign_key: true
  end
end
