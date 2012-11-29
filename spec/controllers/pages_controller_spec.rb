require 'spec_helper'

describe PagesController do
  describe "Get 'home'" do
    it "renders the home template" do
      get :home
      expect(response).to render_template :home
    end
  end

  describe "Get 'about'" do
    it "renders the :about template" do
      get :about
      expect(response).to render_template :about
    end
  end
end
