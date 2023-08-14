class RemoveQuartoFromReservas < ActiveRecord::Migration[7.0]
  def change
    remove_column :reservas, :quarto, :integer
  end
end
