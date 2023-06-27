class ChangeNullFalseToNullTrueFromAbattage < ActiveRecord::Migration[7.0]
  def change
    change_column_null :porcs, :abattage_id, true
  end
end
