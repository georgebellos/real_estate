require 'spec_helper'

describe UsersController do
  describe 'GET #new' do
    it 'assigns a new user to @user' do
      get :new
      expect(assigns :user).to be_a_new(User)
    end

    it 'renders the new template' do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    context 'with valid attributes' do
      it 'saves a new user in the database' do
        expect{
          post :create, user: attributes_for(:user)
        }.to change(User, :count).by(1)
      end

      it "displays 'You have signed up successfully'sets a flash message" do
        post :create, user: attributes_for(:user)
        expect(flash[:success]).to eql("You have signed up successfully")
      end

      it 'redirects to home page' do
        post :create, user: attributes_for(:user)
        expect(response).to redirect_to root_url
      end
    end
    context 'with invalid attributes' do
      it 'does not save a new user in the database' do
        expect{
          post :create, user: attributes_for(:invalid_user)
        }.not_to change(User, :count).by(1)
      end

      it 're-renders the :new template' do
        post :create, user: attributes_for(:invalid_user)
        expect(response).to render_template :new
      end
    end
  end
end
