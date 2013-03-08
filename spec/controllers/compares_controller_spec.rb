require 'spec_helper'

describe ComparesController do

  describe "Post #create" do
    before do
      @property = create :property
    end

    context 'when compare list is empty' do
      it 'adds the property to compare list' do
        post :create, id: @property
        expect(session[:compare_list][0]).to eql(@property.id)
      end

      it 'redirects to compare properties page' do
        post :create, id: @property
        expect(response).to redirect_to compare_properties_path
      end

      it 'sets a flash[:notice] message' do
        post :create, id: @property
        expect(flash[:notice]).to eql('Successfuly added property for comparison')
      end
    end

    context 'when compare list is full' do
      before do
        session[:compare_list] = []
        3.times { session[:compare_list] << (create :property).id }
      end

      it 'redirects to property show' do
        post :create, id: @property
        expect(response).to redirect_to property_path(@property)
      end

      it 'sets a flash[:notice] message' do
        post :create, id: @property
        expect(flash[:notice]).to eql('You can compare at most 3 listings. Please remove a listing from compare list')
      end
    end

    context 'when the property is already on the compare list' do
      before { post :create, id: @property }
      it 'redirects to property page' do
        post :create, id: @property
        expect(response).to redirect_to property_path(@property)
      end

      it 'sets a flash[:notice] message' do
        post :create, id: @property
        expect(flash[:notice]).to eql('Property listing is already on the compare list')
      end
    end
  end

  describe 'GET #index' do
    it 'renders the :index template' do
      post :create, id: (create :property)
      get :index
      expect(response).to render_template :index
    end

    context 'when compare list is empty' do
      it 'redirects to properties' do
        get :index
        expect(response).to redirect_to properties_path
      end
    end
  end

  describe 'Put #update' do
    before do
      @property = create :property
      post :create, id: @property
    end

    it 'redirects to compare properties page' do
      put :update, id: @property.id
      expect(response).to redirect_to compare_properties_path
    end

    it 'removes one property from compare list' do
      put :update, id: @property
      expect(session[:compare_list].size).to eql(0)
    end
  end

  describe 'GET #destroy' do
    before { post :create, id: (create :property) }
    it 'redirects to properties page' do
      delete :destroy
      expect(response).to redirect_to properties_path
    end

    it 'resets the compare list' do
      delete :destroy
      expect(session[:compare_list]).to be_empty
    end
  end
end
