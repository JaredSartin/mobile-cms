class Page < ActiveRecord::Base
  belongs_to :app
  # has_many :children, through: :page
  # belongs_to :parent, through: :page
  # 
  # validates :title, :content, :app, presence: true
end
