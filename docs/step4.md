# Step 4 - Add BDD Testing with Cucumber and Capybara

1. Add the following gems to the `Gemfile` in the `test` section and then ensure the gems are loaded and `Gemfile.lock` 
is updated with the new gems.
```text
  gem "cucumber-rails"
  gem "rspec-rails"
  gem "cucumber-rails-training-wheels"
```
2. Use the terminal to ensure that `cucumber` is correctly installed:
```shell
cucumber --version
```
3. Initialize the cucumber directories from the top level project directory (`sample_rails_app\`):
```shell
 cucumber --init
```
4. Create a feature and scenario to test. To do this, create a `welcome_page.feature` file in the `features`
directory and add the following to it:
```text
Feature:
   As a user
   So that I can select a recipe
   I want the recipe list to be displayed
   And I can view the recipe details

Scenario:
    Given recipe "Tacos"-"A tasty dinner!" exists
    When I visit the list of recipes
    Then "Tacos" should appear
    And "A tasty dinner" should appear
```
5. Run `cucumber` on these tests.  They will fail, since there are no defined steps to complete them, but we will know
that `cucmber` is working and reading these files. Note that the 1 scenario and 4 steps are not defined, so the 
output indicates as such and provides a template of snippets to use to build the step definitions.
```text
1 scenario (1 undefined)
4 steps (4 undefined)
0m0.033s

You can implement step definitions for undefined steps with these snippets:
```
```ruby
Given('recipe {string}-{string} exists') do |string, string2|
  pending # Write code here that turns the phrase above into concrete actions
end

When('I visit the list of recipes') do
  pending # Write code here that turns the phrase above into concrete actions
end

Then('{string} should appear') do |string|
  pending # Write code here that turns the phrase above into concrete actions
end
```
6. Add create a `welcome_steps.rb` file in the `features/step_definitions` directory and add the step templates. Then
rerun `cucumber` to see the updated test results. With each step calling the pending method, the first will be listed
as pending and the remaining 3 steps will be skipped since they execute in the scenario in order.
```text
1 scenario (1 pending)
4 steps (3 skipped, 1 pending)
0m0.027s
```
7. Let's implement only the first scenario and get it pass. The others will be left at pending for now. Change
the `Given` step to be:
```ruby
Given('recipe {string}-{string} exists') do |string, string2|
  @recipe = Recipe.create!(name: string, description: string2)
end
```
8. The above should fail, not able to identify the Recipe class. Add the following to the `features/support/env.rb`
file. (You may need to create this file.)
```ruby
require 'cucumber/rails'
```
9. Rerun `cucumber` and you should see the following. Note that our step is marked as passed, and there are 
now 2 steps skipped and one pending (the next one: "When I visit...")
```text
1 scenario (1 pending)
4 steps (2 skipped, 1 pending, 1 passed)
```
10. Let's edit the two remaining steps ("When I visit..." and "<something> should appear"):
```ruby
When('I visit the list of recipes') do
  visit recipes_path
end

Then('{string} should appear') do |recipe_name_string|
  regex = /#{recipe_name_string}/m
  expect(page.text).to match(regex)
end
```
11. Now when we rerun `cucumber`, all of our steps should pass.
```text
<show passing tests here>
```
12. Let's add another scenario to the features file (features/welcome_page.features). Add the following to the end
of the file, below the prior scenario. Note that we are reusing steps we previously wrote but are adding one new
one: `Then I Follow the "Show" Link`
```text
  Scenario:
    Given recipe "Cacio e Pepe"-"Cacio e pepe is a traditional Italian pasta dish originating from the Lazio region, known for its simple yet flavorful combination of pecorino romano cheese, black pepper, and spaghetti or tonnarelli." exists
    When I visit the list of recipes
    Then "Cacio e Pepe" should appear
    Then I Follow the "Show" link
    Then "Cacio e pepe" should appear
```
13. We need to ensure that the "Show" link on the recipe index page is not only present, but is uniquely
identifiable. Why? So that when we run our scenario, we can enable it to select the correct link to "click" on
to move from the index page, to the show page which displays the information about a given recipe. To do this, 
let's first add anHTML `id` attribute on each link that contains the id value of the recipe when providing the
link on the index page. Change the link in the `index.html.erb` view file to be:
```html
      <td><%= link_to 'Show', recipe_path(recipe), id: "show-#{recipe.id}" %></td>
```
14. Start the server and load the index page. Check the presence (and correctness) of the link by using your
browser's developer tools (Inspect the HTML element!). Any "show" links should now each be uniquely id'd with 
the recipe id value (from the model/database).
15. Now we can modify our step code to allow our test to select the correct link. Add the following code to the 
steps file. This will support clicking a link, but only the link with the specific id value (the recipe we are
using for our test).
```text
Then('I Follow the {string} link') do |string|
    click_link(id: "show-#{@recipe.id}")
    end
```
16. Run the `cucumber` tests again. They should pass. But now note that you are testing two scenarios for the
specified feature. Also, one of the scenarios introduces clicking on a link that we expect to be rendered in 
our `show` view.
17. Finally, note the difference in the two scenarios. Only one was specific to the view returned by a particular
action in the app (clicking the `show` link). We needed that link present on the index page to be able to test it
in this fashion. Of course, we could have considered calling the show page differently and not clicking on the 
link. How would that change our steps?
