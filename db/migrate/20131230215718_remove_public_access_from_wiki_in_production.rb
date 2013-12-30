class RemovePublicAccessFromWikiInProduction < ActiveRecord::Migration
  # NOTE: This change is for production only. 
  # Due to some incompatibilities and odd sequences, dev db and production db are out of sync
  def change
    remove_column :wikis, :public_access
  end
end
