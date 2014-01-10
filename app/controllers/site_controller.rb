class SiteController < ApplicationController
  def index
    @app = App.find_by(shortname: params[:shortname])
  end
end
