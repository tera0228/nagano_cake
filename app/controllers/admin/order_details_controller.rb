class Admin::OrderDetailsController < ApplicationController
  private

  def order_detail_params
    params.require(:order_detail).permit(:item_id, :order_id, :price, :name, :amount, :is_active,)
  end
end
