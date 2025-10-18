# Step 2 - Created Welcome (landing) page

1. Create a `Welcome` controller in the app so that we can include the `index` method in the
   controller. We do this via the IDE interface or the command line:

```text
rails generate controller Welcome
```

2. Edit the controller file ([`controllers/welcome/welcome_controller.rb`](app/controllers/welcome_controller.rb))
(it should exist!) and add the following `index` method. Note that we are defining an instance variable on the
controller object which will be passed to the view.

```ruby

def index
  @app_name = "Sample Rails Application"
end
```

3. Create the welcome view ([`views/welcome/index.html.erb`](app/views/welcome/index.html.erb)) file (if it does not
   exist) and add the
   following. Note that the instance variable defined in the `index` method in the controller was passed
   to the view and used in the resulting output page (HTML).

```rails
<h1>Welcome to the Rails App!</h1>
<h2>This app's name is: <%= @app_name %></h2>
```

4. Create a new route for the root of the application (`/`) to the index method of the Welcome
   controller by adding the following to the routes file ([`config/routes.rb`](config/routes.rb)):

```text
  root "welcome#index"
```