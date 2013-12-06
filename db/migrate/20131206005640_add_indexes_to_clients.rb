class AddIndexesToClients < ActiveRecord::Migration
  def change
    add_index :clients, :cname, unique: true
    add_index :clients, :subdomain, unique: true
  end
end
