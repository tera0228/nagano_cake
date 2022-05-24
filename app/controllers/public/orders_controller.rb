class Public::OrdersController < ApplicationController
  def new
    @order = Order.new(order_params)
  end

  def check
  end

  private

  def order_params
    require(:order).permit(:customer_id, :postal_code, :address, :name, :postage, :order_price, :pay_type, :is_active)
  end
end
