class IngredientsController < ApplicationController

  def index
    @ingredients = Ingredient.paginate(page: params[:page], per_page: 5)
  end

  def new
    #code
  end

  def show
    #code
  end

  def edit
    #code
  end

  def update
    #code
  end
end
