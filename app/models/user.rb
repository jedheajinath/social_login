require 'csv'

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  mount_uploader :image, ImageUploader
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook, :twitter, :instagram, :google_oauth2]



  def self.find_for_twitter_oauth(auth, signed_in_resource = nil)
    user = User.where(provider: auth.provider, uid: auth.uid).first
    if user
      return user
    else
      registered_user = User.where(email: auth.uid + "@twitter.com").first
      if registered_user
        return registered_user
      else
        where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
          user.email = auth.uid+"@twitter.com"
          user.password = Devise.friendly_token[0,20]
          user.name = auth.extra.raw_info.name
          user.remote_image_url = auth.info.image.gsub('http://','https://')
          user.details = auth
        end
      end
    end
  end

  def self.find_for_facebook_oauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.extra.raw_info.name
      user.gender = auth.extra.raw_info.gender
      user.remote_image_url = auth.info.image.gsub('http://','https://')
      user.details = auth
    end
  end


  def self.find_for_google_oauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name
      user.gender = auth.extra.raw_info.gender
      user.remote_image_url = auth.info.image.gsub('http://','https://')
      user.details = auth
    end
  end

  def self.find_for_instagram_oauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email ||  auth.uid + "@instagram.com"
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name
      user.remote_image_url = auth.info.image.gsub('http://','https://')
      user.details = auth
    end
  end

  def self.as_csv(provider)
    provider = nil if provider == "other"
    CSV.generate do |csv|
      csv << ["Name", "Email", "UID" "Provider", "Gender", "Image"]
      where(provider: provider).each do |user|
        row = [
                user.name,
                user.email,
                user.uid,
                user.provider,
                user.gender,
                user.image.url
              ]
        csv << row
      end
    end
  end
end
