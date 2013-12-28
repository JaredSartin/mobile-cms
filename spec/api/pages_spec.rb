require 'spec_helper'

describe "Page API", type: :api do
  let(:app_model) {Fabricate(:app, user_id: amy.id)}
  let(:page_model) {Fabricate(:page, app_id: app_model.id)}

  context "v1" do
    it "shows pages" do
      sign_in_as amy
      
      get api_page_path(page_model)

      last_response.status.should == 200

      page_json = get_json_object("page")
      page_json["id"].should == page_model.id
      page_json["title"].should == page_model.title
      page_json["body"].should == page_model.body
      page_json["app_id"].should == page_model.app_id
      page_json["order"].should == page_model.order
    end

    context "creating pages" do
      it "returns the new page" do
        sign_in_as amy

        post api_pages_path, {page: {title: "Furst", body: "stuff", foo: "bar", app_id: app_model.id, order: 10}}

        last_response.status.should == 200

        page_json = get_json_object("page")
        page_json["id"].should be
        page_json["title"].should == "Furst"
        page_json["body"].should == "stuff"
        page_json["app_id"].should == app_model.id
        page_json["order"].should == 10
      end

      it "returns the new page errors"
      it "returns errors if the user can't add pages"
    end

    context "editing pages" do
      it "returns the page" do
        sign_in_as amy

        put api_page_path(page_model), {page: {title: "Furst", body: "stuff", foo: "bar", app_id: app_model.id, order: 10}}

        last_response.status.should == 200

        page_json = get_json_object("page")
        page_json["id"].should be
        page_json["title"].should == "Furst"
        page_json["body"].should == "stuff"
        page_json["app_id"].should == app_model.id
        page_json["order"].should == 10
      end

      it "returns the page errors"
      it "returns errors if the user can't edit the page"
    end
  end
end
