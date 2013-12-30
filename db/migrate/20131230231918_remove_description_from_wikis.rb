class RemoveDescriptionFromWikis < ActiveRecord::Migration
  def change
    remove_column :wikis, :description
  end
end
