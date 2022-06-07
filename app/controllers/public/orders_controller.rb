class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    @order = Order.new
    @order.postal_code = current_customer.postal_code
    @order.address = current_customer.address
    @order.name = current_customer.last_name + current_customer.first_name
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @sum = 0
  end

  def confirm
    @order = Order.new(order_params)

    # 送料
    @postage = 800
    # 商品合計金額
    @total_price = 0
    # 請求金額
    @order_price = 0

    # 自身の住所選択
    if params[:order][:address_select] == "yourself_address"
      @order.address = current_customer.address
      @order.postal_code = current_customer.postal_code
      @order.name = current_customer.last_name + current_customer.first_name

    # 登録済み住所から選択
    elsif params[:order][:address_select] == "registered_address"
      shipment_address = Address.find(params[:order][:address_id])
      @order.address = shipment_address.address
      @order.postal_code = shipment_address.postal_code
      @order.name = shipment_address.name
    # 新しいお届け先選択
    elsif params[:order][:address_select] == "new_address"
      @address = Address.new()
      @address.customer_id = current_customer.id
      @address.address = params[:order][:address]
      @address.name = params[:order][:name]
      @address.postal_code = params[:order][:postal_code]
      if @address.save
        @order.address = @address.address
        @order.postal_code = @address.postal_code
        @order.name = @address.name
      else
        flash[:notice] = "必要情報を入力してください"
        render :new
      end
    end
  end

  def create
    # 注文情報(confirmから送られてくるもの)を定義
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    # 注文情報を保存
    if @order.save
      # 注文内容を注文明細テーブルへ格納する
      # 注文内容はカートの中に入っている→カートの一覧からデータを引っ張ってくる
      # current_customer.cart_item.each を使って、注文詳細を作成
      current_customer.cart_items.each do |cart_item|
        @order_detail = OrderDetail.new
        @order_detail.order_id = @order.id
        @order_detail.item_id = cart_item.item.id
        @order_detail.price = cart_item.item.price
        @order_detail.amount = cart_item.amount
        @order_detail.save
      end
      # 注文内容を注文明細テーブルへ格納後、カート情報を削除し購入完了画面へ遷移
      current_customer.cart_items.destroy_all
      redirect_to thank_path
    else
      render :new
    end
  end

  def thanks
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :postage, :order_price, :pay_type)
  end
end
