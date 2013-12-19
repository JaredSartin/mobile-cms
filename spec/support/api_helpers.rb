module ApiHelpers
  include Rack::Test::Methods

  def app
    Rails.application
  end

  def sign_in_as(user)
    login_as user, scope: :user, run_callbacks: false
  end

  def get_json_object(root)
    obj = JSON.parse(last_response.body)
    target = obj[root]
    if !target
      raise "Last response didn't include json with root '#{root}': #{obj.inspect}"
    end
    
    # We're assuming we NEVER want the ActiveRecord timestamps.
    # See if we're looking at one object, or many:
    suspects = Array === target ? target : [target]
    suspects.each do |obj|
      obj.keys.should_not include("created_at")
      obj.keys.should_not include("updated_at")
    end

    target
  end

  def stringify(hash)
    hash.inject({}) do |memo, (k,v)|
      v = stringify(v) if v.is_a? Hash
      memo[k.to_s] = v
      memo
    end
  end
end

RSpec.configure do |c| 
  api_example_group = { file_path: c.escaped_path(%w[spec api]) }
  c.include ApiHelpers, example_group: api_example_group
  c.include(Warden::Test::Helpers)
  c.before(:each, example_group: api_example_group) { 
    Warden.test_mode! #if not example.metadata[:bypass_login] == false
  }
  c.after(:each, example_group: api_example_group) { 
    Warden.test_reset! 
    #if not example.metadata[:bypass_login] == false 
  }
end
