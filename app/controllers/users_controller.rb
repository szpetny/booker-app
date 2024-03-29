require 'pp'

class UsersController < ApplicationController
  before_action :admin_user,     only: [:index, :destroy]
  before_action :correct_user,   only: [:edit, :update, :show, :destroy]
  before_action :set_user_to_edit_by_admin, only: [:edit, :update]
    
  # GET /users
  # GET /users.json
  def index
    @users = User.all.order(:name).paginate(page: params[:page])
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = I18n.t(:welcome)
      redirect_to @user
    else
      render 'new'
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if @user_to_edit.update(user_params)
      flash[:success] = I18n.t(:profile_updated)
      redirect_to @user_to_edit
    else
      flash[:notice] = I18n.t(:confirm_password)
      render 'edit'
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = I18n.t(:user_destroyed)
    redirect_to users_url
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :surname, :email, :password, :password_confirmation)
    end
    
    # Before filters
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user) || (current_user != nil && current_user.admin?)
    end
    
    def set_user_to_edit_by_admin
      @user_to_edit = User.find(params[:id])
    end
end
