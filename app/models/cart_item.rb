class CartItem < ApplicationRecord
  # アソシエーションの設定
  belongs_to :customer
  belongs_to :item
end
