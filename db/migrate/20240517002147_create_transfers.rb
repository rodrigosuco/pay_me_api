class CreateTransfers < ActiveRecord::Migration[7.1]
  def change
    create_table :transfers do |t|
      t.references :user, null: false, foreign_key: true
      t.string :recebedor
      t.decimal :value

      t.timestamps
    end
  end
end
