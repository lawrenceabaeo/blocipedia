class CreateWikis < ActiveRecord::Migration
  def change
    create_table :wikis do |t|
      t.string :title
      t.string :description
      t.string :access
      t.references :user, index: true

      t.timestamps
    end
  end
end
