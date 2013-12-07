module Api
  class ApplicationController < ActionController::API
    include CanCan::ControllerAdditions

    before_filter only: [:create,:update] do
      resource = controller_name.singularize.to_sym
      method = "#{resource}_params"

      if respond_to?(method,true)
        safe_attrs = send(method) 
        resource_extra = "#{resource}_extra"
        params[resource_extra] = {}
        (params[resource].keys - safe_attrs.keys).each do |unsafe_key|
          params[resource_extra][unsafe_key] = params[resource][unsafe_key]
        end
        params[resource] &&= safe_attrs
      end
    end

    rescue_from CanCan::AccessDenied do |exception|
      if signed_in?
        head 403
      else
        head 401
      end
    end
  end
end
