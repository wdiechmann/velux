class AddBrandsToCustomer < ActiveRecord::Migration
  def change
     add_column :customers, :brands, :string, default: ''
  end
end
