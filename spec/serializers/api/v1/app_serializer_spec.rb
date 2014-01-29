require 'spec_helper'

describe Api::V1::AppSerializer do
  describe "#as_json" do
    let(:app) { Fabricate(:app) }
    subject { described_class.new app }

    it "serializes an App" do
      subject.as_json.should == {app: {
                                  id: app.id,
                                  user_id: app.user_id,
                                  homepage_id: app.homepage_id,
                                  name: app.name,
                                  cname: app.cname,
                                  shortname: app.shortname,
                                  apple_smallest_icon: app.icon.url(:apple_smallest),
                                  apple_small_icon: app.icon.url(:apple_small),
                                  apple_medium_icon: app.icon.url(:apple_medium),
                                  apple_large_icon: app.icon.url(:apple_large),
                                  android_icon: app.icon.url(:android),
                                  ga_key: app.ga_key,
                                  theme_choice: app.theme_choice,
                                  links: {
                                    pages: "/api/apps/#{app.id}/pages"
                                  }
                                }}
    end
  end
end
