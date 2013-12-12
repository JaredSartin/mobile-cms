class App < ActiveRecord::Base
  belongs_to :user

  validates :name, :subdomain, :user, presence: true
  validates :subdomain, uniqueness: true
end
