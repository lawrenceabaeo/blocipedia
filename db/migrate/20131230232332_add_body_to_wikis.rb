class AddBodyToWikis < ActiveRecord::Migration
  def change
    add_column :wikis, :body, :string
  end
end
