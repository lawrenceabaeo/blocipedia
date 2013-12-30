class AddPublicAccessToWikis < ActiveRecord::Migration
  def change
    add_column :wikis, :public_access, :boolean, :default => true
  end
end
