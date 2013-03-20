require 'spec_helper'

describe FavoritesController do
  describe 'Guest access' do
    describe 'Post :create' do
      it 'requires login' do
        property = create(:property)
        post :create, id: property
        expect(response).to redirect_to new_user_session_path
      end
    end
    describe 'Get :index' do
      it 'requires login' do
        property = create(:property)
        post :create, id: property
        expect(response).to redirect_to new_user_session_path
      end
    end
    describe 'Delete :destroy' do
      it 'requires login' do
        property = create(:property)
        post :create, id: property
        expect(response).to redirect_to new_user_session_path
      end
    end
    describe 'Put :update' do
      it 'requires login' do
        property = create(:property)
        post :create, id: property
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'User accesss' do
    before do
      @user = create(:user)
      sign_in @user
    end

    describe 'Post #create' do
      before :each do
        @property = create(:property, user: @user)
        @other_property = create(:property)
      end

      context 'when a user favorites his own listings' do
        it 'redirects to show template' do
          post :create, id: @property
          expect(response).to redirect_to property_path(@property)
        end

        it 'set a flash[:alert] message' do
          post :create, id: @property
          expect(flash[:alert]).to eql 'You can not favorite a listing you have created'
        end
      end

      context 'when a user favorites a property' do
        it 'increases the number of favorites listings by 1' do
          expect {
            post :create, id: @other_property
          }.to change(@user.favorites, :count).by(1)
        end

        it 'redirects to property_page' do
          post :create, id: @other_property
          expect(response).to redirect_to favorites_properties_path
        end

        it 'sets a flash[:notice] message' do
          post :create, id: @other_property
          expect(flash[:notice]).to eql('You favorited Apartment at Doiranis')
        end
      end

      context 'when a user favorites an already favorited property' do
        before do
          @request.env['HTTP_REFERER'] = property_url(@other_property)
          post :create, id: @other_property, type: 'favorite'
        end

        it 'redirects to the user account' do
          post :create, id: @other_property, type: 'favorite'
          expect(response).to redirect_to property_path(@other_property)
        end

        it 'sets a flash[:alert] message' do
          post :create, id: @other_property
          expect(flash[:alert]).to eql('You have already favorited this property')
        end
      end
    end

    describe 'Get #index' do
      before { post :create, id: (create :property) }
      it 'renders the index template' do
        get :index
        expect(response).to render_template :index
      end
    end

    describe 'Put #update' do
      context 'when a user unfavorites a property' do
        before do
          @other_property = create :property
          @user.favorites << @other_property
          @request.env['HTTP_REFERER'] = property_url(@other_property)
        end

        it 'reduces the number of favorite listings by 1' do
          expect {
            put :update, id: @other_property
          }.to change(@user.favorites, :count).by(-1)
        end

        it 'redirects back to the user account' do
          put :update, id: @other_property
          expect(response).to redirect_to property_url(@other_property)
        end

        it 'sets a flash[:notice] message' do
          put :update, id: @other_property
          expect(flash[:notice]).to eql('You unfavorited Apartment at Doiranis')
        end
      end
    end

    describe 'Delete #destroy' do
      before do
        @request.env['HTTP_REFERER'] = favorites_properties_url
        @other_property = create :property
        post :create, id: @other_property
      end

      it 'redirects to properties page' do
        delete :destroy
        expect(response).to redirect_to favorites_properties_path
      end

      it 'resets the favorite list' do
        delete :destroy
        expect(@user.favorites).to be_empty
      end
    end
  end
end
