class Public::AddressesController < ApplicationController
  def index
    @address = Address.new
    @addresses = Address.all
  end

  def edit
    @address = Address.find(params[:id])
  end

  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    if @address.save
       flash[:notice] = "配送先を登録しました"
       redirect_to addresses_path(@address.customer_id)
    else
       flash[:notice] = "必要情報を入力してください/ハイフンは使用できない"
       redirect_to addresses_path
    end
  end

  def update
    @address = Address.find(params[:id])
    if @address.customer_id = current_customer.id
       @address.update(address_params)
       flash[:notice] = "配送先を編集しました"
       redirect_to addresses_path
    else
      flash[:notice] = "必要情報を入力してください/ハイフンは使用できない"
      render :edit
    end
  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    flash[:notice] = "配送先を削除しました"
    redirect_to addresses_path
  end

  private

  def address_params
    params.require(:address).permit(:customer_id, :name, :postal_code, :address)
  end
end
