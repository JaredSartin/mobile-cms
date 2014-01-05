require 'spec_helper'

feature 'Client viewing the app' do
  scenario 'can navigate through the correct app' do
    pages = build_hope_app
    visit client_app(pages[:app])

    pending 'finish client'
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

  scenario 'can access the app via 3rd party url only'
  scenario 'can access the app via 3rd party url and shortname'
  scenario 'sees the marketing page when the app cannot be found'
  scenario 'sees a coming soon page when no homepage is set'
  scenario 'sees an app listing on the main url when access by custom url and no apps at root'
end
