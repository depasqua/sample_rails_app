class RecipesController < ApplicationController
  def new
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def index
    @recipes = Recipe.all
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.save
    redirect_to @recipe
  end

  def count
    @recipe_count = Recipe.count
    # render plain: @recipe_count
    # render json: ["count" => @recipe_count]
  end

  private
  def recipe_params
    @recipe = params.require(:recipe).permit(:name, :description)
  end
end
