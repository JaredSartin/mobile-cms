Fabricator(:app) do
  user
  name { Faker::Company.name }
  cname { Faker::Internet.domain_name }
  shortname { Faker::Internet.domain_word }
end
