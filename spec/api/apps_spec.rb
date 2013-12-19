require 'spec_helper'

describe "App API", type: :api do
  context "v1" do
    let(:app_model) { Fabricate(:app, user_id: amy.id) }
    it "gives the app" do
      sign_in_as amy

      get api_app_path(app_model)

      last_response.status.should == 200

      app = get_json_object("app")
      app["id"].should == app_model.id
      app["name"].should == app_model.name
      app["cname"].should == app_model.cname
      app["subdomain"].should == app_model.subdomain
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
      got1["content"].should == page1.content
      got1["order"].should == page1.order

      got2["id"].should == page2.id
      got2["app_id"].should == page2.app_id
      got2["title"].should == page2.title
      got2["content"].should == page2.content
      got2["order"].should == page2.order
    end
  end
end
