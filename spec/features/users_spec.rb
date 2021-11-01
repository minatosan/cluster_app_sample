require 'rails_helper'

RSpec.feature "Users", type: :feature do
  include Devise::Test::IntegrationHelpers
  
 # let(:user) { create(:user) }
  user=FactoryBot.create(:user)
  profile=  FactoryBot.create(:profile, user_id: user.id) 
  puts(profile)
  scenario 'ログインができるか' do
    visit root_path
    expect(page).to have_no_content('新規アルバムの作成')
    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    expect(page).to have_content('ログイン')
    click_button "ログイン"
    expect(page).to have_content("logout")
  end
  scenario 'ログインできないか' do
    visit new_user_session_path
    click_button "ログイン"
    expect(page).to have_content("login")
  end
  
  scenario 'ログアウトできるか' do
    login_as user
    visit root_path
    click_link "logout"
    expect(page).to have_content("login")
  end
  scenario 'ゲストでログインができるか' do
    visit root_path
    click_link "ゲストでログイン"
    expect(page).to have_content("logout")
  end

end
