require "rails_helper"

RSpec.describe WelcomeController, type: :controller do
  describe "GET /index" do
    it "works! (now write some real specs)" do
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
