require 'test_helper'
require 'recipe'

class RecipeTest < ActionController::TestCase

  def setup
    @params = {
        'label' => "Edith's Magical Cat Food Recipe",
        'image' => 'https://pbs.twimg.com/media/CaQOI3gUYAEN9iV.jpg',
        'url' => 'https://laurenfb.github.io/',
        'yield' => 1,
        'dietLabels' => ["Not Human Food"],
        'healthLabels' => ["Gluten-Free"],
        'ingredientLines' => [
          '1/2 can Natural Balance Salmon & Green Pea dry cat food',
          '2/3 scoop Natural Balance Chicken & Green Pea wet cat food'],
        'source' => 'your mom'}
  end

  test 'the truth' do
    assert true
  end

  test 'new method creates a new Recipe object' do
    recipe = Recipe.new(@params)
    assert(recipe.is_a?(Recipe))
  end

  test 'new recipe has a title, called a label' do
    recipe = Recipe.new(@params)
    assert_not_nil(recipe.label)
    assert_equal(recipe.label, "Edith's Magical Cat Food Recipe")
  end

  test 'new recipe has an image' do
    recipe = Recipe.new(@params)
    assert_not_nil(recipe.image)
    assert_equal(recipe.image, 'https://pbs.twimg.com/media/CaQOI3gUYAEN9iV.jpg')
  end

  test 'new recipe has a url' do
    recipe = Recipe.new(@params)
    assert_not_nil(recipe.url)
    assert_equal(recipe.url, 'https://laurenfb.github.io/')
  end

  test 'new recipe has a yield' do
    recipe = Recipe.new(@params)
    assert_not_nil(recipe.yield)
    assert_equal(recipe.yield, 1)
  end

  test 'new recipe has a source' do
    recipe = Recipe.new(@params)
    assert_not_nil(recipe.source)
    assert_equal(recipe.source, 'your mom')
  end

  test 'new recipe has a diet_labels' do
    recipe = Recipe.new(@params)
    assert_not_nil(recipe.diet_labels)
    assert(recipe.diet_labels.is_a?(Array))
    assert_not_empty(recipe.diet_labels)
  end

  test 'new recipe has a health labels' do
    recipe = Recipe.new(@params)
    assert_not_nil(recipe.health_labels)
    assert(recipe.health_labels.is_a?(Array))
    assert_not_empty(recipe.health_labels)
  end

  test 'new recipe has an ingredient list' do
    recipe = Recipe.new(@params)
    assert_not_nil(recipe.ingredient_list)
    assert(recipe.ingredient_list.is_a?(Array))
    assert_not_empty(recipe.ingredient_list)
  end

  test 'recipe can be created without all the stuff, as long as there is a label' do
  recipe = Recipe.new({'label' => "new recipe"})
    assert_equal(recipe.label, "new recipe")
    assert_nil(recipe.image)
    assert_nil(recipe.url)
    assert_equal(recipe.yield, 0) # this is because i added .to_i
    assert_nil(recipe.diet_labels)
    assert_nil(recipe.health_labels)
    assert_nil(recipe.ingredient_list)
  end

  test 'if you try to create a recipe with a title that is not a string it will convert that title to a string' do
    recipe = Recipe.new({'label' => :new_recipe})
    assert_equal(recipe.label, "new_recipe")

    recipe = Recipe.new({'label' => [34, 54, 46, "cat"]})
    assert_equal(recipe.label, "[34, 54, 46, \"cat\"]")

    recipe = Recipe.new({'label' => 45923034935})
    assert_equal(recipe.label, "45923034935")

  end

  test 'cannot create a new recipe wihout a title/label' do
    assert_raises(ArgumentError) do
      recipe = Recipe.new
    end

    assert_raises(ArgumentError) do
      recipe = Recipe.new({'label' => ""})
    end

    assert_raises(ArgumentError) do
      recipe = Recipe.new({'label' => nil})
    end
  end

end
