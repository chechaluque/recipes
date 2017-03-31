class PagesController < ApplicationController
  before_action :chef_params, only: [:show, :destroy]
  before_action :authenticate_same_chef, only: [:edit, :update, :destro]
  before_action :required_admin, only: [:destroy]

  def home
    redirect_to recipes_path if chef_signed_in?
  end
  def index
    @chefs = Chef.paginate(page: params[:page], per_page: 5)
  end

  def show
    @chef = Chef.find(params[:id])
    @chef_recipes = @chef.recipes.paginate(page: params[:page], per_page: 5)
  end
  def edit
    #code
  end

  def destroy
    if !@chef.admin?
      @chef.destroy
      flash[:danger]= "Chef and all associated recipes have been deleted!"
      redirect_to pages_path()
    end
  end

  private
    def chef_params
      @chef = Chef.find(params[:id])
    end

    def authenticate_same_chef
      if current_chef != @chef and !current_chef.admin?
        flash[:danger] = "You can only edit or delete your own account"
        redirect_to pages_path
      end
    end

    def required_admin
      if chef_signed_in? && !current_chef.admin?
        flash[:danger] = "Only admin users can perfon that action"
        redirect_to root_path
      end
    end
end
