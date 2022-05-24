class Address < ApplicationRecord
  # アソシエーションの設定
  belongs_to :customer

  # 「郵便番号 住所 宛名」で、この表示をできるように設定
  def address_display
  '〒' + postal_code + ' ' + address + ' ' + name
  end
end
