require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
  end

  test "should get index" do
    @controller.test_current_user = user_details(:one)
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should not get index if not admin" do
    get :index, :format => "json"
    assert_response :unauthorized
  end

=begin
  test "should get index with json request" do
    @request.headers['HTTP_AUTHORIZATION'] = "Basic " + Base64::encode64("admin:password")
    get(:index, { :format => 'json' })
    assert_response :success
  end
=end

  test "should get new" do
    @controller.test_current_user = user_details(:one)
    get :new
    assert_response :success
  end

  test "should create user" do
    @controller.test_current_user = user_details(:one)
    assert_difference('User.count') do
      post :create, user: { email: 'nam@aber.ac.uk',
                            firstname: @user.firstname,
                            grad_year: @user.grad_year,
                            jobs: @user.jobs,
                            phone: @user.phone,
                            surname: @user.surname }
    end

    assert_response :created
  end

  test "should not create user with invalid details" do
    @controller.test_current_user = user_details(:one)
    post :create, user: { email: 'cwl@aber.ac.uk',
                          firstname: @user.firstname,
                          surname: @user.surname,
                          grad_year: @user.grad_year,
                          jobs: @user.jobs,
                          phone: @user.phone }, :format => "json"

    assert_response :unprocessable_entity
  end

  test "should not create user if not admin" do
      post :create, user: { email: 'test@aber.ac.uk',
                            firstname: @user.firstname,
                            grad_year: @user.grad_year,
                            jobs: @user.jobs,
                            phone: @user.phone,
                            surname: @user.surname }, :format => "json"

      assert_response :unauthorized
  end
=begin
  test "should create user with json request and authorization header" do
    @request.headers['HTTP_AUTHORIZATION'] = "Basic " + Base64::encode64("admin:password")
    post :create, user: { email: 'nam@aber.ac.uk',
                          firstname: @user.firstname,
                          grad_year: @user.grad_year,
                          jobs: @user.jobs,
                          phone: @user.phone,
                          surname: @user.surname }, :format => "json"

    assert_response :created
  end
=end

  test "should show user" do
    @controller.test_current_user = user_details(:one)
    get :show, id: @user
    assert_response :success
  end

  test "should not show user if not authorized" do
    get :show, id: @user, :format => "json"
    assert_response :unauthorized
  end

=begin
  test "should show user with http authorization header" do
    @request.headers['HTTP_AUTHORIZATION'] = "Basic " + Base64::encode64("admin:password")
    get :show, id: @user, :format => "json"
    assert_response :success
  end
=end


  test "should get edit" do
    @controller.test_current_user = user_details(:one)
    get :edit, id: @user
    assert_response :success
  end

  test "should update user" do
    @controller.test_current_user = user_details(:one)
    patch :update, id: @user, user: { email: @user.email, firstname: @user.firstname, grad_year: @user.grad_year, jobs: @user.jobs, phone: @user.phone, surname: @user.surname }
    assert_response :ok
  end

  test "should not update user if not admin" do
    patch :update, id: @user, user: { email: @user.email,
                                      firstname: @user.firstname,
                                      grad_year: @user.grad_year,
                                      jobs: @user.jobs,
                                      phone: @user.phone,
                                      surname: @user.surname }, :format => "json"
    assert_response :unauthorized
  end

  test "should no update user with invalid details" do
    @controller.test_current_user = user_details(:one)
    patch :update, id: @user, user: { email: @user.email,
                                      firstname: @user.firstname,
                                      grad_year: '2015',
                                      jobs: @user.jobs,
                                      phone: @user.phone,
                                      surname: @user.surname }, :format => "json"
    assert_response :unprocessable_entity
  end

=begin
  test "should update user with http authorization header" do
    @request.headers['HTTP_AUTHORIZATION'] = "Basic " + Base64::encode64("admin:password")
    patch :update, id: @user, user: { email: @user.email,
                                      firstname: @user.firstname,
                                      grad_year: @user.grad_year,
                                      jobs: @user.jobs,
                                      phone: @user.phone,
                                      surname: @user.surname }, :format => "json"
  end
=end

  test "should destroy user" do
    @controller.test_current_user = user_details(:one)
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end
    assert_response :ok
  end

  test "should not destroy user if not admin" do
    delete :destroy, id: @user, :format => "json"
    assert_response :unauthorized
  end

=begin
  test "should destroy user with http authorization header" do
    @request.headers['HTTP_AUTHORIZATION'] = "Basic " + Base64::encode64("admin:password")
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end
    assert_response :ok
  end
=end
end
