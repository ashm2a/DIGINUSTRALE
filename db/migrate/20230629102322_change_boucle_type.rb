class ChangeBoucleType < ActiveRecord::Migration[7.0]
  def change
    change_column :porcs, :boucle, :string
    change_column :porcs, :boucle_mère, :string
    change_column :porcs, :boucle_père, :string
  end
end
