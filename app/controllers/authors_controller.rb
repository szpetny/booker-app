class AuthorsController < ApplicationController
  before_action :set_author, only: [:edit, :update, :destroy]
  before_action :signed_in_user, only: [:new, :create, :edit, :update, :destroy, :index]
  before_action :admin_user, only: [:new, :create, :edit, :update, :destroy]

  # GET /authors
  # GET /authors.json
  def index
      unless params[:author_search].blank?
        @authors = Author.where("surname like :surname OR name like :name",
                  {surname: params[:author_search], name: params[:author_search]})
                  .order(:surname).paginate(page: params[:page], per_page: 10)
      else
        @authors = Author.all.order(:surname).paginate(page: params[:page], per_page: 10)
      end
  end

  # GET /authors/new
  def new
    @author = Author.new
  end

  # GET /authors/1/edit
  def edit
  end

  # POST /authors
  # POST /authors.json
  def create
    @author = Author.new(author_params)

    respond_to do |format|
      if @author.save
        format.html { redirect_to authors_url, notice: I18n.t(:author_created_successfully) }
        format.json { render json: Author.all.order(:surname), status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @author.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /authors/1
  # PATCH/PUT /authors/1.json
  def update
    respond_to do |format|
      if @author.update(author_params)
        format.html { redirect_to authors_url, notice: I18n.t(:changes_updated_successfully) }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @author.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /authors/1
  # DELETE /authors/1.json
  def destroy
    begin
      @author.destroy
    rescue ActiveRecord::DeleteRestrictionError => e
      flash.now[:error] = I18n.t(:books_exist)
    end
    redirect_to action: "index"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_author
      @author = Author.find(params[:id]) || raise(I18n.t(:not_found))
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def author_params
      params.require(:author).permit(:name, :surname)
    end
end
