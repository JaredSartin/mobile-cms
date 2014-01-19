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

  scenario 'pages can be created' do
    hope = Fabricate(:app, user: amy, name: "Hope")

    sign_in_as amy
    visit_admin_app(hope)

    sleep 1
    page.find('.app-add-page').click

    fill_in "Title", with: "Da first"
    # fill_in "Content", with: "I am da first!!"

    page.first('.app-save').click

    page.should have_content "Da first"
    page.should have_selector ".app-add-page"
  end

  scenario 'pages can be edited' do
    hope = Fabricate(:app, user: amy, name: "Hope")
    Fabricate(:page, app_id: hope.id, title: "Not Dis Won")

    sign_in_as amy
    visit_admin_app(hope)

    sleep 1
    page.should have_content "Not Dis Won"
    page.find('.app-edit-page').click

    fill_in "Title", with: "Dis is da won!"
    page.first('.app-save').click

    page.should_not have_content "Not Dis Won"
    page.should have_content "Dis is da won!"
  end

  scenario 'pages can be deleted' do
    hope = Fabricate(:app, user: amy, name: "Hope")
    Fabricate(:page, app_id: hope.id, title: "Not Dis Won")

    sign_in_as amy
    visit_admin_app(hope)

    within '.app-unassigned-pages' do
      page.should have_content "Not Dis Won"
    end

    sleep 1
    page.find('.app-edit-page').click

    accept_confirmations true
    page.find('.app-delete-page').click

    within '.app-unassigned-pages' do
      page.should_not have_content "Not Dis Won"
    end
  end

  scenario 'pages can be scheduled' do
    time = Time.local(2009, 1, 1)
    Timecop.travel(time)

    hope = Fabricate(:app, user: amy, name: "Hope")

    home = Fabricate(:page, app: hope, title: "Home")
    nStop = Fabricate(:page, app: hope, title: "No Stop", start_date: "2009-02-15")
    nStart = Fabricate(:page, app: hope, title: "No Start", end_date: "2009-09-15")
    windowed = Fabricate(:page, app: hope, title: "Window")

    nStop.parent = home
    nStop.save
    nStart.parent = home
    nStart.save
    windowed.parent = home
    windowed.save

    home.reload

    hope.homepage = home
    hope.save!

    hope.reload

    sign_in_as amy
    visit_admin_app(hope)

    page.should have_selector('.date-display', text: "Always Displayed")
    page.should have_selector('.date-display', text: "From: 02/15/2009 (inactive)")
    page.should have_selector('.date-display', text: "Until: 09/15/2009 (active)")

    page.find(".app-page-#{windowed.id} .app-edit-page").click

    page.execute_script("$('.app-page-start').val('02/15/2009').change()")
    page.execute_script("$('.app-page-end').val('09/15/2009').change()")
    page.first('.app-save').click

    sleep 1

    page.should have_selector('.date-display', text: "From: 02/15/2009 (inactive)")
    page.should have_selector('.date-display', text: "Until: 09/15/2009 (active)")
    page.should have_selector('.date-display', text: "From: 02/15/2009 Until: 09/15/2009 (inactive)")

    # timecop into window and see statuses
    time = Time.local(2009, 8, 9)
    Timecop.travel(time)
    visit_admin_app(hope)

    page.should have_selector('.date-display', text: "From: 02/15/2009 (active)")
    page.should have_selector('.date-display', text: "Until: 09/15/2009 (active)")
    page.should have_selector('.date-display', text: "From: 02/15/2009 Until: 09/15/2009 (active)")
    
    # timecop out of window and see statuses
    time = Time.local(2010, 1, 1)
    Timecop.travel(time)
    visit_admin_app(hope)

    page.should have_selector('.date-display', text: "From: 02/15/2009 (active)")
    page.should have_selector('.date-display', text: "Until: 09/15/2009 (inactive)")
    page.should have_selector('.date-display', text: "From: 02/15/2009 Until: 09/15/2009 (inactive)")
  end

  context 'managing page structure' do
    let(:hope) {Fabricate(:app, user: amy, name: "Hope")}
    let!(:page1) {Fabricate(:page, app_id: hope.id, title: "Furst")}
    let!(:page2) {Fabricate(:page, app_id: hope.id, title: "Sekond")}
    let!(:page3) {Fabricate(:page, app_id: hope.id, title: "Thurd")}

    before do
      sign_in_as amy
      visit_admin_app(hope)
    end

    scenario 'a page can be set as the default' do
      pending "styles - dragging is terrible"
      page1_target = page.find(".app-page-#{page1.id}")
      page2_target = page.find(".app-page-#{page2.id}")
      home_page_target = page.find(".app-homepage")

      page2_target.drag_to(home_page_target)
      page.should have_selector(".app-homepage .app-page-#{page2.id}")
      sleep 1 #TODO - Put in flash message on save

      #check and replace
      visit_admin_app(hope)
      page1_target = page.find(".app-page-#{page1.id}")
      home_page_target = page.find(".app-homepage")

      page.should have_selector(".app-homepage .app-page-#{page2.id}")
      page.should have_selector(".app-unassigned-pages .app-page-#{page1.id}")
      page.should_not have_selector(".app-unassigned-pages .app-page-#{page2.id}")

      page1_target.drag_to(home_page_target)
      sleep 1 #TODO - Put in flash message on save

      #final check
      visit_admin_app(hope)
      patiently do
        page.should have_selector(".app-homepage .app-page-#{page1.id}")
        page.should have_selector(".app-unassigned-pages .app-page-#{page2.id}")
        page.should_not have_selector(".app-homepage .app-page-#{page2.id}")
        page.should_not have_selector(".app-unassigned-pages .app-page-#{page1.id}")
      end
    end

    scenario 'pages can be nested and un-nested' do
      pending "styles - dragging is terrible"
      hope.homepage = page3
      hope.save

      visit_admin_app(hope)
      page1_target = page.find(".app-page-#{page1.id}")
      page3_child_target = page.find(".app-page-#{page3.id} .app-child-pages")

      page1_target.drag_to(page3_child_target)
      page.should have_selector(".app-page-#{page3.id} .app-child-pages .app-page-#{page1.id}")
      sleep 1

      visit_admin_app(hope)
      page.should have_selector(".app-page-#{page3.id} .app-child-pages .app-page-#{page1.id}")

      page3_target = page.find(".app-page-#{page3.id}")
      unassigned_target = page.find(".app-unassigned-pages")

      page3_target.drag_to(unassigned_target)
      page.should have_selector(".app-unassigned-pages .app-page-#{page1.id}")

      visit_admin_app(hope)
      page.should have_selector(".app-unassigned-pages .app-page-#{page1.id}")
    end

    scenario 'pages can be rearranged' do
      pending "Write this when dragging is better"
    end
  end

  scenario 'page dates can be removed'
  scenario 'page creation can show errors'
  scenario 'images can be uploaded to pages'
end
