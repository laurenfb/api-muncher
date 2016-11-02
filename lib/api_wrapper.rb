require 'httparty'
require 'uri'

class APIWrapper
  BASE_URL = "https://api.edamam.com/search?"
  APP_ID = ENV["APP_ID"]
  APP_KEY = ENV["APP_KEY"]

  def self.search(query, from = 0, to = 10, id = APP_ID, key = APP_KEY)
    # if there are spaces, pull them out. i know this looks kinda ugly but escape method is annoying for "" and nil.
    if !query.nil?
      query = URI.escape(query)
    end

    url = BASE_URL + "&app_id=#{id}" + "&app_key=#{key}" + "&q=#{query}" + "&from=#{from}" + "&to=#{to}"


    return HTTParty.get(url)
  end

  def self.make_recipe_list(response)
    recipe_list = []
    if response['count']
      response['hits'].each do |hash|
        recipe = Recipe.new(hash)
        recipe_list << recipe
      end
    end
    return recipe_list
  end


end
