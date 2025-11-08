require "test_helper"

class RecipesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @recipe = recipes(:one) # or create one
  end

  test "should get new" do
    get new_recipe_url
    assert_response :success
  end

  test "should get show" do
    get recipe_url(@recipe)
    assert_response :success
  end

  test "should get index" do
    get recipes_url
    assert_response :success
  end
end
