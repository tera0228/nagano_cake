class OrderDetail < ApplicationRecord
  # アソシエーションの設定
  belongs_to :order
  belongs_to :item
end
