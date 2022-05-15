class CreateOrderDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :order_details do |t|
      # 商品ID
      t.integer :item_id

      # 注文ID
      t.integer :order_id

      # 購入時価格(税込)
      t.integer :price

      # 数量
      t.integer :amount

      # 制作ステータス
      t.boolean :is_active,         null: false, default: true

      t.timestamps
    end
  end
end
