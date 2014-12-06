require 'test_helper'

class BroadcastsControllerTest < ActionController::TestCase
  setup do
    @broadcast = broadcasts(:one)
    @feed = feeds(:one)
    @current_page

    @feeds_Hash = { "facebook" => true}
  end

  test "should get index" do
    @controller.test_current_user = user_details(:one)
    get :index
    assert_response :success
    assert_not_nil assigns(:broadcasts)
  end

  test "should not get index if not admin" do
    get :index, :format => "json"
    assert_response :unauthorized
  end

=begin
  test "should get index with http authorization header" do
    @request.headers['HTTP_AUTHORIZATION'] = "Basic " + Base64::encode64("admin:password")
    get :index, :format => "json"
    assert_response :success
    assert_not_nil assigns(:broadcasts)
  end
=end

  test "should get new" do
    @controller.test_current_user = user_details(:one)
    get :new
    assert_response :success
  end

  test "should create broadcast" do
    @controller.test_current_user = user_details(:one)
    assert_difference('Broadcast.count') do
      post :create, broadcast: { content: @broadcast.content, user_id: @broadcast.user_id}, feeds: @feeds_Hash
    end

    assert_redirected_to broadcasts_path+ "?page=1"
  end

  test "should not create broadcast if not admin" do
    post :create, broadcast: { content: @broadcast.content, user_id: @broadcast.user_id}, feeds: @feeds_Hash, :format => "json"
    assert_response :unauthorized
  end

=begin
  test "should create broadcast with http authorization header" do
    @request.headers['HTTP_AUTHORIZATION'] = "Basic " + Base64::encode64("admin:password")
    post :create, broadcast: { content: @broadcast.content, user_id: @broadcast.user_id}, feeds: @feeds_Hash, :format => "json"
    assert_response :created
  end
=end

  test "should show broadcast" do
    @controller.test_current_user = user_details(:one)
    get :show, id: @broadcast
    assert_response :success
  end

  test "should not show broadcast if not admin" do
    get :show, id: @broadcast, :format => "json"
    assert_response :unauthorized
  end
=begin

  test "should show broadcast with http authorization header" do
    @request.headers['HTTP_AUTHORIZATION'] = "Basic " + Base64::encode64("admin:password")
    get :show, id: @broadcast, :format => "json"
    assert_response :unauthorized
  end
=end

  test "should destroy broadcast" do
    @controller.test_current_user = user_details(:one)
    assert_difference('Broadcast.count', -1) do
      delete :destroy, id: @broadcast
    end

    assert_redirected_to broadcasts_path
  end

  test "should not destroy broadcast if not admin" do
    delete :destroy, id: @broadcast, :format => "json"
    assert_response :unauthorized
  end

=begin
  test "should destroy broadcast with http authorization header" do
    @request.headers['HTTP_AUTHORIZATION'] = "Basic " + Base64::encode64("admin:password")
    delete :destroy, id: @broadcast, :format => "json"
    assert_response :ok
  end
=end
end
