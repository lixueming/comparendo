require 'test_helper'

class AutocompleteControllerTest < ActionController::TestCase
  test "should get company_and_article" do
    get :company_and_article
    assert_response :success
  end

end
