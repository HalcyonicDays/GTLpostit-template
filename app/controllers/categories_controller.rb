class CategoriesController < ApplicationController

  def show
    @category = Category.find(params[:id])
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    @category.save ? (redirect_to root_path) : (render :new)
  end

  private
  def category_params
    params.require(:category).permit(:name)
  end

end