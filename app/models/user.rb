class User < ApplicationRecord
  has_many :members
  has_many :groups, through: :members
  has_one :profile
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :rememberable,:confirmable,
         :omniauthable, omniauth_providers: %i[facebook twitter google_oauth2]
  # @return [Boolean] user should be remembered when he logs in (with cookie)
  #   so he won't be asked to login again
  #validates :cell_phone,presence: true
  def remember_me
    true
  end

  #def self.from_omniauth(auth)
    #where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      #user.email = auth.info.email
      #user.password = Devise.friendly_token[0, 20]
         # assuming the user model has a name
      # If you are using confirmable and the provider(s) you use validate emails, 
      # uncomment the line below to skip the confirmation emails.
      #user.skip_confirmation!
    #end
  #end

  # sns認証後、ユーザーの有無に応じて挙動を変更する
  def self.from_omniauth(auth)
    # uidとproviderでユーザーを検索
    user = User.find_by(uid: auth.uid, provider: auth.provider)
    if user
      #SNSを使って登録したユーザーがいたらそのユーザーを返す
      return user
    else
      #いなかった場合はnewします。
      new_user = User.new(
        email: auth.info.email,
        uid: auth.uid,
        provider: auth.provider,
        #パスワードにnull制約があるためFakerで適当に作ったものを突っ込んでいます
        password: Faker::Internet.password(min_length: 7,max_length: 128)
      )
      return new_user
    end
  end

  def self.guest    
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = "password"
      user.confirmed_at = Time.now  
    end
  end


end
