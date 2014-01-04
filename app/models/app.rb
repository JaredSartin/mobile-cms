class App < ActiveRecord::Base
  belongs_to :user
  has_many :pages
  belongs_to :homepage, class_name: 'Page'

  validates :name, :shortname, :user, presence: true
  validates :shortname, uniqueness: true
end
