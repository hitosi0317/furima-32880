FactoryBot.define do
  factory :item do
   product_name {Faker::Name.initials(number: 39)}
   product_description {Faker::Lorem.characters(number: 1000)}
   product_condition_id {2}
   category_id          {2}
   shipping_charge_id   {2}
   shipping_area_id     {2}
   days_to_ship_id      {2}
   selling_price        {300}
   association :user

   after(:build) do |product|
    product.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
   end

  end
end
