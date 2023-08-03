class CreateReservas < ActiveRecord::Migration[7.0]
  def change
    create_table :reservas do |t|
      t.references :cliente, null: false, foreign_key: true
      t.integer :quarto
      t.date :entrada
      t.date :saida

      t.timestamps
    end
  end
end
