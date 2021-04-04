class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :move_index, only: [:index, :create]
  before_action :set_item, only: [:index, :create]
  def index
    @form_pay = FormPay.new
    redirect_to root_path if current_user == @item.user
  end

  def create
    @form_pay = FormPay.new(form_params)
    if @form_pay.valid?
      pay_item
      @form_pay.save
      redirect_to root_path
    else
      render action: :index
    end
  end

  private

  def form_params
    params.require(:form_pay).permit(:postal_code, :shipping_area_id, :municipality, :address, :building_name, :phone_number, :item_id).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def pay_item
    @item = Item.find(params[:item_id])
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.selling_price,
      card: form_params[:token],
      currency: 'jpy'
    )
  end

  def move_index
    @item = Item.find(params[:item_id])
    redirect_to root_path unless @item.order.nil?
  end

  def set_item
    @item = Item.find(params[:item_id])
  end
end
