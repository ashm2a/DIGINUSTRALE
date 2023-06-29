class AddColumnsToPorcs < ActiveRecord::Migration[7.0]
  def change
    add_column :porcs, :q_coppa, :integer, default: 0
    add_column :porcs, :q_prisuttu, :integer, default: 0
    add_column :porcs, :q_lonzu, :integer, default: 0
  end
end
