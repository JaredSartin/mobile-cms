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

      it "returns an error when the user is not found" do
        sign_in_as amy
        get api_user_path(id: 999999999)

        last_response.status.should == 404
      end

      it "returns an error when there is no logged in user" do
        get api_user_path(amy)

        last_response.status.should == 401
      end
    end
  end
end
