class HomepagesController < ApplicationController

  def search
  end

  def index
    response = APIWrapper.search(params[:query])
    if response
      @recipes = APIWrapper.make_recipe_list(response)
    else
      return "nah"
    end
  end

  def show
  end
end
