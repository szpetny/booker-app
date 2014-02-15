class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :signed_in_user, only: [:new, :create, :edit, :update, :destroy, :index, :show]
  before_action :admin_user, only: [:new, :create, :edit, :update, :destroy]

  # GET /books
  # GET /books.json
  # GET /author_books
  def index
    if params[:author_id]
      @author = Author.find(params[:author_id])
      @books = @author.books
    else
      @books = Book.all
    end
  end

  # GET /books/1
  # GET /books/1.json
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
    
    @book_categories = {}
    BookCategory.all.order(:category_name).collect {|bc| @book_categories[bc.category_name] = bc.id }
  end

  # GET /books/1/edit
  def edit
    @book_categories = {}
    BookCategory.all.order(:category_name).collect {|bc| @book_categories[bc.category_name] = bc.id }
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)
    
    if @book.photo.blank?
       @book.photo = "/assets/images/default_pic.jpg"
    end
    
    respond_to do |format|
      if @book.save
        handle_book_categories
        format.html { redirect_to @book, notice: I18n.t(:book_created_successfully) }
        format.json { render action: 'show', status: :created, location: @book }
      else
        @book_categories = {}
        BookCategory.all.order(:category_name).collect {|bc| @book_categories[bc.category_name] = bc.id }
        format.html { render action: 'new' }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        handle_book_categories
        format.html { redirect_to @book, notice: I18n.t(:changes_updated_successfully) }
        format.json { head :no_content }
      else
        @book_categories = {}
        BookCategory.all.order(:category_name).collect {|bc| @book_categories[bc.category_name] = bc.id }
        format.html { render action: 'edit' }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    flash[:success] = I18n.t(:book_destroyed)
    respond_to do |format|
      format.html { redirect_to books_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:isbn, :title, :author_id, :language, :description, :photo, :quantity, :place, :release_date, :pages)
    end
    
    def handle_book_categories
      if params['book_category_ids']
        @book.book_categories.clear
        book_categories = params['book_category_ids'].map { |id| BookCategory.find(id) }
        @book.book_categories << book_categories 
      end
    end 
     
end
