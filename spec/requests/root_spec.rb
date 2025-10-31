require 'rails_helper'

RSpec.describe "Root page", type: :request do
  describe "GET /" do
    it "works!" do
      get root_path
      expect(response).to have_http_status(200)
    end

    it "renders the correct template" do
      get root_path

      # Assuming your app/views/welcome/index.html.erb has "This app's name is" in it
      expect(response.body).to include("This app's name is")
    end
  end
end
