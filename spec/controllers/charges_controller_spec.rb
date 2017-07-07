require 'rails_helper'

RSpec.describe ChargesController, type: :controller do

  describe "GET #cancel" do
    it "returns http success" do
      get :cancel
      expect(response).to have_http_status(:success)
    end
  end

end
