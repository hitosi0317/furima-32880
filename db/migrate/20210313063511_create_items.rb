class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.text       :product_name          , null: false
      t.text       :product_description   , null: false
      t.integer    :selling_price         , null: false
      t.integer    :product_condition_id  , null: false
      t.integer    :category_id           , null: false
      t.integer    :shipping_charge_id    , null: false
      t.integer    :shipping_area_id      , null: false
      t.integer    :days_to_ship_id       , null: false
      t.references :user
      t.timestamps
    end
    add_foreign_key :items, :users
  end
end
