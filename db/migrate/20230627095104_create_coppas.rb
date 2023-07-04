class CreateCoppas < ActiveRecord::Migration[7.0]
  def change
    create_table :coppas do |t|
      t.references :porc, foreign_key: true
      t.integer :numéro_lot
      t.float :poids
      t.float :epaisseur_lard
      t.float :ph
      t.date :date_mise_au_sel
      t.date :date_sortie_de_sel
      t.integer :durée_fumage
      t.float :poids_sortie_sèche
      t.date :date_entrée_affinage
      t.date :date_sortie_affinage_vente

      t.timestamps
    end
  end
end
