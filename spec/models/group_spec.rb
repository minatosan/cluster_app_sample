require 'rails_helper'

RSpec.describe Group, type: :model do
  #バリデーションテスト
  describe Group do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:text) }
    it "is invalid without a text" do
      group=Group.new(text: nil)
      group.valid?
      expect(group.errors[:text]).to include("を入力してください")
    end
  #作成時にユーザーIDがadmin_user_idに入っているのか？
    it "is include admin_user_id"  do
    end
  end
end
