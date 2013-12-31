require 'spec_helper'

describe Api::V1::PageSerializer do
  describe "#as_json" do
    let(:page) { Fabricate(:page) }
    subject { described_class.new page }

    it "serializes a Page" do
      subject.as_json.should == {page: {
                                  id: page.id,
                                  app_id: page.app_id,
                                  title: page.title,
                                  body: page.body,
                                  order: page.order,
                                  page_id: page.page_id,
                                  links: {
                                    children: "/api/pages/#{page.id}/children", 
                                  },
                                }}
    end
  end
end
