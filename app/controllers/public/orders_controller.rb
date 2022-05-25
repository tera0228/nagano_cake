class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @order.postal_code = current_customer.postal_code
    @order.address = current_customer.address
    @order.name = current_customer.first_name + current_customer.last_name
  end

  def confirm
    @order = Order.new(order_params)
  end

  private

  def order_params
    params.require(:order).permit(:postal_code, :address, :name, :postage, :order_price, :pay_type)
  end
end
