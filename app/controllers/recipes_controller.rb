class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_chef!, except: [:index, :show]
  before_action :authenticate_same_chef, only: [:edit, :update, :destroy]

  # GET /recipes
  # GET /recipes.json
  def index
    @recipes = Recipe.paginate(page: params[:page], per_page: 5)
  end

  # GET /recipes/1
  # GET /recipes/1.json
  def show
    @comment = Comment.new
    @comments = @recipe.comments.paginate(page: params[:page], per_page: 5)
  end

  # GET /recipes/new
  def new
    @recipe = current_chef.recipes.build
  end

  # GET /recipes/1/edit
  def edit
  end

  # POST /recipes
  # POST /recipes.json
  def create
    @recipe = current_chef.recipes.build(recipe_params)


    if @recipe.save
      flash[:success] = "Recipe was created successfuly!"
      redirect_to recipe_path(@recipe)
    else
      render :new
    end
  end

  # PATCH/PUT /recipes/1
  # PATCH/PUT /recipes/1.json
  def update

      if @recipe.update(recipe_params)
        flash[:success] = "Recipe was updated successfuly!"
        redirect_to @recipe
      else
        render :edit
      end

  end

  # DELETE /recipes/1
  # DELETE /recipes/1.json
  def destroy
    @recipe.destroy
    respond_to do |format|
      format.html { redirect_to recipes_url, notice: 'Recipe was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recipe_params
      params.require(:recipe).permit(:name, :description, :chef_id, ingredient_ids: [])
    end

    def authenticate_same_chef
      if chef_signed_in? && (current_chef != @recipe.chef && !current_chef.admin?)
        flash[:danger] = "You can only edit or delete your own recipes"
        redirect_to recipes_path
      end
    end
end
