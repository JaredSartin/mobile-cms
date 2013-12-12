require 'spec_helper'

describe App do
  it { should belong_to(:user) }
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:subdomain) }

  it { should validate_uniqueness_of(:subdomain) }
end
