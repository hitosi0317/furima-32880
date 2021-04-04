FactoryBot.define do
  factory :form_pay do
    token { 'tok_abcdefghijk00000000000000000' }
    postal_code { '123-4567' }
    shipping_area_id { 15 }
    municipality { '大阪府' }
    address { '青山1-1-1' }
    phone_number { '09012345678' }
 
  end
end
