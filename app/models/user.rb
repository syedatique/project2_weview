class User < ActiveRecord::Base

  belongs_to  :role
  has_many :show_reviews
  has_many :venue_reviews

  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable,
  :omniauthable, omniauth_providers: [:facebook]

  before_create :set_default_role


  def self.from_omniauth(auth)
    if user = User.find_by_email(auth.info.email)
    # if a user in the database already has the email returned by the auth provider, set their provider and uid attributes, and return that user
      user.provider = auth.provider
      user.uid = auth.uid
      user
    else
    # otherwise, have a look to see if a different email address is registered with that provider and uid - return them if they do, otherwise create a new user from the credentials given (with a random password)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      end
    end
  end
   

 def role?(role_to_compare_to)
   role_to_compare_to.to_s == self.role.try(:name).to_s
 end

 private
 
 def set_default_role
   self.role ||= Role.find_by_name('registered')
 end






end
