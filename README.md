# テーブル設計

## users テーブル

| Column               | Type     |  Options     |  Options      |
| -------------------  | -------- | ------------ | ------------- |
| email                | string   | null: false  | nuique :true  |
| encrypted_password   | string   | null: false  |               |
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
| shipping_charges          | integer            | null: false      |
| shipping_area_id          | integer            | null: false      |
| days_to_ship_id           | integer            | null: false      |
| user                      | references         | foreign_key:true |

### Association

- has_one :item_users
- berongs_to :user, through: item_user



## item_users テーブル

| Column           | Type               |  Options          |
| -----------------| ------------------ | ----------------- |
| user             | references         | foreign_key: true |
| item             | references         | foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :shippingaddresss

## shippingaddress テーブル

| Column           | Type               |  Options          |
| -----------------| ------------------ | ----------------- |
| postal_code      | integer            |                   |
| prefectures_id   | integer            | null: false       |
| municipality     | string             | null: false       |
| address          | string             | null: false       |
| building_name    | string             |                   |
| phone_number     | integer            | null: false       |
| user_item        | referemces         | foreign_key: true |

### Association

- berongs_to :item_user
