class CreateApps < ActiveRecord::Migration
  def change
    create_table :apps do |t|
      t.integer :user_id
      t.string :name
      t.string :cname
      t.string :subdomain

      t.timestamps
    end
    add_index :apps, :cname
    add_index :apps, :subdomain
  end
end
