class CreateProjects < ActiveRecord::Migration
  # def change
  # end
  def up
    create_table :projects do |t|
      t.string :address
      t.string :lng_lat
      t.string :title
      t.string :image
      t.string :amount
      t.text :body
      t.text :links
      t.timestamps
    end
  end

  def down
    drop_table :projects
  end
end
