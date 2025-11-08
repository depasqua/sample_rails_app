# Step 6 - Add a counter method to the Recipe controller

1. I wanted to add an endpoint to explore a few minor concepts. First I added a `count` method to the 
`Recipe` controller as follows:
```ruby
  def count
    @recipe_count = Recipe.count
    # render plain: @recipe_count
    # render json: ["count" => @recipe_count]
  end
```
2. Note that the above code contains commented lines that will modify the controller's response. Without
the commented lines (as the code is shown), the controller will return an HTML view file 
[`apps/views/recipes/count.html.erb`](app/views/recipes/count.html.erb), which is added next. If we 
uncomment one of the render lines, the controller will respond by returning either plain text or JSON, 
whichever is selected. Of course, if we leave the controller's method as shown above, then we'll need the
`count.html.erb` file:
```rails
<h1>Recipes#count</h1>
<h1>Counting recipes</h1>

Number of recipes: <%= @recipe_count %>
```
5. The fun part here, well, not so much, is that we need to be careful how this new route is put into play.
I added a `get count` line to the [`routes.rb`](config/routes.rb) file. Placement matters here, since I added it in
locations where it was overridden by the `resources :recipes` statement (which makes the necessary
routes for the named resource). Thus, when I used a browser and went to
`http://127.0.0.1:3000/recipes/count`, it resulted in an error page. Essentially, it was defaulting to
the `recipe/show` route, and using `count` as if it were the `:id` value that the `show` route was
expecting.  So to clean this up, I nested the `get count` route on the collection of all recipes, and
nested that inside of the `resources` line:
```rails
resources :recipes do
    # Ensure the "count" route is set up first
    collection do
      get "count" # By using collection, Rails knows /recipes/count is an action
      # on the collection of recipes, not a request for a recipe with the ID
      # "count," and thus handles it correctly before moving on to the
      # dynamic :id routes.
    end
  end
 ```
6. Finally, I decided to clean up failing recipe helpers used in the RSpec tests, by correcting them
from `recipes_new_url` and `recipes_index_url` to `new_recipe_url` and `index_recipe_url` respectively.