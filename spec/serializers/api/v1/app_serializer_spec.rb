require 'spec_helper'

describe Api::V1::AppSerializer do
  describe "#as_json" do
    let(:app) { Fabricate(:app) }
    subject { described_class.new app }

    it "serializes an App" do
      subject.as_json.should == {app: {
                                  id: app.id,
                                  user_id: app.user_id,
                                  name: app.name,
                                  cname: app.cname,
                                  subdomain: app.subdomain,
                                }}
    end
  end
end
