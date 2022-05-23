class Public::CartItemsController < ApplicationController
  def index
    @cart_items = CartItem.all
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(:amount)
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    flash[:notice] = "カートから削除しました"
    redirect_to cart_items_path
  end

  def destroy_all
    current_customer.cart_items.destroy_all
    flash[:notice] = "カートは空です"
    redirect_to cart_items_path
  end

  def create
    # カートアイテムのデータを取得
    @cart_item = CartItem.new(cart_item_params)
    # ログインユーザーのデータ取得用
    @cart_items = current_customer.cart_items
    # 追加した商品がカート内に存在するかの判別
    if @cart_items.find_by(item_id: @cart_item.item_id)
       # 存在した場合、カート内の個数をフォームから送られた個数分追加する

       # ログインユーザーのアイテムidを取得
       @cart_item_amount = @cart_items.find_by(item_id: @cart_item.item_id)
       # 新規追加と元々カートに入れていた数量を加算する処理
       @cart_item_new_amount = @cart_item_amount.amount + @cart_item.amount
       # 数量を更新する処理
       @cart_item_amount.update(amount: @cart_item_new_amount)
       redirect_to cart_items_path
    else
       # 存在しなかった場合、カートモデルにレコードを新規作成する
       @cart_item.save
       redirect_to cart_items_path
    end
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :customer_id, :amount)
  end
end