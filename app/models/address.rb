class Address < ApplicationRecord
  # アソシエーションの設定
  belongs_to :customer
end
