class FormPay
  include ActiveModel::Model
  attr_accessor :token, :item_id, :user_id, :postal_code, :shipping_area_id, :municipality, :address, :building_name,
                :phone_number

  with_options presence: true do
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :token, presence: true
    validates :municipality
    validates :address
    validates :phone_number, format: { with: /\A[0-9]+\z/ }
  end
  validates :shipping_area_id, numericality: { other_than: 1, message: "Can't be blank" }

  def save
    order = Order.create(item_id: item_id, user_id: user_id)
    Shipping.create(postal_code: postal_code, shipping_area_id: shipping_area_id, municipality: municipality, address: address,
                    building_name: building_name, phone_number: phone_number, order_id: order.id)
  end
end
