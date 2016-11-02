class Recipe
  attr_reader :label, :image, :url, :yield, :diet_labels, :health_labels, :ingredient_list

  def initialize(params)
    if params.empty? || params['recipe']['label'] == nil || params['recipe']['label'] == ""
      raise ArgumentError
    end

    @label = params['recipe']['label'].to_s
    @image = params['recipe']['image']
    @url = params['recipe']['url']
    @yield = params['recipe']['yield']
    @diet_labels = params['recipe']['dietLabels']
    @health_labels = params['recipe']['healthLabels']
    @ingredient_list = params['recipe']['ingredientLines']
  end

end
