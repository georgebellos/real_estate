require 'spec_helper'

describe PagesController do
  describe "Get 'home'" do
    it 'populates an array of properties' do
      10.times { create(:property) }
      get :home
      expect(assigns :properties).to eq Property.recently_created(8)
    end

    it "renders the :home template" do
      get :home
      expect(response).to render_template :home
    end
  end

  describe "Get 'about'" do
    it "renders the :about template" do
      get :info
      expect(response).to render_template :info
    end
  end

end
