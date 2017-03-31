class IngredientsController < ApplicationController
  before_action :set_ingredient, only: [:show, :edit, :update]

  def index
    @ingredients = Ingredient.paginate(page: params[:page], per_page: 5)
  end

  def new
    #code
  end

  def show
    @ingredient_recipe = @ingredient.recipes.paginate(page: params[:page], per_page: 5)
  end

  def edit
    #code
  end

  def update
    #code
  end

  private

    def set_ingredient
      @ingredient = Ingredient.find(params[:id])
    end
end
