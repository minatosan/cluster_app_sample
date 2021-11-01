# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  # More info at:
  # https://github.com/plataformatec/devise#omniauth
  #def facebook
    # 以下のメソッドをモデル（app/models/user.rbなど）で実装する必要がある
    #@user = User.from_omniauth(request.env["omniauth.auth"])
    #if @user.persisted?
      #sign_in_and_redirect @user, :event => :authentication #@userが無効だと例外がスローされる
      #set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    #else
      #session["devise.facebook_data"] = request.env["omniauth.auth"]
      #redirect_to omniauth_url
    #end
  #end

  def facebook
    callback_from :facebook
  end

  def google_oauth2
    callback_from :google
  end

  def callback_from(provider)
    provider = provider.to_s #プロバイダを定義
    @user = User.from_omniauth(request.env['omniauth.auth']) #モデルでSNSにリクエストするメソッド（from_omniauth）を使用し、レスポンスを@userに代入
    if @user.persisted? #@userがすでに存在したらログイン処理、存在しなかったら残りの登録処理へ移行
      sign_in @user
      redirect_to root_path
    else
      session[:provider] = @user.provider
      session[:uid] = @user.uid
      @user.skip_confirmation!
      @user.save
      sign_in @user
      redirect_to new_profile_path
    end
  end

  def failure
    redirect_to root_path
  end
  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
end
