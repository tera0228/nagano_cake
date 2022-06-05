class Item < ApplicationRecord
  # アソシエーションの設定
  belongs_to :genre
  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy

  # 商品画像を投稿できるようにするための宣言
  has_one_attached :item_image

  def get_item_image(width, height)
    unless item_image.attached?
      # 商品画像が設定されていない場合、デフォルト画像を出力させる処理
      file_path = Rails.root.join('app/assets/images/item_no_image.png')
      item_image.attach(io: File.open(file_path), filename: 'item_no_image.png', content_type: 'image/jpeg')
    end
    # 商品画像が設定されている場合の出力処理
    item_image.variant(resize_to_limit: [width, height]).processed
  end
end
