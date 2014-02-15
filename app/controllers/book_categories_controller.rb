class BookCategoriesController < ApplicationController
  before_action :set_book_category, only: [:destroy]
  before_action :signed_in_user, only: [:create, :destroy, :index]
  before_action :admin_user, only: [:create, :destroy]
  
  # GET /book_categories
  def index
    @book_categories = BookCategory.all.order(:category_name)
  end
  
  # POST /book_categories
  # POST /book_categories.json
  def create
    @book_category = BookCategory.new(book_category_params)
    #logger.debug "create  #{@book_category.category_name}"
    respond_to do |format|
      if @book_category.save
         format.json { render json: @book_category, status: :created }
      else
        format.json { render json: @book_category.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # DELETE /book_categories/1
  # DELETE /book_categories/1.json
  def destroy
    @book_category.destroy
    flash[:success] = I18n.t(:book_category_destroyed)
    respond_to do |format|
      format.html { redirect_to book_categories_url }
      format.json { head :no_content }
    end
  end
  
  private
    def book_category_params
      params.require(:book_category).permit(:category_name)
    end
    
    def set_book_category
      @book_category = BookCategory.find(params[:id])
    end
end
