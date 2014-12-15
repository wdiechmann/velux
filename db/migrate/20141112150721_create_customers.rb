class CreateCustomers < ActiveRecord::Migration
  # def change
  # end
  def up
    create_table :customers do |t|
      t.string :name
      t.string :street
      t.string :zip_city
      t.string :phone
      t.string :email
      t.string :lng_lat
      t.text :body
      t.timestamps
    end
  end
 
  def down
    drop_table :customers
  end
end
