class Public::CustomersController < ApplicationController
  def show
    @customer = current_customer
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    @customer.update(customer_params)
    if @customer.id == current_customer.id
      flash[:notice] = "マイページを更新しました"
      redirect_to customer_path(@customer.id)
    else
      flash[:notice] = "マイページの更新に失敗しました"
      render :edit
    end
  end

  def leave
    @customer = current_customer
  end

  def quit
    @customer = Customer.find(params[:id])
    @customer.update(is_active: false)
    flash[:notice] = "退会処理が完了しました"
    # 退会処理後ログアウトさせる処理
    reset_session
    redirect_to root_path
  end

  # ストロングパラメータ
  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :encrypted_password, :postal_code, :address, :telephone_number, :is_active)
  end
end
