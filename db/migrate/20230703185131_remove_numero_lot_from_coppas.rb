class RemoveNumeroLotFromCoppas < ActiveRecord::Migration[7.0]
  def change
    remove_column :coppas, :numéro_lot, :integer
  end
end
