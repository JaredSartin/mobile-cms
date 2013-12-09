require 'spec_helper'

describe Api::V1::UserSerializer do
  describe "#as_json" do
    let(:user) { Fabricate(:user) }
    subject { described_class.new user }

    it "serializes a User" do
      subject.as_json.should == {user: {
                                  id: user.id,
                                  email: user.email,
                                  first_name: user.first_name,
                                  last_name: user.last_name,
                                }}
    end
  end
end
