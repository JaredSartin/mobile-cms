class FixIndexesOnAppAgain < ActiveRecord::Migration
  def change
    remove_index :apps, :cname

    add_index :apps, :cname
  end
end
