class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @customers = Customer.all
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      flash[:notice] = '個人情報を編集しました'
      redirect_to admin_customer_path(@customer)
    else
      flash[:notice] = '個人情報の編集に失敗しました'
      render :edit
    end
  end

  private

  def customer_params
    params.require(:customers).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :is_active)
  end
end
