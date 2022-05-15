class Order < ApplicationRecord
  # アソシエーションの設定
  has_many :order_details, dependent: :destroy
end
