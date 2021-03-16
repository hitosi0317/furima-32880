class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :product_condition
  belongs_to :shipping_area
  belongs_to :shipping_charge
  belongs_to :days_to_ship
  
  validates :product_name, :product_description, :selling_price, :image, presence: true
  validates_inclusion_of :selling_price, in:300..9999999
  PRICE = /\A[0-9]+\z/
  validates_format_of :selling_price, with: PRICE
  
  with_options numericality: {other_than: 1 } do
  validates :product_condition_id
  validates :category_id
  validates :shipping_charge_id

  validates :days_to_ship_id
  end
  
  
 
end
