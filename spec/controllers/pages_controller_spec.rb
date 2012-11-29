require 'spec_helper'

describe PagesController do
  describe "Get :home " do
    it "renders the home template" do
      get :home
      expect(response).to render_template :home
    end
  end
end
