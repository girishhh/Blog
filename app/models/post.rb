class Post < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  attr_accessible :body, :title, :user_id, :image,:video
  validates :title,  presence: true, length: { maximum: 20 }
  validates :body,  presence: true, length: { maximum: 5000 }
  validates :user_id,  presence: true
  belongs_to :user
  has_attached_file :image,styles:{large: "600x600",medium: "300x300>",thumb:"50x50#"}
 #validates_attachement_content_type :image,content_type:/\Aimage\/.*\z/
 validates_attachment_content_type :image,:content_type => ['image/jpeg', 'image/jpg', 'image/png', 'image/gif','image/vob']
end
