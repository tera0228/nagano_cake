class Public::CartItemsController < ApplicationController
  def index
    @cart_items = Cart_item.all
  end

  def update
  end

  def destroy
  end

  def create
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :customer_id, :amount)
  end
end
