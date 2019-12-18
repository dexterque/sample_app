require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      # ActionController::UrlGenerationError: No route matches {:action=>"show", :controller=>"users"}, missing required keys: [:id]
      # post的url 写成user_path了
      post users_path, params: { user: { name: "", email: "user@valid", password: "foo", password_confirmation: "bar" } }
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.alert'
    assert_select 'div.alert-danger'
  end

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name: "Example User", email: "user@example.com", password: 'password', password_confirmation: "password" } }
    end
    # 重定向
    follow_redirect!
    assert_template 'users/show'
    assert_not flash.empty?
  end
end
