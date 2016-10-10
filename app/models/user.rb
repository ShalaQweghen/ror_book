class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, #:confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]

  mount_uploader :picture, ::PictureUploader

  has_many :posts, dependent: :destroy
  has_many :friendships, dependent: :destroy, foreign_key: :friend_id
  has_many :friendings, class_name: "Friendship", dependent: :destroy, foreign_key: :friender_id
  has_many :friends, through: :friendships
  has_many :frienders, through: :friendships
	has_many :comments, foreign_key: :commenter_id, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :pictures, dependent: :destroy

	validates :username, presence: true
	validates :email, presence: true

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.username = auth.info.name
      user.picture = auth.info.image_url
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
end
