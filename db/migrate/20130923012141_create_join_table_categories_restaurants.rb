class CreateJoinTableCategoriesRestaurants < ActiveRecord::Migration
  def change
    create_join_table :categories, :restaurants do |t|
      t.index :restaurant_id
      t.index :restaurant_id
    end
  end
end
