class Post < ActiveRecord::Base
  make_flaggable :like
	has_many :comments, dependent: :destroy, :as => :commentable
  attr_accessor :photo, :search
	attr_accessible :title, :body ,:photo
	belongs_to :user
	validates :title, :presence => true, :uniqueness => true
	validates :body, :presence => true, :uniqueness => true
  has_attached_file :photo, :styles => {
  	:small  => "150x150>"},
    :url => "/assets/images/:id/:style/:basename.:extension",
    :path => ":rails_root/public/assets/images/:id/:style/:basename.:extension"
    validates_attachment_content_type :photo, :content_type => ['image/jpeg','image/png','image/jpg','image/bmp']
  
  def self.search(search)
    if search
     where("title LIKE ? OR body LIKE ?","%#{search.strip}%","%#{search.strip}%")
    else
      scoped
    end
  end
end