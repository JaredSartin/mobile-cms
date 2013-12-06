require 'spec_helper'

describe User do
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }

  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }

  it "knows its name" do
    user = Fabricate(:user)
    user.name.should == "#{user.first_name} #{user.last_name}"
  end

  it "knows its display name" do
    user = Fabricate(:user)
    user.display_name.should == "#{user.name} (#{user.email})"
  end
end
