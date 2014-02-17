class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: downcase_email)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_back_or_default
    else
      flash.now[:error] =  I18n.t(:invalid_email_pass_combination)
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
  
  private
  
    def downcase_email 
      return params[:session][:email].downcase
    end
end
