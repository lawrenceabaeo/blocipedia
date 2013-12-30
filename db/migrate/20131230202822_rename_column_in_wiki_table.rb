class RenameColumnInWikiTable < ActiveRecord::Migration
  def change
    rename_column :wikis, :access, :public_access
  end
end
