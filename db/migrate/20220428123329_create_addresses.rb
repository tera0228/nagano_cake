class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      # 会員ID
      t.integer :customer_id

      # 宛名
      t.string :name

      # 郵便番号
      t.string :postal_code

      # 住所
      t.string :address

      t.timestamps
    end
  end
end
