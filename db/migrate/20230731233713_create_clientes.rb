class CreateClientes < ActiveRecord::Migration[7.0]
  def change
    create_table :clientes do |t|
      t.string :nome_completo
      t.date :data_nascimento
      t.string :cpf
      t.string :email

      t.timestamps
    end
  end
end
