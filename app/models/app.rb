class App < ActiveRecord::Base
  belongs_to :user
  has_many :pages

  validates :name, :subdomain, :user, presence: true
  validates :subdomain, uniqueness: true
end
