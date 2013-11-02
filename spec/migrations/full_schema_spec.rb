require_relative '../spec_helper'

describe "full schema spec" do
  include Birdbath

  it 'fits the expected structure' do
    # drop_all_tables
    # see_empty_schema
    # migrate
    see_full_schema
  end

  def see_empty_schema
    assert_schema do |s|
      # is nothing 
    end
  end
  
  def see_full_schema
    assert_schema do |s|
      s.table :clients do |t|
        t.column :id, :integer
        t.column :name, :string
        t.column :subdomain, :string
        t.column :cname, :string
        # Needs Paperclip setup
        # t.column :logo, :string
        t.column :created_at, :datetime
        t.column :updated_at, :datetime
      end

      s.table :admin_users do |t|
        t.column :id, :integer
        t.column :email, :string
        t.column :encrypted_password, :string
        t.column :reset_password_token, :string
        t.column :reset_password_sent_at, :datetime
        t.column :remember_created_at, :datetime
        t.column :sign_in_count, :integer
        t.column :current_sign_in_at, :datetime
        t.column :last_sign_in_at, :datetime
        t.column :current_sign_in_ip, :string
        t.column :last_sign_in_ip, :string
        t.column :created_at, :datetime
        t.column :updated_at, :datetime
        t.index :email, name: 'index_admin_users_on_email', unique: true
        t.index :reset_password_token, name: 'index_admin_users_on_reset_password_token', unique: true
      end

      s.table :active_admin_comments do |t|
        t.column :id, :integer
        t.column :namespace, :string
        t.column :body, :text
        t.column :resource_id, :string
        t.column :resource_type, :string
        t.column :author_id, :integer
        t.column :author_type, :string
        t.column :created_at, :datetime
        t.column :updated_at, :datetime
        t.index [:author_type, :author_id], name: 'index_active_admin_comments_on_author_type_and_author_id'
        t.index :namespace, name: 'index_active_admin_comments_on_namespace'
        t.index [:resource_type, :resource_id], name: 'index_active_admin_comments_on_resource_type_and_resource_id'
      end
    end
  end
end
