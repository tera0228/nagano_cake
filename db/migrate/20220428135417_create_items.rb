class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      # ジャンルID
      t.integer :genre_id

      # 商品名
      t.string :name

      # 商品説明文
      t.text :introduction

      # 税抜き価格
      t.integer :price

      # 販売ステータス
      t.boolean :is_active,         null: false, default: true

      t.timestamps
    end
  end
end
