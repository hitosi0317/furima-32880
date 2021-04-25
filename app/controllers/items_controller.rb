class ItemsController < ApplicationController
  before_action :search_product, only: [:category_search,:search, :index, :show]
  before_action :set_item, only: [:edit, :show, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :order_index, only: [:edit, :update]
  before_action :move_to_index, except: [:index, :show, :new, :create, :search,:category_search]

  def index
    @item = Item.order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def search
    @item = Item.search(params[:keyword])
  end

  def category_search
    
    @results = @p.result
    if @results[0] != nil
      @category_id = Category.find(@results[0].category_id).name 
    end
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path
    else
      render :edit
    end
  end

  def destroy
    redirect_to root_path if @item.destroy
  end

  private

  def item_params
    params.require(:item).permit(:product_name, :product_description, :selling_price, :image, :category_id,
                                 :product_condition_id, :shipping_charge_id, :shipping_area_id, :days_to_ship_id).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def move_to_index
    redirect_to action: :index unless @item.user_id == current_user.id
  end

  def order_index
    redirect_to root_path unless @item.order.nil?
  end

  def search_product
   @p = Item.ransack(params[:q])
  end
end
