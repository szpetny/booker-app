module UsersHelper
  # Before filters
    def signed_in_user
      store_location
      redirect_to signin_url, notice: "Please sign in." unless signed_in?
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
