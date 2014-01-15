require 'spec_helper'

feature 'General Navigation' do
  scenario 'as an account holder I should see a login page when I go to /admin' do
    visit '/admin'
    page.should have_content "Publicizr"
    page.should have_content "Please log in"
  end

  scenario 'logging in takes the user to their dashboard'
  scenario 'only proper admin can access the app management'

  scenario 'as a logged in account holder I should be able to see a message telling me I have no apps' do
    sign_in_as amy
    visit '/admin'

    page.should have_content "Publicizr"
    page.should have_content "You have no applications, you should create one."
  end

  scenario 'as a logged in account holder I should be able to see the main dashboard' do
    Fabricate(:app, user: amy, name: "Hope")
    Fabricate(:app, user: amy, name: "Chadron State")

    sign_in_as amy
    visit '/admin'
    page.should have_selector 'a', text: 'Hope'
    page.should have_selector 'a', text: 'Chadron State'
  end

  scenario 'as a logged in account holder I should be able to see the specific app dashboard' do
    Fabricate(:app, user: amy, name: "Hope")

    sign_in_as amy
    visit '/admin'
    
    page.find('a', text: 'Hope').click

    page.should have_content "Printable QR"
  end
end
