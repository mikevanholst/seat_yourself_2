class CategoriesController < ApplicationController

  def new
    @catetory = Category.new
  end

  def create
    @category = Category.new(category_params)
    @category.save
    redirect_to @restaurant, :notice => "Category added!"
  end


  private

  def category_params
    params.require(:category).permit(:content)
    
  end

end
