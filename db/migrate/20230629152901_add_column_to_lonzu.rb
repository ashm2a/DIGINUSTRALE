class AddColumnToLonzu < ActiveRecord::Migration[7.0]
  def change
    add_column :lonzus, :quantité, :integer, default: nil
  end
end
