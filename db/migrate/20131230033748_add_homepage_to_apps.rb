class AddHomepageToApps < ActiveRecord::Migration
  def change
    add_column :apps, :homepage_id, :integer
  end
end
