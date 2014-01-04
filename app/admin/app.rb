ActiveAdmin.register App do
  index do
    column :name
    column :user do
      "#{user.name} (#{user.email})"
    end
    column :shortname
    column :cname
    column :created_at
    default_actions
  end

  filter :name

  form do |f|
    f.inputs "Client Information" do
      f.input :name
      f.input :user do User.all end
      f.input :shortname
      f.input :cname
    end
    f.actions
  end

  controller do
    def permitted_params
      params.permit app: [:name, :shortname, :cname, :user_id]
    end
  end
end
