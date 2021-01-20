# README

# 本アプリケーションについて

## アプリケーション名
- 「Kakomo」

## キャッチコピー
- 「おいしいを、囲もう。」

## アプリケーション概要
- 「オンライン飲み会に参加する人に共通のおつまみを食べてもらいたい」という思いから生まれた、コミュニケーションフードサービスです。おつまみをサイト上で注文し、参加者の自宅までお届けします。以前は当たり前だった「みんなで食卓を囲む」体験を、オンライン上で体験していただくことを目的にしています。

## 利用方法
- 幹事の方が、サイトからご注文ください。
- 「料理のジャンル」「シーン」「合わせたい飲み物」のカテゴリーから検索が可能です。「おつまみ診断」では全てのカテゴリーから一括検索ができ、最適なおつまみをご提案します。
- お申し込み完了後、幹事様あてに参加者用個別フォームをお送りします。配送先、希望時間、アレルギーの有無などを参加者様が入力し、このフォームから送信していただきます。
- 飲み会前日または当日に、料理をお届けします。
- 飲み会終了後、口コミ投稿が可能です。

## 目指した課題解決
- コロナ禍で、仲間とコミュニケーションを取る時間が減ってきています。本アプリでは人々に「一緒に食卓を囲む」時間を提供することで、人と人が繋がる時間を得ていただくことを目的としています。
- 今後ますます需要が高まることが予想されるオンライン飲み会。個人的な飲み会はもちろん、会社の歓送迎会にも手軽にご利用いただけるアプリを目指しました。
- ウーバーイーツの対象になりにくい居酒屋等の飲食店が参入しやすく、飲食業界の売上向上に貢献できます。
- 同じおつまみを食べることで飲み会を切り上げるタイミングもスマートに決められるため、オンライン飲み会の悩みである「終わりの時間がわからない」問題を解決できます。

## 洗い出した要件
- 新規登録／ログイン
- 商品出品
- 商品検索
- 商品購入
- 口コミ投稿

## 実装した機能についてのGIFと説明
- 新規登録／ログイン  
・法人として新規登録&ログインすると商品を出品できます。  
・個人として新規登録&ログインすると商品購入／感想投稿ができます。  

- 商品出品  
・複数条件を指定した上で商品を出品することができます。  

- 商品検索  
・複数条件を指定した上で購入したい商品の検索ができます。  

- 商品購入  
・購入したい商品をクリックすると購入が完了します。  
・参加者入力用フォームに配送先やアレルギー情報を入力して送信すると情報が出店側に送られます。  

- 口コミ投稿  
・必要事項を入力すると口コミを投稿することができます。  

## 実装予定の機能  
- 新規登録／ログイン  
・法人用／個人用の入り口を分け、それぞれにマイページを作成できるようにします。  

- 商品検索  
・タグで絞って検索&複数タグと紐づいた商品を表示できるようにします。  

- 商品購入  
・PAY.JPを通してクレジットカード決済ができるようにします。  
・購入後、参加者入力用フォームが出店側に送信されるようにします。


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