require 'test_helper'

class HomepagesControllerTest < ActionController::TestCase
  test "should get index" do
    VCR.use_cassette('get-index') do
       get :index
      assert_response :success
    end
  end

  test 'can search from index' do
    VCR.use_cassette('search-index') do
      get :index, params: {query: 'cat'}
      assert_response :success
    end
  end

  test "should get search" do
    get :search
    assert_response :success
  end

  test "should get show" do
    VCR.use_cassette('get-show') do
      get :show, {label: "cat", id: 'http://www.edamam.com/ontologies/edamam.owl%23recipe_6ae9c0dbe45417f7983e2b93493f1172'}
      assert_response :success
    end
  end

  test 'if show is passed a bad id, redirected  + flash notice' do
    VCR.use_cassette('get-show-bad-id') do
      get :show, {label: "dog", id: 'cat'}
      assert_redirected_to(root_path)
      assert_equal(flash[:notice], ":(")
    end
  end

end
