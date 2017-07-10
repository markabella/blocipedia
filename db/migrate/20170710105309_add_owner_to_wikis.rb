class AddOwnerToWikis < ActiveRecord::Migration
  def change
    add_column :wikis, :owner, :string
  end
end
