class AddColumnToCoppa < ActiveRecord::Migration[7.0]
  def change
    add_column :coppas, :quantité, :integer, default: nil
  end
end
