class AddVermifugesToPorcs < ActiveRecord::Migration[7.0]
  def change
    add_column :porcs, :vermifuge_2_mois, :boolean, default: false
    add_column :porcs, :vermifuge_6_mois, :boolean, default: false
    add_column :porcs, :vermifuge_12_mois, :boolean, default: false
  end
end
