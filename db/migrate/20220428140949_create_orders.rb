class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      # 会員ID
      t.integer :customer_id

      # 配送先郵便番号
      t.string :postal_code

      # 配送先住所
      t.string :address

      # 配送先氏名
      t.string :name

      # 送料
      t.integer :postage

      # 請求額
      t.integer :order_price

      # 支払方法
      t.string :pay_type

      # 受注ステータス
      t.boolean :is_active,         null: false, default: true

      t.timestamps
    end
  end
end
