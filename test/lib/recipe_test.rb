require 'test_helper'
require 'recipe'

class RecipeTest < ActionController::TestCase

  def setup
    @params = {
      'recipe': {
        'label': "Edith's Magical Cat Food Recipe",
        'image': 'https://pbs.twimg.com/media/CaQOI3gUYAEN9iV.jpg',
        'url': 'https://laurenfb.github.io/',
        'yield': 1,
        'dietLabels': [],
        'healthLabels': [],
        'ingredientLines': [
          '1/2 can Natural Balance Salmon & Green Pea dry cat food',
          '2/3 scoop Natural Balance Chicken $ Green Pea wet cat food']
      }
    }
  end

  test 'the truth' do
    assert true
  end

  test 'new method creates a new Recipe object' do
    recipe = Recipe.new(@params)
    assert(recipe.is_a?(Recipe))
  end

  test 'new recipe has a title' do
    recipe = Recipe.new(@params)
    assert_not_nil(recipe.title)
    assert_equal(recipe.title, "Edith's Magical Cat Food Recipe")
  end

  test 'new recipe has an image' do
    recipe = Recipe.new(@params)
    assert_not_nil(recipe.image)
    assert_equal(recipe.image, 'https://pbs.twimg.com/media/CaQOI3gUYAEN9iV.jpg')
  end


end
