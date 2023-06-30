class AddColumnsToPorcs < ActiveRecord::Migration[7.0]
  def change
    add_reference :porcs, :coppa, foreign_key: true
    add_reference :porcs, :prisuttu, foreign_key: true
    add_reference :porcs, :lonzu, foreign_key: true
  end
end
