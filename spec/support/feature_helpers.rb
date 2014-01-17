module FeatureHelpers
  def visit_admin_app(app)
    visit "/admin/app/#{app.id}"
    sleep 1
  end

  def sign_in_as(user)
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: default_password
    click_button "Sign in"
  end

  def accept_confirmations(accept)
    page.evaluate_script "window.confirm = function(msg) { return #{!!accept}; }"
  end

  def default_password; "password99"; end

  def client_app(app)
    "/#{app.shortname}"
  end

  def click_back_link
    page.find(".app-back").click
  end

  def click_page_link(page_model)
    page.find(".app-view-page", text: page_model.title).click
  end

  def build_hope_app
    app = Fabricate(:app, name: 'Hope College', shortname: 'hope')

    homepage = Fabricate(:page, title: "Welcome!", body: "Welcome to Hope's dining app!", app: app)

    page1 = Fabricate(:page, title: "Dining", body: "We have 2 dining locations, more can be found by looking at their sections.", app: app)
    page2 = Fabricate(:page, title: "About", body: "This app is by Level 2 Studios", app: app)

    page11 = Fabricate(:page, title: "South", body: "The south hall is open 24/7", app: app)
    page12 = Fabricate(:page, title: "North", body: "The north hall is open week nights and weekends", app: app)

    page111 = Fabricate(:page, title: "South Specials", body: "We have pizza for sale on fridays now!", app: app)

    app.homepage = homepage
    app.save

    homepage.children << page1
    homepage.children << page2

    page1.children << page11
    page1.children << page12

    page11.children << page111

    {
      app: app,
      homepage: homepage,
      page1: page1,
      page2: page2,
      page11: page11,
      page12: page12,
      page111: page111,
    }
  end
end

RSpec.configure do |c| 
  c.include(FeatureHelpers, type: :feature) 
  c.include(Warden::Test::Helpers)
  c.before(:each, type: :feature) { 
    Warden.test_mode! #if not example.metadata[:bypass_login] == false
  }
  c.after(:each, type: :feature) { 
    Warden.test_reset! 
    #if not example.metadata[:bypass_login] == false 
  }
end
