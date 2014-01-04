class ChangeAppSubdomainToShortname < ActiveRecord::Migration
  def change
    remove_index :apps, :subdomain
    rename_column :apps, :subdomain, :shortname
    
    add_index :apps, :shortname, unique: true
  end
end
