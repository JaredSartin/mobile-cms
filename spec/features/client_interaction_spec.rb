require 'spec_helper'

feature 'Client viwing the app' do
  scenario 'can navigate through the correct app'
  scenario 'can access the app via 3rd party url'
  scenario 'can access the app via 3rd party url and shortname'
  scenario 'sees the marketing page when the app cannot be found'
  scenario 'sees a coming soon page when no homepage is set'
end
