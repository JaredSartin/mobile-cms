require 'spec_helper'

feature 'Page Management' do
  scenario 'a manager can see all the pages in the app' do
    hope = Fabricate(:app, user: amy, name: "Hope")
    page1 = Fabricate(:page, app: hope)
    page2 = Fabricate(:page, app: hope)
    pagex = Fabricate(:page)

    sign_in_as amy
    visit_admin_app(hope)

    page.should have_content page1.title
    page.should have_content page2.title
    page.should_not have_content pagex.title
  end

  scenario 'pages can be created'
  scenario 'pages can be edited'
  scenario 'pages can be deleted'
  scenario 'pages can be rearanged'
  scenario 'pages can be nested'
  scenario 'a page can be set as the default'
  scenario 'images can be uploaded to pages'
end
