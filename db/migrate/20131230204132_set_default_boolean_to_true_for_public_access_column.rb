class SetDefaultBooleanToTrueForPublicAccessColumn < ActiveRecord::Migration
  def change
    change_column :wikis, :public_access, :boolean, default: true
  end
end
