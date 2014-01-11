class App < ActiveRecord::Base
  belongs_to :user
  has_many :pages
  belongs_to :homepage, class_name: 'Page'

  has_attached_file :icon, {
    default_url: "/images/:attachment/placeholder/:style/icon.png",
    path: ":rails_root/public/images/:attachment/:id/:style/:basename.:extension",
    url: "/images/:attachment/:id/:style/:basename.:extension",
    styles: {
      apple_smallest: ["60x60#", :png], 
      apple_small: ["76x76#", :png], 
      apple_medium: ["120x120#", :png], 
      apple_large: ["152x152#", :png], 
      android: ["196x196#", :png], 
    },
    convert_options: {
      apple_smallest: "-alpha remove -background white",
      apple_small: "-alpha remove -background white",
      apple_medium: "-alpha remove -background white",
      apple_large: "-alpha remove -background white",
    },
  }
  validates_attachment :icon, {size: {in: 0..3.megabytes}}

  validates :name, :shortname, :user, presence: true
  validates :shortname, uniqueness: true
end
