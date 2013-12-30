class App < ActiveRecord::Base
  belongs_to :user
  has_many :pages
  belongs_to :homepage, class_name: 'Page'

  validates :name, :subdomain, :user, presence: true
  validates :subdomain, uniqueness: true
end
