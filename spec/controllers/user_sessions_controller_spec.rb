require 'spec_helper'

describe UserSessionsController do
  before { @user = create(:user) }

  describe 'Get #new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'Post #create' do
    context 'with invalid credentials' do
      it 're-renders the new method' do
        post :create, user: attributes_for(:registered_user, password: 'wrong_pass')
        expect(response).to render_template :new
      end

      it "displays 'Wrong name or password'" do
        post :create, user: attributes_for(:registered_user, password: 'wrong_pass')
        expect(flash[:error]).to eql("Wrong email or password")
      end
    end

    context 'with valid credentials' do
      it 'redirects to home page' do
        post :create, user: attributes_for(:registered_user)
        expect(response).to redirect_to root_url
      end

      it "sign in user" do
        post :create, user: attributes_for(:registered_user)
        expect(session[:user_id]).to eql @user.id
      end

      it "displays 'You are now signed in'" do
        post :create, user: attributes_for(:registered_user)
        expect(flash[:notice]).to eql('You are now signed in')
      end
    end
  end
  context 'when user is already signed in' do
    before do
      post :create, user: attributes_for(:registered_user)
    end

    describe "Delete #destroy" do

      it "sign out user" do
        delete :destroy
        expect(session[:user_id]).to be_nil
      end

      it "redirects to home page" do
        delete :destroy
        expect(response).to redirect_to root_url
      end
    end
  end
end
