class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]

  before_create :generate_authentication_token
  
  def generate_authentication_token
    self.authentication_token = Devise.friendly_token
  end

  def self.from_omniauth(auth)
    # Case 1: Find exisiting user by facebook
    user = User.find_fb_uid( auth.uid)
    if user
      user.fb_token = auth.credentials.token
      user.save!
      return user
    end

    #Case 2: Find exisiting user by email
    exisiting_user = User.find_by_email(auth.info.email)
    if exisiting_user
      exisiting_user.fb_uid = auth.uid
      exisiting_user.fb_token = auth.credentials.token
      exisiting_user.save!
      return exisiting_user
    end

    #case 3: Create new password
    user = User.new
    user.fb_uid = auth.uid
    user.fb_token = auth.credentials.token
    user.password = Devise.friendly_token[0,20]
    user.save!
    return user
  end  
end
