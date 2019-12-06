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
end
