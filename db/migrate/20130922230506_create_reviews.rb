class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.text :content
      t.integer :votes
      t.belongs_to :user
      t.belongs_to :restaurant

      t.timestamps
    end
  end
end
