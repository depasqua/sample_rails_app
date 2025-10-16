# Step 1 - Initial Creation

Use the `rails new sample_rails_app` to create a new Rails app with the name *sample_rail_app*. This will create 
a directory with the same name and place a number of application related directories and files in it.

Examine the file and directories we just created. The ones of most importance are:
* `app/` (directory) - location for many application files of interest including where the models, controllers, and views will be placed. Within the `app/` directory, look for the following:
  * `controllers` (directory) - resource controller files (`recipe_controller.rb`) will be located here
  * `models` (directory) - model class files (`Recipe.rb`) will be located here
  * `views` (directory) - view files (`something.html.erb`) will be located here
* `config/` (directory) - location for configuration related files, including the ever important (`config/routes.rb`) file

Once these files are created, you test the basic setup by starting the server (`rails server`) from the command line. Be 
sure you are in the top-level project directory (in this case, `sample_rails_app`) when you run the comment. You should 
see a number of lines of output on the console like:
```text
=> Booting Puma
=> Rails 8.0.3 application starting in development 
=> Run `bin/rails server --help` for more startup options
Puma starting in single mode...
* Puma version: 7.0.4 ("Romantic Warrior")
* Ruby version: ruby 3.4.7 (2025-10-08 revision 7a5688e2a2) +YJIT +PRISM [arm64-darwin25]
*  Min threads: 3
*  Max threads: 3
*  Environment: development
*          PID: 35791
* Listening on http://127.0.0.1:3000
  Use Ctrl-C to stop
```

Once we see this, we can use a web browser to visit the specified URL: [http://127.0.0.1:3000](http://127.0.0.1:3000). We
can also visit [http://localhost:3000](http://localhost:3000). They both refer to the local machine you are running the 
server on.