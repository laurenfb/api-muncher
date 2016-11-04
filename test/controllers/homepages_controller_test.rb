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

  test 'controller should have from & to params if you\'re on the first page of results' do
    VCR.use_cassette('index-with-params') do
      get :index, {query: 'cat', next: 0}
      assert_includes(@controller.params, 'from')
      assert_includes(@controller.params, 'to')
      assert_equal(@controller.params['from'], 10)
      assert_equal(@controller.params['to'], 20)
    end
  end

  test 'controller should have back param if you are not on the first page of results' do
    VCR.use_cassette('index-with-params') do
      get :index, {query: 'cat', back: 10}
      assert_includes(@controller.params, 'from')
      assert_includes(@controller.params, 'to')
      assert_equal(@controller.params['from'], 0)
      assert_equal(@controller.params['to'], 10)
    end
  end

  test 'from and to params should increment when you go to the next page' do
      VCR.use_cassette('index-with-params') do
        get :index, {query: 'blue fish', next: 0}
        assert_equal(@controller.params['from'], 10)
        assert_equal(@controller.params['to'], 20)
          VCR.use_cassette('now-go-to-next-page') do
            get :index, {query: 'blue fish', next: 10}
            assert_equal(@controller.params['from'], 20)
            assert_equal(@controller.params['to'], 30)
          end
      end
  end

  test 'from and to params should decrement when you go back to the previous page' do
      VCR.use_cassette('index-with-params') do
        get :index, {query: 'blue fish', back: 40}
        assert_equal(@controller.params['from'], 30)
        assert_equal(@controller.params['to'], 40)
          VCR.use_cassette('now-go-back') do
            get :index, {query: 'blue fish', back: 30}
            assert_equal(@controller.params['from'], 20)
            assert_equal(@controller.params['to'], 30)
          end
      end
  end
end
