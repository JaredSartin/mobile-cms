class AddGaToApps < ActiveRecord::Migration
  def change
    add_column :apps, :ga_key, :string
  end
end
