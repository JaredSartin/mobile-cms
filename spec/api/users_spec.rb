require 'spec_helper'

describe "User API", type: :api do
  context "v1" do
    describe "getting users" do
      # GET /api/users/1 
      it "gives the user" do
        sign_in_as amy

        get api_user_path(amy)

        last_response.status.should == 200

        user = get_json_object("user")
        user["id"].should == amy.id
        user["email"].should == amy.email
        user["first_name"].should == amy.first_name
        user["last_name"].should == amy.last_name
      end

      # it "returns an error when the user is not found" do
      #   sign_in_as amy
      #   get api_user_path(id: 999999999)

      #   last_response.status.should == 404
      # end

      it "returns an error when there is no logged in user" do
        get api_user_path(amy)
        last_response.status.should == 401
      end
    end

    describe "getting users apps" do
      it "gives the apps" do
        app1 = Fabricate(:app, user: amy)
        app2 = Fabricate(:app, user: amy)
        sign_in_as amy

        get apps_api_user_path(amy)

        last_response.status.should == 200

        apps = get_json_object("apps")
        apps.should have(2).items

        got1 = apps[0]
        got2 = apps[1]

        got1["id"].should == app1.id
        got1["user_id"].should == amy.id
        got1["name"].should == app1.name
        got1["cname"].should == app1.cname
        got1["shortname"].should == app1.shortname

        got2["id"].should == app2.id
        got2["user_id"].should == amy.id
        got2["name"].should == app2.name
        got2["cname"].should == app2.cname
        got2["shortname"].should == app2.shortname
      end

      it "returns an error when there is not logged in user" do
        get apps_api_user_path(amy)
        last_response.status.should == 401
      end
    end
  end
end
