class CategoriesController < ApplicationController
  before_action :require_user, except: [:show]
  before_action :require_admin, except: [:show]

  def show
    @category = Category.find_by_slug(params[:id])
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