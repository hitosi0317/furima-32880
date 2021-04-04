require 'rails_helper'

RSpec.describe FormPay, type: :model do
  describe '購入情報の保存' do
    before do
      @form_pay = FactoryBot.build(:form_pay)
    end

    it 'address以外の値が正しく入力されていれば登録できること' do
      expect(@form_pay).to be_valid
    end

    it 'tokenが空では登録できないこと' do
      @form_pay.token = ''
      @form_pay.valid?
      expect(@form_pay.errors.full_messages).to include("Token can't be blank")
    end

    it 'postal_codeがなければ登録できないこと' do
      @form_pay.postal_code = ''
      @form_pay.valid?
      expect(@form_pay.errors.full_messages).to include("Postal code can't be blank")
    end

    it 'postal_codeが英語では登録できないこと' do
      @form_pay.postal_code = 'aaaaa'
      @form_pay.valid?
      expect(@form_pay.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
    end

    it 'postal_codeが英数字では登録できないこと' do
      @form_pay.postal_code = 'a12-1q1q'
      @form_pay.valid?
      expect(@form_pay.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
    end

    it 'postal_codeが全角文字では登録できないこと' do
      @form_pay.postal_code = '山田-太郎太郎'
      @form_pay.valid?
      expect(@form_pay.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
    end

    it 'postal_codeに半角のハイフンが含まれていない登録できないこと' do
      @form_pay.postal_code = '1234567'
      @form_pay.valid?
      expect(@form_pay.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
    end

    it 'postal_codeが全角ハイフンでは登録できないこと' do
      @form_pay.postal_code = '000ー0000'
      @form_pay.valid?
      expect(@form_pay.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
    end

    it 'postal_codeが全角数字では登録できないこと' do
      @form_pay.postal_code = '０００-００００'
      @form_pay.valid?
      expect(@form_pay.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
    end

    it 'shipping_area_idが選択されていないと登録できないこと' do
      @form_pay.shipping_area_id = 1
      @form_pay.valid?
      expect(@form_pay.errors.full_messages).to include("Shipping area Can't be blank")
    end

    it 'municipalityが空では登録できないこと' do
      @form_pay.municipality = ''
      @form_pay.valid?
      expect(@form_pay.errors.full_messages).to include("Municipality can't be blank")
    end

    it 'addressがないと登録できないこと' do
      @form_pay.address = ''
      @form_pay.valid?
      expect(@form_pay.errors.full_messages).to include("Address can't be blank")
    end

    it 'buildkng_nameはなくても登録できる' do
      expect(@form_pay).to be_valid
    end

    it 'phone_numberがなくては登録できないこと' do
      @form_pay.phone_number = ''
      @form_pay.valid?
      expect(@form_pay.errors.full_messages).to include("Phone number can't be blank")
    end

    it 'phone_numberが半角数字10文字なら登録できる' do
      @form_pay.phone_number = 12_345_678_90
      expect(@form_pay).to be_valid
    end

    it 'phone_numberが半角数字１１文字であれば登録できること' do
      @form_pay.phone_number = 12_345_678_900
      expect(@form_pay).to be_valid
    end

    it 'phone_numberが英数字では登録できないこと' do
      @form_pay.phone_number = 'aaa111aaa11'
      @form_pay.valid?
      expect(@form_pay.errors.full_messages).to include('Phone number is invalid')
    end

    it 'phone_numberが全角文字では登録できないこと' do
      @form_pay.phone_number = '山田太郎山田太郎山田太'
      @form_pay.valid?
      expect(@form_pay.errors.full_messages).to include('Phone number is invalid')
    end

    it 'phone_numberが英語では登録 できないこと' do
      @form_pay.phone_number = 'aaaaaaaaaaa'
      @form_pay.valid?
      expect(@form_pay.errors.full_messages).to include('Phone number is invalid')
    end

    it 'phone_numberが全角数字では登録できないこと' do
      @form_pay.phone_number = '１２３４５６７８９０'
      @form_pay.valid?
      expect(@form_pay.errors.full_messages).to include('Phone number is invalid')
    end
  end
end
