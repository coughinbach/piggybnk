class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]

  has_many :user_projects, dependent: :destroy
  has_many :projects, through: :user_projects
  validates :username, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  mount_uploader :photo, PhotoUploader

  def default_photo_url
    if self.photo.file.nil?
      self.facebook_picture_url || ActionController::Base.helpers.asset_path("default-user.png")
    else
      self.photo_url
    end
  end

  def self.find_for_facebook_oauth(auth)
    puts auth
    user_params = auth.slice(:provider, :uid)
    user_params.merge! auth.info.slice(:email, :first_name, :last_name)
    user_params[:facebook_picture_url] = auth.info.image
    user_params[:token] = auth.credentials.token
    user_params[:token_expiry] = Time.at(auth.credentials.expires_at)
    user_params = user_params.to_h

    user = User.find_by(provider: auth.provider, uid: auth.uid)
    user ||= User.find_by(email: auth.info.email) # User did a regular sign up in the past.
    if user
      user.update(user_params)
    else
      user = User.new(user_params)
      user.username = "#{user.first_name}#{user.last_name}"
      user.password = Devise.friendly_token[0,20]  # Fake password for validation
      user.save
    end

    return user
  end



end
