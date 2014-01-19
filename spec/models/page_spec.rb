require 'spec_helper'

describe Page do
  it { should belong_to(:app) }
  it { should have_many(:children).class_name("Page") }
  it { should belong_to(:parent).class_name("Page") }

  context "active" do
    it "is inactive when start date is in the future" do
      page = Fabricate(:page, start_date: Date.today + 3.weeks)
      page.active.should == false
    end

    it "is inactive when end date is in the past" do
      page = Fabricate(:page, end_date: Date.today - 3.weeks)
      page.active.should == false
    end

    it "is inactive when today is after start and end dates" do
      page = Fabricate(:page, start_date: Date.today - 4.weeks, end_date: Date.today - 3.weeks)
      page.active.should == false
    end

    it "is inactive when today is before start and end dates" do
      page = Fabricate(:page, start_date: Date.today + 3.weeks, end_date: Date.today + 4.weeks)
      page.active.should == false
    end

    it "is active when no dates are given" do
      page = Fabricate(:page) 
      page.active.should == true
    end

    it "is active when today is between start and end dates" do
      page = Fabricate(:page, start_date: Date.today - 4.weeks, end_date: Date.today + 3.weeks)
      page.active.should == true
    end
  end
end
