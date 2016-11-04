require 'uri'

class Recipe
  attr_reader :id, :label, :image, :url, :yield, :diet_labels, :health_labels, :ingredient_list, :source

  def initialize(params)
    if params.empty? || params['label'] == nil || params['label'] == ""
      raise ArgumentError.new("Recipe must have a name")
    else
      @id = URI.encode(params['uri'].to_s)
      @label = params['label'].to_s
      @image = params['image']
      @source = params['source']
      @url = params['url']
      @yield = params['yield'].to_i
      @diet_labels = params['dietLabels']
      @health_labels = params['healthLabels']
      @ingredient_list = params['ingredientLines']
    end
  end

end
