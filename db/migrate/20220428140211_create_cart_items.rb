class CreateCartItems < ActiveRecord::Migration[6.1]
  def change
    create_table :cart_items do |t|
      # 商品ID
      t.integer :item_id

      # 会員ID
      t.integer :customer_id

      # 数量
      t.integer :amount

      t.timestamps
    end
  end
end
