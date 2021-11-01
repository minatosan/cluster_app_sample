require 'rails_helper'

RSpec.describe "Groups", type: :request do
  include Devise::Test::IntegrationHelpers
  it "フレンドがいなくてもグループが作成できるか" do
    user=FactoryBot.create(:user)
    profile=  FactoryBot.create(:profile, user_id: user.id) 
    login_as user
    get "/groups/new"
    expect(response.status).to eq(200)
  end
end
