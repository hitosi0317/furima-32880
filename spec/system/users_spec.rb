require 'rails_helper'

RSpec.describe '新規登録', type: :system do
  before do
    @user = FactoryBot.build(:user)
  end

  def basic_pass(path)
    username = ENV['BASIC_AUTH_USER']
    password = ENV['BASIC_AUTH_PASSWORD']
    visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
  end

  context 'ユーザー新規登録ができる時' do
    it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する。' do
      # トップページに移動する
      basic_pass root_path
      # ログアウト状態ではトップページに新規登録ページへ遷移するボタンがあることを確認する
      expect(page).to have_content('新規登録')
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力し登録する。
      fill_in 'nickname', with: @user.nickname
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      fill_in 'password-confirmation', with: @user.password_confirmation
      fill_in 'last-name', with: @user.lastname_full_width
      fill_in 'first-name', with: @user.firstname_full_width
      fill_in 'last-name-kana', with: @user.lastname_kana
      fill_in 'first-name-kana', with: @user.firstname_kana
      select '1988', from: 'user_birthday_1i'
      select '3', from: 'user_birthday_2i'
      select '3', from: 'user_birthday_3i'
      find('input[name="commit"]').click
      # トップページに遷移したことを確認する
      expect(current_path).to eq(root_path)
      # ログイン状態ではログアウトボタンとニックネームボタンがあることを確認する
      expect(page).to have_content('ログアウト')
      expect(page).to have_content(@user.nickname)
      # ログアウトボタンを押すとログアウトできる
      find_link('ログアウト', href: destroy_user_session_path).click
      # トップページにリダイレクトしたことを確認する
      expect(current_path).to eq(root_path)
    end
  end

  context 'ユーザー新規登録ができない時' do
    it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      # トップページに移動する
      basic_pass root_path
      # ログアウト状態ではトップページに新規登録ページがあることを確認する。
      expect(page).to have_content('新規登録')
      # 新規登録ページに移動する
      visit new_user_registration_path
      # 誤ったユーザー情報で登録ボタンを押す
      fill_in 'nickname', with: ''
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      fill_in 'password-confirmation', with: @user.password_confirmation
      fill_in 'last-name', with: @user.lastname_full_width
      fill_in 'first-name', with: @user.firstname_full_width
      fill_in 'last-name-kana', with: @user.lastname_kana
      fill_in 'first-name-kana', with: @user.firstname_kana
      # 新規登録ページに戻されることを確認する
      expect(current_path).to eq(new_user_registration_path)
    end
  end
end

RSpec.describe 'ログイン', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end
  context 'ログインできる時' do
    it '保存されているユーザーの情報と合致すればログインができる' do
      # トップページに移動する
      visit root_path
      # #トップページにログインページへ推移するボタンがあることを確認する
      expect(page).to have_content('ログイン')
      # ログインページへ遷移する
      visit new_user_session_path
      # 正しいユーザー情報を入力する
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      # ログインボタンを押す
      find('input[name="commit"]').click
      # トップページへ遷移することを確認する
      expect(current_path).to eq root_path
      # ログイン状態ではnicknameが表示されていることを確認する
      expect(page).to have_content(@user.nickname)
    end
  end

  context 'ログインできない時' do
    it '保存されているユーザーの情報と合致しなければログインできない' do
      # トップページに移動する
      visit root_path
      # トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content('ログイン')
      # ログインページへ遷移する
      visit new_user_session_path
      # 誤ったユーザー情報を入力する
      fill_in 'email', with: ''
      fill_in 'password', with: @user.password
      # ログインボタンを押す
      find('input[name="commit"]').click
      # ログインページへ戻されることを確認する
      expect(current_path).to eq new_user_session_path
    end
  end
end
