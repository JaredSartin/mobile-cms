module FeatureHelpers

  def sign_in_as(user)
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: default_password
    click_button "Sign In"
  end

  def default_password; "password99"; end
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