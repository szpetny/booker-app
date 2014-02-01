class BookCategoriesController < ApplicationController

  # POST /book_categories
  # POST /book_categories.json
  def create
    @book_category = BookCategory.new(book_category_params)

    respond_to do |format|
      if @book_category.save
         format.json { render json: @book_category }
      else
        format.json { render json: @book_category.errors, status: :unprocessable_entity }
      end
    end
  end
  
  private
    def book_category_params
      params.require(:book_category).permit(:category_name)
    end
end
