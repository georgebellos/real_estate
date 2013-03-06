require 'spec_helper'

describe PropertiesController do

  describe 'Guest access' do
    describe 'Get #new' do
      it 'requires login' do
        get :new
        expect(response).to redirect_to signin_path
      end

      it 'sets a flash[:notice] message' do
        post :create, property: attributes_for(:property)
        expect(flash[:notice]).to eql('Please sign in')
      end
    end

    describe 'Post #create' do
      it 'requires login' do
        post :create, property: attributes_for(:property)
        expect(response).to redirect_to signin_path
      end
    end

    describe 'Get #edit' do
      it 'requires login' do
        property = create :property
        get :edit, id: property
        expect(response).to redirect_to signin_path
      end
    end

    describe 'Put #update' do
      it 'requires login' do
        property = create(:property)
        put :update, id: property, property: attributes_for(:property)
        expect(response).to redirect_to signin_path
      end
    end

    describe 'Delete #destroy' do
      it 'requires login' do
        property = create(:property)
        delete :destroy, id: property
        expect(response).to redirect_to signin_path
      end
    end
  end

  describe 'User access' do
    before do
      @user = create(:user)
      session[:user_id] = @user.id
    end

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

    describe 'Post #create', :vcr do
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

        it 'redirects to property page' do
          post :create, property: attributes_for(:property)
          expect(response).to redirect_to property_path(assigns :property)
        end

      end

      context 'with invalid attributes' do
        it 'does not create a property listing' do
          expect{
            post :create, property: attributes_for(:invalid_property)
          }.not_to change(Property, :count).by(1)
        end

        it 'does not create an image' do
          expect{
            post :create, property: attributes_for(:invalid_property)
          }.not_to change(Image, :count).by(1)
        end

        it 're-renders the #new template' do
          post :create, property: attributes_for(:invalid_property)
          expect(response).to render_template :new
        end
      end
    end

    describe 'Get #show' do
      let(:property) { create(:property, user: @user) }
      it 'assigns the requested property to @property' do
        get :show, id: property
        expect(assigns :property).to eq(property)
      end

      it 'renders the #show template' do
        get :show, id: property
        expect(response).to render_template :show
      end
    end

    describe 'Get #index' do
      it 'populates an array of properties' do
        @property = create(:property, user: @user)
        get :index
        expect(assigns :properties).to eq [@property]
      end

      it 'renders the index template' do
        get :index
        expect(response).to render_template :index
      end
    end

    describe 'Get #edit' do
      let(:property) { create(:property, user: @user) }
      it 'assigns the requested property to @properdy' do
        get :edit, id: property
        expect(assigns :property).to eq(property)
      end

      it 'renders the #edit template' do
        get :edit, id: property
        expect(response).to render_template :edit
      end
    end

    describe 'Put #update', :vcr do
      before :each do
        @property = create(:property, user: @user)
      end

      it 'assigns the proper property to @property' do
        put :update, id: @property, property: attributes_for(:property)
        expect(assigns :property).to eq @property
      end

      context 'with valid attributes' do
        it 'modifies @property s attributes' do
          put :update, id: @property, property: attributes_for(:property, price: 200)
          @property.reload
          expect(@property.price).to eq 200
        end

        it 'redirects to the updated property' do
          put :update, id: @property, property: attributes_for(:property)
          expect(response).to redirect_to property_url
        end

        it 'sets a flash[:success] messsage' do
          put :update, id: @property, property: attributes_for(:property, price: 300)
          expect(flash[:success]).to eq 'Property has been updated'
        end
      end

      context 'with invalid attributes' do
        it 're-renders the edit template' do
          put :update, id: @property, property: attributes_for(:invalid_property)
          expect(response).to render_template :edit
        end

        it 'does not change the attributes of @property' do
          put :update, id: @property, property: attributes_for(:property, price: nil)
          @property.reload
          expect(@property.price).not_to be_nil
        end
      end
    end

    describe 'Delete #destroy' do
      context 'without an image' do
        before { @property = create(:property, user: @user) }

        it 'assigns the proper property to @property' do
          delete :destroy, id: @property
          expect(assigns :property).to eq @property
        end

        it 'deletes the property listing' do
          expect{
            delete :destroy, id: @property
          }.to change(Property, :count).by(-1)
        end


        it 'sets a flash[:success] message' do
          delete :destroy, id: @property
          expect(flash[:success]).to eql 'Property has been destroyed'
        end

        it 'redirects to properties#index' do
          delete :destroy, id: @property
          expect(response).to redirect_to properties_url
        end
      end

      context 'with image' do
        it 'deletes the property images' do
          @property = create(:property_with_images, user: @user, number_of_images: 2)
          expect{
            delete :destroy, id: @property
          }.to change(Image, :count).by(-2)
        end
      end
    end
  end
end
