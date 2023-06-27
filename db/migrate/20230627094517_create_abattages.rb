class CreateAbattages < ActiveRecord::Migration[7.0]
  def change
    create_table :abattages do |t|
      t.integer :numéro_lot
      t.date :date
      t.string :lieu

      t.timestamps
    end
  end
end
