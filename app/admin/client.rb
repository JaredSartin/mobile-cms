ActiveAdmin.register Client do
  index do
    column :name
    column :subdomain
    column :cname
    column :created_at
    column :updated_at
    default_actions
  end

  filter :name

  form do |f|
    f.inputs "Client Information" do
      f.input :name
      f.input :subdomain
      f.input :cname
    end
    f.actions
  end

  controller do
    def permitted_params
      params.permit client: [:name, :subdomain, :cname]
    end
  end
end
