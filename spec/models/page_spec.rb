require 'spec_helper'

describe Page do
  it { should belong_to(:app) }
  it { should have_many(:children).class_name("Page") }
  it { should belong_to(:parent).class_name("Page") }
end
