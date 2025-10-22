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

  Scenario:
    Given recipe "Cacio e Pepe"-"Cacio e pepe is a traditional Italian pasta dish originating from the Lazio region, known for its simple yet flavorful combination of pecorino romano cheese, black pepper, and spaghetti or tonnarelli." exists
    When I visit the list of recipes
    Then "Cacio e Pepe" should appear
    Then I Follow the "Show" link
    Then "Cacio e pepe is a traditional Italian pasta dish" should appear
