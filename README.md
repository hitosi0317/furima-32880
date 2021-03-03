
## users テーブル

| Column               | Type     |  Options     |  Options      |
| -------------------  | -------- | ------------ | ------------- |
| email                | string   | null: false  |  nuique:true  |
| password             | string   | null: false  |               |
| nickname             | string   | null: false  |               | 
| lastname_Full_width  | string   | null: false  |               |
| firstname_Full_width | string   | null: false  |               |
| lastname_kana        | string   | null: false  |               |
| firstname_kana       | string   | null: false  |               |
| birthday             | datetime | null: false  |               |

### Association

- has_many :items
- has_many :productpuchases

##  items テーブル


| Column                    | Type               |  Options     |
| --------------------------| ------------------ | ------------ |
| image                     | ActiveStorageで実装 | null: false  |
| productname               | text               | null: false  |
| product_description       | string             | null: false  |
| product_condition         | text               | null: false  |
| category                  | string             | null: false  |
| selling_price             | integer            | null: false  |

### Association

- belongs_to :user
- has_one : productpuchase

## Product_purchase テーブル

| Column           | Type               |  Options     |
| -----------------| ------------------ | ------------ |
| postal_code      | integer            | null: false  |
| prefectures      | string             | null: false  |
| municipality     | string             | null: false  |
| address          | string             | null: false  |
| building_name    | string             |              |
| phone_number     | integer            | null: false  |

### Association

- berongs_to :user 
- berongs_to :item
- has_one :shippingaddress


## shipping_address

| Column                    | Type               |  Options     |
| --------------------------| ------------------ | ------------ |
| Burden_of_shipping_charge | string             | null: false  |
| shipping_area             | string             | null: false  |
| days_to_ship              | string             | null: false  |

### Association

- berongs_to :productpuchase