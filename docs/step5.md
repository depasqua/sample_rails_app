# Step 5 - Add TDD Testing with RSSpec

1. To get started with using RSpec for our TDD tests, we need to modify our Gemfile. Add First, `rspec-rails` to your
   Gemfile. Note that you may already have a group for both `development` and `test` gems (`group :development, :test`),
   and also have a `development`-only and a `test`-only group.

```text
   group :development, :test do
   gem 'rspec-rails', '~> 6.0'
```

2. Install the gems in the usual way, once you have edited this file.
3. Once that's done, run the rails generator to set up the structure for the RSpec testing (creates directories and
   a few files) by running the following in the terminal or via the IDE.

```bash
rails generate rspec:install
```

4. You should now see that the `.rspec` file was created, the `spec` directory was created, and two helper files
   were also created and placed in the `spec` directory.
5. Let's create our first test, a request test. This is the more widely used type of test these days, apparently. Ru
   the following command in the shell or via the IDE:

```bash
rails generate rspec:request Welcome
```

6. This will generate the file `spec/requests/welcomes_spec.rb`. It looks like this:

```ruby
require 'rails_helper'

RSpec.describe "Welcomes", type: :request do
  describe "GET /welcomes" do
    it "works! (now write some real specs)" do
      get welcomes_path
      expect(response).to have_http_status(200)
    end
  end
end
```

7. Let's unpack this file and point a few things out:
    1. Though we asked for the `Welcome` resource, Rspec uses because RSpec uses pluralized resource names for request
       spec file naming, both the filename and the resource was changed to reflect pluralization (`Welcomes`). Odd, but
       that is ok.
    2. Next notice the `it` block. The string argument to `it` should complete the sentence formed by the `describe`
       and `context` blocks, making the test readable like natural language. So in our case, we would read: "Welcomes
       GET /welcomes works! (now write some real specs)". We can edit out the advice "(now write...)".

8. When we run the tests (and this is the first and only test we have up to this point), we should see a failure:

```text
Failures:

  1) Welcomes GET /welcomes works! (now write some real specs)
     Failure/Error: get welcomes_path
     
     NoMethodError:
       undefined method 'welcomes_path' for #<RSpec::ExampleGroups::Welcomes::GETWelcomes:0x00000001252ec4a0>
     # ./spec/requests/welcomes_spec.rb:6:in 'block (3 levels) in <top (required)>'

Finished in 0.02574 seconds (files took 0.57444 seconds to load)
1 example, 1 failure

Failed examples:

rspec ./spec/requests/welcomes_spec.rb:5 # Welcomes GET /welcomes works! (now write some real specs)
```

Why is it failing on the `get`? There is no `welcomes_path` defined in our route file ([`routes.rb`](config/routes.rb)).
The `welcomes_path` helper is undefined because our route is defined as `root 'welcome#index'`, which only creates the
`root_path`, not `welcomes_path`.

9. If we wanted to really support this, we could add `get '/welcomes', to: 'welcome#index'` to our
   [`config/routes.rb`(config/routes.rb)] file to add a new route. This will also create the helper `welcomes_path`
   which we could then continue to use in our
   test. Try this and verify that the test works correctly.

10. But this is a little odd, since we don't really refer or use the `Welcome` controller. So let's reflect our reality
    and change the RSpec test as follows.
    1. Change the filename of the test to [`requests/root_spec.rb`](requests/root_spec.rb)
    2. Let's also change the outermost `describe` block to better reflect what we are testing (see below), and
    3. also change the `get` command to attempt to test the root page (also see below).
```ruby
RSpec.describe "Root page", type: :request do
  describe "GET /" do
    it "works!" do
      get root_path
      expect(response).to have_http_status(200)
    end
  end
end
```

11. Now we have a functioning test which checks that when we get the root path, we get a response. Nice. But how about a
    test that confirms that we have the correct page? Since the `GET /` request will map to the `welcome#index` page,
    take a look at the [`app/views/welcome/index.html.erb`](app/views/welcome/index.html.erb) template file. In there,
    you will see that it should produce a string of HTML that starts with "This app's name is:" and ends with the name 
    of the application, as set by the `Welcome` controller. Let's add a test case for that in our request spec file.
12. Add the following code inside of the inner `describe` block, thereby adding another `it` block (known as an example,
    a single test case):
```ruby
    it "renders the correct template" do
      get root_path
      # Assuming your app/views/welcome/index.html.erb has "This app's name is" in it
      expect(response.body).to include("This app's name is")
    end
```
13. If you run the tests again, you should now have 2 passing tests, the second of which verifies that the correct
    template was returned by our `get`.

14. Let's make a controller test and test similar things. Create a directory named `controllers` in the `spec` 
    directory. Then, create a [`welcome_controller_spec.rb`](spec/controllers/welcomes_controller_spec.rb) file. The 
    `_spec` part of the file name is required if we want the RSpec runner to locate and use the file. Once you have
    the file, edit the file to add these lines:
```ruby
RSpec.describe WelcomeController, type: :controller do
  describe "GET /" do
    it "works!" do
      get :index
      expect(response).to be_successful  # response's HTTP status code is in the 2xxs
      expect(response).to have_http_status(:ok)  # response's HTTP status code is == 200
    end

    it "renders the index template" do
      get :index
      # This checks that the 'index' action rendered the 'index.html.erb' view
      expect(response).to render_template(:index)
    end
  end
end
```
15. Of course, there are a few things to note in this code:
    1. The outer `describe` block uses the name of the controller we are testing, and the type of test (a controller spc). 
    In doing this, we enable controller-specific features like:
        * Simulating HTTP requests (`get`, `post`, etc.)
        * Accessing `assigns`, `response`, and `request` objects
        * Using controller-specific matchers like `render_template` and `redirect_to`
    1. This test also checks the `response` returned by executing the controller and verifies that the correct template
    was returned in the response (via the `render_template()` function call. The parameter here is a Ruby symbol.)