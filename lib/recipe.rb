require 'uri'

class Recipe
  attr_reader :id, :label, :image, :url, :yield, :diet_labels, :health_labels, :ingredient_list, :source

  def initialize(params)
    if params.empty? # hits array & uri arry will be empty, whether the parameter is from the recipe query or a URI lookup
      raise ArgumentError
    elsif params.is_a?(Hash) # this is if the data coming in is from a recipe query.
      if params['recipe']['label'] == nil || params['recipe']['label'] == ""
        raise ArgumentError
      else
        @id = URI.encode(params['recipe']['uri'].to_s)
        @label = params['recipe']['label'].to_s
        @image = params['recipe']['image']
      end
    else  # this is if the data is coming in from a URI lookup
      @id = URI.encode(params[0]['uri'].to_s)
      @label = params[0]['label'].to_s
      @image = params[0]['image']
      @source = params[0]['source']
      @url = params[0]['url']
      @yield = params[0]['yield']
      @diet_labels = params[0]['dietLabels']
      @health_labels = params[0]['healthLabels']
      @ingredient_list = params[0]['ingredientLines']

    end


  end

end
