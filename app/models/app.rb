class App < ActiveRecord::Base
  belongs_to :user
  has_many :pages
  belongs_to :homepage, class_name: 'Page'

  has_attached_file :icon, {
    default_url: "/assets/:attachment/placeholder/:style/icon.png",
    styles: {
      apple_smallest: ["60x60#", :png], 
      apple_small: ["76x76#", :png], 
      apple_medium: ["120x120#", :png], 
      apple_large: ["152x152#", :png], 
      android: ["196x196#", :png], 
    },
    convert_options: {
      apple_smallest: "-background white -flatten",
      apple_small: "-background white -flatten",
      apple_medium: "-background white -flatten",
      apple_large: "-background white -flatten",
    },
  }

  has_attached_file :theme

  validates_attachment :icon, {size: {in: 0..2.megabytes}}
  validates_attachment :theme, {size: {in: 0..1.megabytes}}

  validates :name, :shortname, :user, presence: true
  validates :shortname, uniqueness: true
end
