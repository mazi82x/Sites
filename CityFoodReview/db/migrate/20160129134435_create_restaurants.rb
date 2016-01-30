class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :name
      t.text :address
      t.text :remarks
      t.string :cuisine
      t.string :photo
      t.references :city, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
