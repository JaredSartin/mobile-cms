require 'spec_helper'

feature 'App Management' do
  scenario 'an app can be edited' do
    hope = Fabricate(:app, user: amy, name: "Hope")
    sign_in_as amy

    visit_admin_app(hope)

    sleep 1
    page.find('.app-edit-app').click
    save_screenshot('tmp/page.png')

    fill_in "Name", with: "Blunderbuss"

    page.find('.app-save').click

    page.should have_content "Add New Page"
    page.should have_content "Blunderbuss"
  end

  scenario 'an app can be created'
  scenario 'an app can get a custom logo uploaded'
  scenario 'an app can get custom colors and style set'
  scenario 'an app can be deleted?'
  scenario 'users can be added as managers'
  scenario 'users can be removed as managers'
end
