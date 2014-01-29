require 'spec_helper'

describe "App API", type: :api do
  context "v1" do
    let!(:app_model) { Fabricate(:app, user_id: amy.id, shortname: 'hope') }
    it "gives the app" do
      sign_in_as amy

      get api_app_path(app_model)

      last_response.status.should == 200

      app_json = get_json_object("app")
      app_json["id"].should == app_model.id
      app_json["name"].should == app_model.name
      app_json["cname"].should == app_model.cname
      app_json["shortname"].should == app_model.shortname
      # app["homepage_id"].should == app_model.homepage_id
    end

    it "looks up the app based on the shortname" do
      get api_apps_path, shortname: 'hope'

      last_response.status.should == 200

      apps = get_json_object("apps")
      apps.length.should == 1
      app_json = apps[0]

      app_json = apps.first
      app_json["id"].should == app_model.id
      app_json["name"].should == app_model.name
      app_json["cname"].should == app_model.cname
      app_json["shortname"].should == app_model.shortname
    end

    it "looks up the app based on the shortname and domain" do
      hosted_app = Fabricate(:app, cname: 'foobar.com', shortname: 'davenport')

      get api_apps_path, {shortname: 'davenport'}, {'HTTP_HOST' => 'foobar.com'}

      last_response.status.should == 200

      apps = get_json_object("apps")
      apps.length.should == 1
      app_json = apps[0]

      app_json = apps.first
      app_json["id"].should == hosted_app.id
      app_json["name"].should == hosted_app.name
      app_json["cname"].should == hosted_app.cname
      app_json["shortname"].should == hosted_app.shortname
    end

    it "returns errors when no app found by shortname" do
      get api_apps_path, shortname: 'calvin'

      last_response.status.should == 200

      apps = get_json_object("apps")
      apps.length.should == 0
    end

    it "returns errors when no app found by shortname and domain" do
      hosted_app = Fabricate(:app, cname: 'foobar.com', shortname: 'davenport')

      get api_apps_path, {shortname: 'davenport'}, {'HTTP_HOST' => 'bazzork.com'}

      apps = get_json_object("apps")
      apps.length.should == 0
    end

    it "gives the apps' pages" do
      page1 = Fabricate(:page, app_id: app_model.id)
      page2 = Fabricate(:page, app_id: app_model.id)
      sign_in_as amy

      get pages_api_app_path(app_model)

      last_response.status.should == 200

      pages = get_json_object("pages")
      pages.should have(2).items

      got1 = pages[0]
      got2 = pages[1]

      got1["id"].should == page1.id
      got1["app_id"].should == page1.app_id
      got1["title"].should == page1.title
      got1["body"].should == page1.body
      got1["order"].should == page1.order

      got2["id"].should == page2.id
      got2["app_id"].should == page2.app_id
      got2["title"].should == page2.title
      got2["body"].should == page2.body
      got2["order"].should == page2.order
    end

    describe "updating the app" do
      it "returns the updated app" do
        sign_in_as amy

        put api_app_path(app_model), {app: {name: 'Foober', cname: 'bar.baz', shortname: 'zork', homepage_id: 99}}

        last_response.status.should == 200

        app = get_json_object("app")
        app["id"].should == app_model.id
        app["name"].should == "Foober"
        app["cname"].should == "bar.baz"
        app["shortname"].should == "zork"
        app["homepage_id"].should == 99
      end

      it "returns errors on the app"
      it "returns errors if you cannot update the app"
    end

    describe "creating the app" do
      it "returns the new app"
      it "returns errors on the app"
      it "returns errors if you cannot create an app"
    end

    describe "uploading the app icon" do
      it 'updates the icon' do
        sign_in_as amy

        file_path = Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/logo.png'), 'image/png')
        post icon_api_app_path(app_model), icon: file_path

        last_response.status.should == 200

        app_json = get_json_object("app")
        app_json["id"].should == app_model.id
        app_json["name"].should == app_model.name
        app_json["cname"].should == app_model.cname
        app_json["shortname"].should == app_model.shortname
        icons = [:apple_smallest_icon, :apple_small_icon, :apple_medium_icon, :apple_large_icon, :android_icon]
        icons.each do |type|
          app_json[type.to_s].should =~ /logo.png/
        end
      end

      it 'gives errors on update'
      it 'gives errors when not allowed to change icon'
      it 'gives not found when wrong app id'
    end
    describe "uploading the app theme" do
      it 'updates the theme' do
        sign_in_as amy

        app_model.theme_choice.should == "Default"

        file_path = Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/booty.css'), 'text/css')
        post theme_api_app_path(app_model), theme: file_path

        last_response.status.should == 200

        app_json = get_json_object("app")
        app_json["theme_choice"].should == "Custom"

        app_model.reload.theme_choice.should == "Custom"
      end
      it 'gives errors on update'
      it 'gives errors when not allowed to change icon'
      it 'gives not found when wrong app id'
    end
  end
end
