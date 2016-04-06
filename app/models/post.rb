class Post < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  attr_accessible :body, :title, :user_id, :image,:video,:tag_list, :you_tube_video
  validates :title,  presence: true, length: { maximum: 20 }
  validates :body,  presence: true, length: { maximum: 5000 }
  validates :user_id,  presence: true
  belongs_to :user
  has_many :comments
  has_attached_file :image,styles:{large: "600x600",medium: "300x300>",thumb:"50x50#"},:path => ':attachment/:id/:style.:extension',
    :storage        => :s3,
    :s3_host_alias  => 'dev.1stmile.in',
    :s3_credentials => File.join(Rails.root, 'config', 'aws.yml')
  has_attached_file :video,:path => ':attachment/:id/:style.:extension',
    :storage        => :s3,
    :s3_host_alias  => 'dev.1stmile.in',
    :s3_credentials => File.join(Rails.root, 'config', 'aws.yml')
 #validates_attachement_content_type :image,content_type:/\Aimage\/.*\z/
 validates_attachment_content_type :image,:content_type => ['image/jpeg', 'image/jpg', 'image/png', 'image/gif','image/vob']
 validates_attachment_content_type :video,:content_type => ['video/mp4']
acts_as_taggable
end