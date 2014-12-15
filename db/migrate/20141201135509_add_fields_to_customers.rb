class AddFieldsToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :country, :string, default: 'Danmark'
    add_column :customers, :contact, :string, default: ''
  end
end
