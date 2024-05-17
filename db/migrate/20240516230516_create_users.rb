class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :nome_completo
      t.string :cpf
      t.string :email
      t.string :senha
      t.decimal :saldo

      t.timestamps
    end
  end
end
