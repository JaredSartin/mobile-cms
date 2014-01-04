require 'spec_helper'

describe App do
  it { should belong_to(:user) }
  it { should have_many(:pages) }
  it { should belong_to(:homepage).class_name('Page') }

  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:shortname) }

  it { should validate_uniqueness_of(:shortname) }
end
