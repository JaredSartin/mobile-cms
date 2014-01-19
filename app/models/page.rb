class Page < ActiveRecord::Base
  belongs_to :app

  has_many :children, class_name: "Page", foreign_key: "page_id"
  belongs_to :parent, class_name: "Page", foreign_key: "page_id"

  # validates :title, :content, :app, presence: true

  def active
    today = Date.today
    before = (start_date <=> today) == 1
    after = (today <=> end_date) == 1

    outside_range = (before or after)
    no_dates = (start_date.nil? and end_date.nil?)

    (!outside_range or no_dates)
  end

  def visible_children
    children.reduce([]) { |visible, child|
      visible.push(child) if child.active
      visible
    }
  end
end
