require 'spec_helper'

describe PropertiesController do

  describe 'GET #new' do
    it 'assigns a new property to @property' do
      get :new
      expect(assigns :property).to be_a_new(Property)
    end

    it 'renders the #new template' do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'Post #create' do
    context 'with valid attributes' do
      it 'creates a new property listing' do
        expect{
          post :create, property: attributes_for(:property)
        }.to change(Property, :count).by(1)
      end

      it 'sets a flash[:notice] message' do
        post :create, property: attributes_for(:property)
        expect(flash[:success]).to eql('You have created a new property')
      end
    end

    context 'with invalid attributes' do
      it 'does not create a property listing' do
        expect{
          post :create, property: attributes_for(:invalid_property)
        }.not_to change(Property, :count).by(1)
      end

      it 're-renders the #new template' do
        post :create, property: attributes_for(:invalid_property)
        expect(response).to render_template :new
      end
    end
  end
end
