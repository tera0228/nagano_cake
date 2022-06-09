class Order < ApplicationRecord
  # アソシエーションの設定
  has_many :order_details, dependent: :destroy
  belongs_to :customer
  # enum を定義する
  enum pay_type: { credit_card: 0, transfer: 1 }
end
