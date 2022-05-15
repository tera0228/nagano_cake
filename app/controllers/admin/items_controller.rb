class Admin::ItemsController < ApplicationController
  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:notice]="商品を登録しました"
      redirect_to admin_item_path(@item.id)
    else
      render :new
    end
  end

  def new
    @item = Item.new
  end

  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash[:notice] = "商品を更新しました"
      redirect_to admin_item_path(@item)
    else
      flash[:notice] = "必要情報を入力してください"
      render :edit
    end
  end

  # ストロングパラメータ
  private

  def item_params
    params.require(:item).permit(:genre_id, :name, :introduction, :price, :is_active, :item_image)
  end
end