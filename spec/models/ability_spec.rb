require 'spec_helper'
require 'cancan/matchers'

describe Ability do
  context "as an admin" do
    let(:user) {Fabricate(:user)}
    let(:other_user) {Fabricate(:user)}

    let(:app) {Fabricate(:app, user_id: user.id)}
    let(:other_app) {Fabricate(:app, user_id: other_user.id)}

    subject(:ability) { Ability.new(user) }

    # Users
    it { should be_able_to(:manage, user) }
    it { should be_able_to(:manage, other_user) }

    #Apps
    it { should be_able_to(:manage, app) }
    it { should_not be_able_to(:manage, other_app) }
  end
end
