class FixIndexesOnApp < ActiveRecord::Migration
  def change
    remove_index :apps, :cname
    remove_index :apps, :subdomain

    add_index :apps, :cname, unique: true
    add_index :apps, :subdomain, unique: true
  end
end
