class IngredientsController < ApplicationController
  before_action :set_ingredient, only: [:show, :edit, :update]
  before_action :required_admin, except: [:show, :index]

  def index
    @ingredients = Ingredient.paginate(page: params[:page], per_page: 5)
  end

  def new
    @ingredient = Ingredient.new
  end

  def create
    @ingredient = Ingredient.new(ingredients_params)
    if @ingredient.save
      flash[:success] = "Ingredient was created successfully"
      redirect_to @ingredient
    else
      render :new
    end
  end

  def show
    @ingredient_recipe = @ingredient.recipes.paginate(page: params[:page], per_page: 5)
  end

  def edit
    #code
  end

  def update
    if @ingredient.update(ingredients_params)
      flash[:success] = "Ingredient name was update successfully"
      redirect_to @ingredient
    else
      render :edit
    end
  end

  private

  def set_ingredient
      @ingredient = Ingredient.find(params[:id])
  end

  def ingredients_params
      params.require(:ingredient).permit(:name)
  end

  def required_admin
    if !chef_signed_in? || (chef_signed_in? && !current_chef.admin?)
      flash[:danger] = "Only admin users can perform that action"
      redirect_to root_path
    end
  end
end
