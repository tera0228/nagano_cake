# frozen_string_literal: true

# 管理者ログイン機能
class Admin::SessionsController < Devise::SessionsController
  before_action :configure_permitted_parameters, if: :devise_controller?

  # 管理者ログイン後の遷移先設定
  def after_sign_in_path_for(resource)
    admin_path
  end

  # 管理者ログイン後の遷移先設定
  def after_sign_out_path_for(resource)
    admin_session_path
  end

  protected

  # ストロングパラメータ
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email])
  end
end
