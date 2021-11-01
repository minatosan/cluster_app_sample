# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
   def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)
    yield resource if block_given?
    if resource.profile.nil?
      redirect_to new_profile_path
    else
      redirect_to root_path
    end
   end

   def guest_user
    user = User.guest
    sign_in user
    if user.profile.nil?
      @profile=Profile.new(
      nickname:"ゲストユーザー",
      text:"紹介文なし",
      user_id:current_user.id
      )
      @profile.save
      redirect_to root_path
    else
      redirect_to root_path, notice: "ゲストユーザーでログインしました"
    end
   end

  # DELETE /resource/sign_out
   #def destroy
     #super
   #end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
