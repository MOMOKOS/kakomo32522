# README

# テーブル設計

## Buyers テーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| nickname           | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| family_name        | string | null: false               |
| first_name         | string | null: false               |
| family_name_kana   | string | null: false               |
| first_name_kana    | string | null: false               |
| birth_day          | date   | null: false               |

### Association

- has_many :orders
- has_one :chart

## Sellers テーブル

| Column             | Type        | Options                        |
| ------------------ | ----------- | ------------------------------ |
| shop_name          | string      | null: false                    |
| shop_email         | string      | null: false, unique: true      |
| encrypted_password | integer     | null: false                    |
| post_code          | string      | null: false                    |
| prefecture         | integer     | null: false                    |  <!--　ActiveHashでプルダウン選択　-->
| city               | string      | null: false                    |
| address            | string      | null: false                    |
| building_name      | string      |                                |
| phone_number       | integer     | null: false                    |

### Association

- has_many :items

## Items テーブル

| Column             | Type       | Options                            |
| ------------------ | ---------- | ---------------------------------- |
| name               | string     | null: false                        |
| price              | integer    | null: false                        |
| description        | text       | null: false                        |
| shipping_day       | integer    | null: false, foreign_key: true     |   <!--　ActiveHashでプルダウン選択　-->
| seller             | references | null: false, foreign_key: true     |

### Association

- belongs_to : sellers
- has_one : order
- has_one : chart


## Charts テーブル

| Column             | Type       | Options                            |
| ------------------ | ---------- | ---------------------------------- |
| party_scene        | integer    | null: false                        |   <!--　ActiveHashでプルダウン選択　-->
| party_genre        | integer    | null: false                        |   <!--　ActiveHashでプルダウン選択　-->
| party_drink        | integer    | null: false                        |   <!--　ActiveHashでプルダウン選択　-->
| item               | references | null: false, foreign_key: true     |
| buyer              | references | null: false, foreign_key: true     |

### Association

- belongs_to : items
- belongs_to : buyers

## Orders テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| buyer   | references | null: false, foreign_key: true |
| item    | references | null: false, foreign_key: true |

### Association

- belongs_to :buyers
- belongs_to :items
- has_one  :destination

## Destinations テーブル

| Column                    | Type       | Options                            |
| ------------------------- | ---------- | ---------------------------------- |
| post_code                 | string     | null: false                        |
| prefecture                | integer    | null: false                        |  <!--　ActiveHashでプルダウン選択　-->
| city                      | string     | null: false                        |
| address                   | string     | null: false                        |
| building_name             | string     |                                    |
| phone_number              | string     | null: false                        |
| order                     | references | null: false, foreign_key: true     |

### Association

- belongs_to :orders