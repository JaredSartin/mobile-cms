Fabricator(:page) do
  app
  title { Faker::Company.bs }
  content { "<p>#{Faker::Lorem.paragraphs((1..5).to_a.sample(1)).join("</p><p>")}</p>" }
end
