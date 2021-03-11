require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'nicknameとemail、passwordとpassword_confirmation,lastname_full_width, farst_name_full_width, lastname_kana, firstname_kanaが存在すれば登録できる' do
        expect(@user).to be_valid
      end
      it 'nicknameがあれば登録できる' do
        @user.nickname
        expect(@user).to be_valid
      end
      it 'emailがあれば登録できる' do
        @user.email
        expect(@user).to be_valid
      end
      it 'passwordとpassword_confirmationが6文字以上尚且つ半角英数字混合であれば登録できる' do
        @user.password = 'hitosi7'
        @user.password_confirmation = 'hitosi7'
        expect(@user).to be_valid
      end
      it 'lastname_full_widthとfirstname_full_widthが全角(漢字, ひらがな, カタカナ)であれば登録できる' do
        @user.lastname_full_width = "山田やまだヤマダ"
        @user.firstname_full_width = "太郎たろうタロウ"
        expect(@user).to be_valid
      end
      it 'lastname_kanaとfirstnam_kanaがカタカナであれば登録できる' do
        @user.lastname_kana
        @user.firstname_kana
        expect(@user).to be_valid
      end
      it 'birthdayががあれば登録できる' do
        @user.birthday
        expect(@user).to be_valid
      end
    end

    context '新規登録できないとき' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Nickname can't be blank"
      end

      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Email can't be blank"
      end
      it 'emailに＠がないと登録できない' do
        @user.email = 'hogegmail.com'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Email is invalid'
      end

      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Password can't be blank"
      end

      it 'passwordが存在してもpassword_confirmationが空では登録できない' do
        @user.password
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
      end

      it 'lastname_full_widthが存在してもfirstname_full_widthがなければ登録できない' do
        @user.firstname_full_width = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Firstname full width can't be blank"
      end

      it 'firstname_full_widthが存在してもlastname_full_widthがなければ登録できない' do
        @user.lastname_full_width = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Lastname full width can't be blank"
      end

      it 'lastname_full_widthが全角(漢字, ひらがな, カタカナ)でなければ登録できない' do
        @user.lastname_full_width = 'yamada'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Lastname full width is invalid'
      end

      it 'firstname_full_widthが全角(漢字, ひらがな, カタカナ)でなければ登録できない' do
        @user.firstname_full_width = 'hitosi'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Firstname full width is invalid'
      end

      it 'lastname_kanaが全角(カタカナ)でなければ登録できない' do
        @user.lastname_kana = 'こん'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Lastname kana is invalid'
      end

      it 'firstname_kanaが全角(カタカナ)でなければ登録できない' do
        @user.firstname_kana = 'こん'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Firstname kana is invalid'
      end

      it 'lastname_kanaが空では登録できない' do
        @user.lastname_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include "Lastname kana can't be blank"
      end

      it 'firstnama_kanaが空では登録できない' do
        @user.firstname_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include "Firstname kana can't be blank"
      end

      it '重複したemailが存在する場合登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end

      it 'passwordが5文字以下では登録できない' do
        @user.password = 'aaaa1'
        @user.password_confirmation = 'aaaa1'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Password is too short (minimum is 6 characters)'
      end

      it 'passwordは半角(英語)のみでは登録できない' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Password is invalid'
      end

      it 'passwordは半角(数字)のみでは登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Password is invalid'
      end

      it 'passwordは全角ではでは登録できない' do
        @user.password = '山田１２３４'
        @user.password_confirmation = '山田１２３４'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Password is invalid'
      end

      it 'birstdayがからでは登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Birthday can't be blank"
      end
    end
  end
end
