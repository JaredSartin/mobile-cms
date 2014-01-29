require 'spec_helper'

feature 'App Management' do
  scenario 'an app can be edited' do
    hope = Fabricate(:app, user: amy, name: "Hope")
    sign_in_as amy

    visit_admin_app(hope)

    page.find('.app-edit-app').click

    fill_in "Name", with: "Blunderbuss"

    page.find('.app-save').click

    page.should have_content "Add New Page"
    page.should have_content "Blunderbuss"
  end

  scenario 'an app can get a custom logo uploaded' do
    hope = Fabricate(:app, user: amy, name: "Hope")
    sign_in_as amy

    visit_admin_app(hope)

    page.find('.app-edit-app').click

    page.find(".app-app-icon")['src'].should =~ /placeholder/

    path = File.join(::Rails.root, "spec/fixtures/logo.png") 
    attach_file('app-icon', path)

    patiently do
      page.find(".app-app-icon")['src'].should =~ /logo/
    end

    page.find('.app-save').click

    visit client_app(hope)

    patiently do
      page.find("#app-apple-icon-smallest", visible: false)['href'].should =~ /logo/
      page.find("#app-apple-icon-small", visible: false)['href'].should =~ /logo/
      page.find("#app-apple-icon-medium", visible: false)['href'].should =~ /logo/
      page.find("#app-apple-icon-large", visible: false)['href'].should =~ /logo/
      page.find("#app-android-icon", visible: false)['href'].should =~ /logo/
    end
  end

  scenario 'an app can get custom bootstrap files uploaded'
  scenario 'an app can get different themes' do
    hope = Fabricate(:app, user: amy, name: "Hope")
    sign_in_as amy

    visit client_app(hope)
    page.find("#theme", visible: false)['href'].should =~ /default/

    #set style
    visit_admin_app(hope)
    page.find('.app-edit-app').click

    select "Amelia", from: "Theme"
    page.find('.app-save').click
    sleep 1

    visit client_app(hope)
    page.find("#theme", visible: false)['href'].should =~ /amelia/

    #upload new theme
    visit_admin_app(hope)
    page.find('.app-edit-app').click

    path = File.join(::Rails.root, "spec/fixtures/booty.css") 
    attach_file('app-theme-upload', path)

    patiently do
      page.should have_content "Theme has been updated!"
    end

    visit client_app(hope)
    page.find("#theme", visible: false)['href'].should =~ /booty/
  end

  scenario 'only pngs and gifs can be uploaded'
  scenario 'an app can be created'
  scenario 'an app can be deleted?'
  scenario 'users can be added as managers'
  scenario 'users can be removed as managers'
end
