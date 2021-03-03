# テーブル設計

## users テーブル

| Column               | Type     |  Options     |  Options      |
| -------------------  | -------- | ------------ | ------------- |
| email                | string   | null: false  |  nuique:true  |
| nickname             | string   | null: false  |               | 
| lastname_Full_width  | string   | null: false  |               |
| firstname_Full_width | string   | null: false  |               |
| lastname_kana        | string   | null: false  |               |
| firstname_kana       | string   | null: false  |               |
| birthday             | date     | null: false  |               |

### Association

- has_many :item_users
- has_many :items, through: item_users

##  items テーブル

| Column                    | Type               |  Options         |
| --------------------------| ------------------ | ---------------- |
| productname               | string             | null: false      |
| product_description       | text               | null: false      |
| product_condition_id      | integer            | null: false      |
| category_id               | integer            | null: false      |
| selling_price_id          | integer            | null: false      |
| shipping_charges_id       | integer            | null: false      |
| shipping_area_id          | integer            | null: false      |
| days_to_ship_id           | integer            | null: false      |
| user_id                   | references         | foreign_key:true |

### Association

- has_many :item_users
- has_many :users, through: item_users

-

## item_users テーブル

| Column           | Type               |  Options          |
| -----------------| ------------------ | ----------------- |
| user             | references         | foreign_key: true |
| selling_function | references         | foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :shippingaddresss

## shippingaddress テーブル

| Column           | Type               |  Options          |
| -----------------| ------------------ | ----------------- |
| postal_code      | integer            | null: false       |
| prefectures_id   | integer            | null: false       |
| municipality     | string             | null: false       |
| address          | string             | null: false       |
| building_name    | string             |                   |
| phone_number     | integer            | null: false       |
| user_id          | referemces         | foreign_key: true |

### Association

- berongs_to :item_user
