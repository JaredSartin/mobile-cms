require 'spec_helper'

describe Api::V1::PageSerializer do
  describe "#as_json" do
    let(:page) { Fabricate(:page) }
    subject { described_class.new page }

    it "serializes a Page that has no date" do
      subject.as_json.should == {page: {
                                  id: page.id,
                                  app_id: page.app_id,
                                  title: page.title,
                                  body: page.body,
                                  order: page.order,
                                  page_id: page.page_id,
                                  start_date: page.start_date,
                                  end_date: page.end_date,
                                  active: true,
                                  links: {
                                    children: "/api/pages/#{page.id}/children", 
                                  },
                                }}
    end
    it "serializes a Page that is not yet active" do
      page = Fabricate(:page, start_date: Date.today + 3.weeks)
      subject = described_class.new page
      subject.as_json[:page][:active].should == false
    end

    it "serializes a Page that is past being active" do
      page = Fabricate(:page, end_date: Date.today - 3.weeks)
      subject = described_class.new page
      subject.as_json[:page][:active].should == false
    end

    it "serializes a Page that is past being active (with range)" do
      page = Fabricate(:page, start_date: Date.today - 4.weeks, end_date: Date.today - 3.weeks)
      subject = described_class.new page
      subject.as_json[:page][:active].should == false
    end
  end
end
