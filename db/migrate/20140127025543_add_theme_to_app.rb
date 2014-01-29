class AddThemeToApp < ActiveRecord::Migration
  def change
    add_column :apps, :theme_choice, :string, default: 'Default'
    add_column :apps, :theme_content_type, :string
    add_column :apps, :theme_file_name, :string
    add_column :apps, :theme_file_size, :integer
    add_column :apps, :theme_updated_at, :datetime
  end
end
