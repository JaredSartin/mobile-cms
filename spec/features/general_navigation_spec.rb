require 'spec_helper'

feature 'General Navigation' do
  scenario 'as an account holder I should see a login page when I go to /admin' do
    visit '/admin'
    page.should have_content "Admin Panel"
    page.should have_content "Please log in"
  end

  scenario 'as a logged in account holder I should be able to see the main dashboard'
  scenario 'as a logged in account holder I should be able to see the specific app dashboard'
  scenario 'I should not be able to get to any administration functions if I am not logged in'
end
