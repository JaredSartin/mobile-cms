require 'spec_helper'

describe "Page API", type: :api do
  let(:app_model) {Fabricate(:app, user_id: amy.id)}
  let(:page_model) {Fabricate(:page, app_id: app_model.id)}

  context "v1" do
    describe "indexing pages" do
      it "returns searched pages" do
        get api_pages_path, {id: page_model.id}

        page_json = get_json_object("page")
        page_json["id"].should == page_model.id
        page_json["title"].should == page_model.title
        page_json["body"].should == page_model.body
        page_json["app_id"].should == page_model.app_id
        page_json["order"].should == page_model.order
      end

      it "returns error when page not found"
      it "returns index of pages?"
    end

    context "showing pages" do
      it "returns error when the page is not found"
      it "shows pages" do
        get api_page_path(page_model)

        last_response.status.should == 200

        page_json = get_json_object("page")
        page_json["id"].should == page_model.id
        page_json["title"].should == page_model.title
        page_json["body"].should == page_model.body
        page_json["app_id"].should == page_model.app_id
        page_json["order"].should == page_model.order
      end
    end

    context "showing children pages" do
      it "returns error when the page is not found"
      it "returns the page's children" do
        page1 = Fabricate(:page, app_id: app_model.id)
        page2 = Fabricate(:page, app_id: app_model.id)

        page_model.children << page1
        page_model.children << page2

        page_model.save

        get children_api_page_path(page_model)

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
        got1["page_id"].should == page1.page_id
        got1["links"].should be

        got2["id"].should == page2.id
        got2["app_id"].should == page2.app_id
        got2["title"].should == page2.title
        got2["body"].should == page2.body
        got2["order"].should == page2.order
        got2["page_id"].should == page2.page_id
        got2["links"].should be
      end
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
