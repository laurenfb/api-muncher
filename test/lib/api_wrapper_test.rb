require 'test_helper'
require 'api_wrapper'

class APIWrapperTest < ActionController::TestCase

  test 'the truth' do
    assert true
  end

############# token & permissions stuff #############
  test 'returns an html page when app id is wrong' do
    skip
    VCR.use_cassette("bad-app-id") do
      recipe_list = APIWrapper.search('cat', 'bad-app-id', ENV["APP_KEY"])

      assert_equal(recipe_list['headers']['Content-Type'], "text/html")
    end
  end

  test 'returns an html page when app key is wrong' do
    skip
    VCR.use_cassette("bad-app-key") do
      recipe_list = APIWrapper.search('cat', ENV["APP_ID"], 'bad-app-key')

      assert_equal(recipe_list['headers']['Content-Type'], "text/html")
    end
  end

  test 'works fine when app key is missing' do
    skip
    VCR.use_cassette("missing-app-key") do
      recipe_list = APIWrapper.search('cat', ENV["APP_ID"], nil)

      assert_not_empty(recipe_list)
    end
  end

  test 'works fine when app id is missing' do
    skip
    VCR.use_cassette("missing-app-id") do
      recipe_list = APIWrapper.search('cat', nil, ENV["APP_KEY"])

      assert_not_empty(recipe_list)
    end
  end

  test 'works fine when app id & app key are missing' do
    skip
    VCR.use_cassette("missing-app-stuff") do
      recipe_list = APIWrapper.search('cat', nil, nil)

      assert_not_empty(recipe_list)
    end
  end

######## search method #############
  test 'search returns a non-empty array if a reasonable term is searched' do
    skip
    VCR.use_cassette('chicken') do
      recipe_list = APIWrapper.search('chicken')
      assert(recipe_list.is_a?(Array))
      assert_not_empty(recipe_list)
    end
  end

  test 'search returns an array of Recipe objects' do
    skip
    VCR.use_cassette('chicken') do
      recipe_list = APIWrapper.search('chicken')

      recipe_list.each do |recipe|
        assert(recipe.is_a?(Recipe))
      end
    end
  end

  test 'search returns the correct length of array (this based on an API call to Postman)' do
    skip
    VCR.use_cassette('cat') do
      recipe_list = APIWrapper.search('cat')
      assert_equal(recipe_list.length, 172)
    end
  end

  test 'blank search returns array with nothing in it' do
    skip
    VCR.use_cassette('nil-search') do
      recipe_list = APIWrapper.search(nil)
      assert_empty(recipe_list)
    end
  end

end
