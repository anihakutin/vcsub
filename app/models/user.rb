class User < ApplicationRecord
  # Add the association
  has_many :listings, dependent: :destroy
  has_many :requests

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, :trackable,
         omniauth_providers: [:google_oauth2]
         
  def self.from_google(auth)
    # Find existing user by uid and provider
    user = User.find_by(provider: auth[:provider], uid: auth[:uid])
    
    return user if user

    # Create new user if not found
    User.create(
      provider: auth[:provider],
      uid: auth[:uid],
      email: auth[:email],
      password: Devise.friendly_token[0, 20]
    )
  end

  def profile_completed?
    name.present? && 
    company_name.present? && 
    contact_preference.present?
  end
end 