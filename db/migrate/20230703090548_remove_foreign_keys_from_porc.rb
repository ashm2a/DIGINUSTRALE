class RemoveForeignKeysFromPorc < ActiveRecord::Migration[7.0]
  def change
    remove_reference :porcs, :coppa
    remove_reference :porcs, :prisuttu
    remove_reference :porcs, :lonzu
  end
end
