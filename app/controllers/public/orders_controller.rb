class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    @order = Order.new
    @order.postal_code = current_customer.postal_code
    @order.address = current_customer.address
    @order.name = current_customer.last_name + current_customer.first_name
  end

  def confirm
    @order = Order.new(order_params)

    # 自身の住所選択
    if params[:order][:address_select] == "yourself_address"
      @order.address = current_customer.address
      @order.postal_code = current_customer.postal_code
      @order.name = current_customer.last_name + current_customer.first_name

    # 登録済み住所から選択
    elsif params[:order][:address_select] == "registered_address"
      @order = Address.find(params[:order][:address_id])
      @order.address = current_customer.address.address
      @order.postal_code = current_customer.address.postal_code
      @order.name = current_customer.address.name
    # 新しいお届け先選択
    elsif params[:order][:address_select] == "new_address"
      @order.address = ?
      @order.postal_code = ?
      @order.name = ?
    else
      flash[:notice] = "必要情報を入力してください"
      render :confirm
    end
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :postage, :order_price, :pay_type)
  end
end
