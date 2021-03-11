FactoryBot.define do
  factory :user do
    nickname              { Faker::FunnyName.name }
    email                 { Faker::Internet.free_email }
    password              { '1a' + Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    lastname_full_width   { '山田ひコ' }
    firstname_full_width  { '太郎ひコ' }
    lastname_kana         { 'ヤマダ' }
    firstname_kana        { 'タロウ' }
    birthday              { Faker::Date.between(from: '1930-01-01', to: '2015-12-31') }
  end
end
