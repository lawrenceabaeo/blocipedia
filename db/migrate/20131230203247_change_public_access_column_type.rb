class ChangePublicAccessColumnType < ActiveRecord::Migration
  def change
    change_column :wikis, :public_access, :boolean
  end
end
