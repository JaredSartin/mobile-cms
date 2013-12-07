module ControllerHelpers
  def login_user(user)
    sign_in user 
    controller.stub(:current_user) { user }
  end
end

RSpec.configure { |c| 
  c.include(ControllerHelpers, type: :controller) 
}
