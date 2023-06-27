class CreatePorcs < ActiveRecord::Migration[7.0]
  def change
    create_table :porcs do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :boucle
      t.integer :boucle_mère
      t.integer :boucle_père
      t.date :date_de_naissance
      t.string :sexe
      t.float :poids
      t.float :décès
      t.date :date_décès
      t.boolean :abattu
      t.references :abattage, null: false, foreign_key: true
      t.float :poids_carcasse
      t.float :epaisseur_lard
      t.float :ph
      t.boolean :eligible_AOP

      t.timestamps
    end
  end
end
