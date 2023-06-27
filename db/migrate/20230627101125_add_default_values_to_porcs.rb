class AddDefaultValuesToPorcs < ActiveRecord::Migration[7.0]
  def change
    change_column_default :porcs, :poids, nil
    change_column_default :porcs, :décès, false
    change_column_default :porcs, :date_décès, nil
    change_column_default :porcs, :abattu, false
    change_column_default :porcs, :poids_carcasse, nil
    change_column_default :porcs, :epaisseur_lard, nil
    change_column_default :porcs, :ph, nil
    change_column_default :porcs, :eligible_AOP, false
  end
end
