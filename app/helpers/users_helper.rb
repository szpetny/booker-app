require 'pp'

module UsersHelper
  # Before filters
    def signed_in_user
      store_location
      redirect_to signin_url, notice: I18n.t(:please_sign_in) unless signed_in?
    end

    def admin_user
      redirect_to(root_url) unless current_user != nil && current_user.admin?
    end
end
