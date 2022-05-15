class Genre < ApplicationRecord
  # アソシエーションの設定
  has_many :items, dependent: :destroy
end
