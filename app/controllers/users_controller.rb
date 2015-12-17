class UsersController < ApplicationController
  def index
    @facebook_users = User.where(provider: 'facebook')
    @twitter_users = User.where(provider: 'twitter')
    @google_users = User.where(provider: 'google_oauth2')
    @instagram_users = User.where(provider: 'instagram')
    @other_users = User.where(provider: nil)

    respond_to do |format|
      format.js
      format.html
      format.csv { send_data User.as_csv(params[:provider]) }
    end
  end

  def show
    @user = User.find(params[:id])
  end
end
