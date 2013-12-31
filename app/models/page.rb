class Page < ActiveRecord::Base
  belongs_to :app

  has_many :children, class_name: "Page", foreign_key: "page_id"
  belongs_to :parent, class_name: "Page", foreign_key: "page_id"

  # validates :title, :content, :app, presence: true
end
