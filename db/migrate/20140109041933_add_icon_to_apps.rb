class AddIconToApps < ActiveRecord::Migration
  def self.up
    add_attachment :apps, :icon
  end

  def self.down
    remove_attachment :apps, :icon
  end
end
