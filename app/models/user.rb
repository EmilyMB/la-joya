class User < ActiveRecord::Base
  has_many :uploads
  validates :name, presence: true
  validates :email, presence: true
  validates :provider, presence: true

  def self.find_or_create_from_auth(auth)
    user = User.find_or_create_by(provider: auth.provider, uid: auth.uid)
    user.email = auth.info.email
    user.name = auth.info.name
    user.first_name = auth.info.first_name
    user.profile_image_url = auth.info.image
    user.token = auth.credentials.token
    user.save

    user
  end
end
