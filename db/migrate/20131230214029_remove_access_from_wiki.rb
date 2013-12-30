class RemoveAccessFromWiki < ActiveRecord::Migration
  def change
    remove_column :wikis, :access
  end
end
