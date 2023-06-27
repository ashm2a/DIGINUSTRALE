class ChangeDecesToBoolInPorc < ActiveRecord::Migration[7.0]
  def change
    remove_column :porcs, :décès
    add_column :porcs, :décès, :boolean, default: false
  end
end
