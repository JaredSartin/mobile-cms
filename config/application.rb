require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module MobileCms
  class Application < Rails::Application
    config.autoload_paths += %W(#{Rails.root}/lib)
    # Rails-API configuration
    config.middleware.use ActionDispatch::Cookies
    config.middleware.use ActionDispatch::Session::CookieStore
    config.middleware.use ActionDispatch::Flash
    config.middleware.use Rack::MethodOverride

    config.assets.paths << Rails.root.join('config', 'locales')

    config.assets.precompile += %w( active_admin.js active_admin.css )
    config.generators do |g|
      g.test_framework      :rspec, fixture: true
      g.fixture_replacement :fabrication
    end
    config.action_dispatch.default_headers.clear
  end
end
