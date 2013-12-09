module UserHelpers
  def amy
    @amy ||= Fabricate(:user, first_name: 'Amy', last_name: 'Lunn')
  end
end

RSpec.configure do |c| 
  c.include(UserHelpers, type: :feature) 
  c.include(UserHelpers, example_group: { file_path: c.escaped_path(%w[spec api]) })
end

