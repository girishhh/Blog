class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         has_many :posts
  # attr_accessible :title, :body
  after_create :send_email
  def send_email
  	UserMailer.fm_response(self.email).deliver
	end
end
