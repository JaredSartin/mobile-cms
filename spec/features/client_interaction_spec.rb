require 'spec_helper'

feature 'Client viewing the app' do
  scenario 'can navigate through the correct app' do
    pages = build_hope_app
    visit client_app(pages[:app])

    page.should have_content pages[:homepage].body

    click_page_link(pages[:page1])
    page.should have_content(pages[:page1].body)

    click_page_link(pages[:page11])
    page.should have_content(pages[:page11].body)

    click_page_link(pages[:page111])
    page.should have_content(pages[:page111].body)

    click_back_link
    click_back_link

    click_page_link(pages[:page12])
    page.should have_content(pages[:page12].body)

    click_back_link
    click_back_link

    click_page_link(pages[:page2])
    page.should have_content(pages[:page2].body)
  end

  scenario 'can access the app via 3rd party url and shortname' do
    Capybara.default_host = "foobar.com"
    pages = build_hope_app
    pages[:app].cname = "foobar.com"
    pages[:app].save

    visit client_app(pages[:app])
    page.should have_content pages[:homepage].body
  end

  # DO NOT KNOW HOW TO TEST
  # Cant' figure out a way to set the headers properly
  # to pretend the app is being accessed from a forwarded header
  # scenario 'canot access the app via 3rd party url and shortname if they do not match' do
  #   pages = build_hope_app
  #   pages[:app].cname = "bazzork.com"
  #   pages[:app].save

  #   visit client_app(pages[:app])
  #   sleep 2
  #   page.should_not have_content pages[:homepage].body
  # end

  scenario 'can still access the app when a 3rd party url and shortname is set' do
    pages = build_hope_app
    pages[:app].cname = "foobar.com"
    pages[:app].save

    visit client_app(pages[:app])
    page.should have_content pages[:homepage].body
  end

  scenario 'sees a not found page on improper app lookup' do
    visit '/not_an_app'

    page.should have_content "Oops! There seems to be a problem"
  end

  scenario 'sees scheduled pages properly'

  scenario 'sees a coming soon page when no homepage is set'
  scenario 'sees an app listing on the main url when access by custom url and no apps at root'
end
