class AddDataToWikis < ActiveRecord::Migration
  def change
    add_column :wikis, :collaborators, :string
  end
end
