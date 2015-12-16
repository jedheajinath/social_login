class RegistrationsController < Devise::RegistrationsController

  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  private
    def sign_up_params
      params.require(:user).permit(:name ,:email, :password, :password_confirmation)
    end

    def account_update_params
      params.require(:user).permit(:name, :email, :image, :password,
        :password_confirmation)
    end
    def update_without_password(params, *options)

    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation) if params[:password_confirmation].blank?
    end

    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end
end
