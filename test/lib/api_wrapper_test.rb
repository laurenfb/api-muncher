require 'test_helper'
require 'api_wrapper'

class APIWrapperTest < ActionController::TestCase

  test 'the truth' do
    assert true
  end

# can't test this since the method can't change constants??
  # test 'search raises argument error if the incorrect key or ID is passed' do
  #   VCR.use_cassette('messed-up-url') do
  #     assert_raises(ArgumentError) do
  #       APP_ID = "ksresdfjsdfk"
  #       APIWrapper.search("cat")
  #     end
  #   end
  # end

  test 'make_recipe_list returns a non-empty array if a reasonable term is searched' do
    # skip
    VCR.use_cassette('chicken') do
      recipe_list = APIWrapper.make_recipe_list(APIWrapper.search('chicken'))
      assert(recipe_list.is_a?(Array))
      assert_not_empty(recipe_list)
    end
  end

  test 'make_recipe_list returns an array of Recipe objects' do
    # skip
    VCR.use_cassette('chicken') do
      recipe_list = APIWrapper.make_recipe_list(APIWrapper.search('chicken'))

      recipe_list.each do |recipe|
        assert(recipe.is_a?(Recipe))
      end
    end
  end

  test 'search returns the correct length of array (this based on an API call to Postman)' do
    # skip
    VCR.use_cassette('cat') do
      response = APIWrapper.search('cat')
      recipe_list = APIWrapper.make_recipe_list(response)
      assert_equal(response['count'], 172)
      assert_equal(recipe_list.length, 10)
    end
  end

  test 'blank search, made to recipes, returns array with nothing in it' do
    # skip
    VCR.use_cassette('nil-search') do
      recipe_list = APIWrapper.make_recipe_list(APIWrapper.search(nil))
      assert_empty(recipe_list)
    end
  end

  test 'when counts are added, the length of the full list of hits does not change' do
    VCR.use_cassette('lots-of-results') do
      first_page = APIWrapper.search('cat')
      second_page = APIWrapper.search('cat', 11, 20)
      assert_equal(first_page['count'], second_page['count'], 172)
    end
  end

  test 'when counts are added, the results returned are not the same as when the counts are not added' do
    VCR.use_cassette('more-results') do
      first_page = APIWrapper.make_recipe_list( APIWrapper.search('cat'))
      second_page = APIWrapper.make_recipe_list(APIWrapper.search('cat', 11, 20))
      first_page.each do |recipe1|
        second_page.each do |recipe2|
          assert_not_equal(recipe1, recipe2)
        end
      end
    end
  end

########## test find_single_recipe #######
  test 'find_single_recipe finds only one recipe' do
    VCR.use_cassette('single-recipe') do
      id = 'http://www.edamam.com/ontologies/edamam.owl%23recipe_6ae9c0dbe45417f7983e2b93493f1172'
      response = APIWrapper.find_single_recipe(id)
      assert_not_empty(response)
      assert_equal(response.length, 1)
    end
  end

  test 'find_single recipe returns nil if recipe id is incorrect' do
    VCR.use_cassette('weird-id-single-recipe') do
      assert_raises(JSON::ParserError) do
        id = 'cat'
        response = APIWrapper.find_single_recipe(id)
        assert_equal(response, :no_result)
      end
    end
  end

# per Jamie's advice, it is not currently necessary to test this stuff. and so it is getting commented out.
  # test 'returns false when app id is wrong' do
  #   # skip
  #   VCR.use_cassette("bad-app-id") do
  #     response = APIWrapper.search('cat', '232354353', ENV["APP_KEY"])
  #     assert_not(response)
  #     assert_equal(response, false)
  #   end
  # end
  #
  # test 'returns false app key is wrong' do
  #   # skip
  #   VCR.use_cassette("bad-app-key") do
  #     response = APIWrapper.search('cat', ENV["APP_ID"], 'bad-app-key')
  #     assert_not(response)
  #     assert_equal(response, false)
  #   end
  # end
  #
  # test 'works fine when app key is missing' do
  #   # skip
  #   VCR.use_cassette("missing-app-key") do
  #     response = APIWrapper.search('cat', 0, 10, ENV["APP_ID"], nil)
  #     assert(response) # checking it didn't return false
  #     assert_instance_of(HTTParty::Response)
  #   end
  # end
  #
  # test 'works fine when app id is missing' do
  #   # skip
  #   VCR.use_cassette("missing-app-id") do
  #     response = APIWrapper.search('cat', 0, 10, nil, ENV["APP_KEY"])
  #     assert(response) # checking it didn't return false
  #     assert_instance_of(HTTParty::Response)
  #   end
  # end
  #
  # test 'works fine when app id & app key are missing' do
  #   # skip
  #   VCR.use_cassette("missing-app-stuff") do
  #     response = APIWrapper.search('cat', 0, 10, nil, nil)
  #     assert(response) # checking it didn't return false
  #     assert_instance_of(HTTParty::Response)
  #   end
  # end


end
