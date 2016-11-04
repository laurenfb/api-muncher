class HomepagesController < ApplicationController

  def search
  end

  def index
    if params[:next]
      params[:from] = params[:next].to_i + 10
      params[:to] = params[:next].to_i + 20
      response = APIWrapper.search(params[:query], params[:from], params[:to])
    elsif params[:back]
      params[:from] = params[:back].to_i - 10
      params[:to] = params[:back].to_i
      response = APIWrapper.search(params[:query], params[:from], params[:to])
    else
      response = APIWrapper.search(params[:query])
    end

    if response['count'] > 0
      @recipes = APIWrapper.make_recipe_list(response)
      @message = "Here's your results for #{params[:query]}:"
    else
      @recipes = []
      @message = "We weren't able to find any recipes for #{params[:query]}. Care to try again?"
    end
  end

  def show
    response = APIWrapper.find_single_recipe(params[:id])
    @recipe = Recipe.new(response[0])
  rescue JSON::ParserError
    flash[:notice] = ":("
    redirect_to root_path
  end
end
