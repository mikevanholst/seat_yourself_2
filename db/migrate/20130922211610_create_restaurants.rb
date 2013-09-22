class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :name
      t.text :address
      t.string :price_range
      t.string :neighbourhood
      t.integer :seats
      t.text :description
      t.string :category
      t.string :phone
    

      t.timestamps
    end
  end
end
