class AddColumnsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :nom, :string
    add_column :users, :prénom, :string
    add_column :users, :EDE, :string
    add_column :users, :adresse, :string
    add_column :users, :code_postal, :integer
    add_column :users, :ville, :string
  end
end
