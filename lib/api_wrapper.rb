require 'httparty'
require 'uri'

class APIWrapper
  BASE_URL = "https://api.edamam.com/search?"
  APP_ID = ENV["APP_ID"]
  APP_KEY = ENV["APP_KEY"]

  def self.search(query, from = 0, to = 10)
    # if there are spaces, pull them out. i know this looks kinda ugly but escape method is annoying for "" and nil.
    if !query.nil?
      query = URI.escape(query)
    end

    url = BASE_URL + "&app_id=#{APP_ID}" + "&app_key=#{APP_KEY}" + "&q=#{query}" + "&from=#{from}" + "&to=#{to}"

    response = HTTParty.get(url)
    response.code == 200 ? response : ArgumentError.new("Please use the correct ID and Key. ")
  end

  def self.make_recipe_list(response)
    recipe_list = []
    if response['count']
      response['hits'].each do |hash|
        recipe = Recipe.new(hash['recipe'])
        recipe_list << recipe
      end
    end
    return recipe_list
  end

  def self.find_single_recipe(id)
    url = BASE_URL + "&app_id=#{APP_ID}" + "&app_key=#{APP_KEY}" + "&r=#{id}"
    response = HTTParty.get(url)
  end
end
