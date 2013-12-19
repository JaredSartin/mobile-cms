class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.integer :page_id
      t.integer :client_id
      t.integer :order
      t.string :title
      t.text :content

      t.timestamps
    end
    add_index :pages, :page_id
    add_index :pages, :client_id
  end
end
