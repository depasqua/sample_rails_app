Given('recipe {string}-{string} exists') do |string, string2|
  @recipe = Recipe.create!(name: string, description: string2)
end

When('I visit the list of recipes') do
  visit recipes_path
end

Then('{string} should appear') do |recipe_name_string|
  regex = /#{recipe_name_string}/m
  expect(page.text).to match(regex)
end

Then('I Follow the {string} link') do |string|
  click_link(id: "show-#{@recipe.id}")
end

