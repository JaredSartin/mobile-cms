class ChangeAppsClientIdToAppId < ActiveRecord::Migration
  def change
    rename_column :pages, :client_id, :app_id
  end
end
