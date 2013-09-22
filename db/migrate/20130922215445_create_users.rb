class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.boolean :owner
      t.string :password_digest
      t.string :phone
      t.timestamps
    end
  end
end
