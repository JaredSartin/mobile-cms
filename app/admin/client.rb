ActiveAdmin.register Client do
  index do
    column :name
    column :user do
      "#{user.name} (#{user.email})"
    end
    column :subdomain
    column :cname
    column :created_at
    default_actions
  end

  filter :name

  form do |f|
    f.inputs "Client Information" do
      f.input :name
      f.input :user do User.all end
      f.input :subdomain
      f.input :cname
    end
    f.actions
  end

  controller do
    def permitted_params
      params.permit client: [:name, :subdomain, :cname, :user_id]
    end
  end
end
