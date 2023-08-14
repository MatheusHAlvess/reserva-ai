class CreateQuartos < ActiveRecord::Migration[7.0]
  def change
    create_table :quartos do |t|
      t.integer :numero
      t.decimal :preco
      t.integer :capacidade

      t.timestamps
    end
  end
end
