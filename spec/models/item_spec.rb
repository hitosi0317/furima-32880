require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
   @item = FactoryBot.build(:item)
  end


    describe '商品情報の保存' do
    context "商品情報登録できる場合" do
      it "画像と商品名と商品の説明と商品の状態とカテゴリーと配送料の負担と配送地域と配送までの日数があれば登録できる" do
        expect(@item).to be_valid
      end
    end

    context "商品情報登録できない場合" do
      it "画像がなければ登録できない" do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include( "Image can't be blank")
      end
      it "商品名がなければ登録できない" do
       @item.product_name = ""
       @item.valid?
       expect(@item.errors.full_messages).to include("Product name can't be blank")
      end
      it "商品名の説明がなければ登録できない"do
      @item.product_description = ""
      @item.valid?
      expect(@item.errors.full_messages).to include("Product description can't be blank")
      end
      
      it "カテゴリーがなければ登録できない" do
        @item.category_id = "1"
        @item.valid?
        expect(@item.errors.full_messages).to include( "Category must be other than 1")
      end
      it "配送料の負担がなければ登録できない" do
        @item.shipping_charge_id = "1"
        @item.valid?
        expect(@item.errors.full_messages).to include( "Shipping charge must be other than 1")
      end

      it "発送までの日数がなければ登録できない" do
        @item.days_to_ship_id = "1"
        @item.valid?
        expect(@item.errors.full_messages).to include( "Days to ship must be other than 1")
      end
      
      it "販売価格がなければ登録できない" do
        @item.selling_price = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Selling price can't be blank")
      end
      it "販売価格が半角数字でなければ登録できない" do
        @item.selling_price = "１１１１"
        @item.valid?
        expect(@item.errors.full_messages).to include("Selling price is not included in the list")
      end
      it "販売価格があっても299円以下では登録できない" do
        @item.selling_price = "299"
        @item.valid?
        expect(@item.errors.full_messages).to include("Selling price is not included in the list")
      end
      it "販売価格があっても10000000以上では登録できない"do
        @item.selling_price = "10000000"
        @item.valid?
        expect(@item.errors.full_messages).to include("Selling price is not included in the list")
      end
    end
  end
end