require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe User do
    user=FactoryBot.create(:user)
    puts(user)
    it "has a valid factory" do
      expect(FactoryBot.build(:user)).to be_valid
    end
    #必須であるかのテスト
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password)}
    #it { is_expected.to validate_presence_of(:cell_phone) }
    #エラーメッセージのテスト

    it "is invalid without an email" do
      user=User.new(email: nil)
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end

    it "is invalid without an password" do
      user=User.new(password: nil)
      user.valid?
      expect(user.errors[:password]).to include("を入力してください")
    end

   
    it "is invalid without an cell_phone" do
      user=User.new(cell_phone: nil)
      user.valid?
      #expect(user.errors[:cell_phone]).to include("を入力してください")
    end
    
  end
end