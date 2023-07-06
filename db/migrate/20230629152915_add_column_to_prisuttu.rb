class AddColumnToPrisuttu < ActiveRecord::Migration[7.0]
  def change
    add_column :prisuttus, :quantité, :integer, default: nil
  end
end
