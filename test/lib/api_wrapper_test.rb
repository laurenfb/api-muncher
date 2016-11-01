require 'test_helper'
require 'api_wrapper'

class APIWrapperTest < ActionController::TestCase

  test 'the truth' do
    assert true
  end

############# token & permissions stuff #############
  test 'retrieves nil when app id is wrong' do
    VCR.use_cassette("bad-app-id") do
      recipe_list = APIWrapper.search('cat', 'bad-app-id', ENV["APP_KEY"])

      assert_redirect
    end
  end

######## search method #############
  test 'search returns a non-empty array if a reasonable term is searched' do
    VCR.use_cassette('chicken') do
      recipe_list = APIWrapper.search('chicken')
      assert(recipe_list.is_a?(Array))
      assert_not_empty(recipe_list)
    end
  end

  test 'search returns an array of Recipe objects' do
    VCR.use_cassette('chicken') do
      recipe_list = APIWrapper.search('chicken')

      recipe_list.each do |recipe|
        assert(recipe.is_a?(Recipe))
      end
    end
  end

  test 'search returns the correct length of array (this based on an API call to Postman)' do
    VCR.use_cassette('cat') do
      recipe_list = APIWrapper.search('cat')
      assert_equal(recipe_list.length, 172)
    end
  end

  test 'blank search returns array with nothing in it' do
    VCR.use_cassette('nil-search') do
      recipe_list = APIWrapper.search(nil)
      assert_empty(recipe_list)
    end
  end

end
