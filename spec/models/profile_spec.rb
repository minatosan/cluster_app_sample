require 'rails_helper'

RSpec.describe Profile, type: :model do
  
  it { is_expected.to validate_presence_of(:nickname) }
  it { is_expected.to validate_presence_of(:text) }
  
  describe Profile do
    it "is invalid without a nickname" do
      profile=Profile.new(nickname: nil)
      profile.valid?
      expect(profile.errors[:nickname]).to include("を入力してください")
    end
    it "is invalid without a text" do
      profile=Profile.new(text: nil)
      profile.valid?
      expect(profile.errors[:text]).to include("を入力してください")
    end
  end
end
