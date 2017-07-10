class AddCollaboratorsToWikis < ActiveRecord::Migration
  def change
    add_column :wikis, :collaborator, :string
  end
end
