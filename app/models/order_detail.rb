class OrderDetail < ApplicationRecord
  # アソシエーションの設定
  belongs_to :order
  belongs_to :item

  def subtotal
      (item.price * 1.1).floor * amount
  end
end
