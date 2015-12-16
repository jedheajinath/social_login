require 'rails_helper'

describe UsersController, :type => :controller do
  describe "GET 'index'" do
    it "returns http failure if user not logged-in" do
      get :index
      expect(response).to_not be_success
    end

    describe "if user logged-in" do
      before :each do
        @user = FactoryGirl.create(:user)
        sign_in @user
      end

      it "returns http success" do
        get :index
        expect(response).to be_success
      end

      it "returns http status 200" do
        get :index
        expect(response).to have_http_status(200)
      end

      it "assigns all facebook user to @facebook_users" do
        for i in 0..2
          FactoryGirl.create(:facebook_user, email: "example#{i}@test.com")
        end
        get :index
        expect(assigns(:facebook_users)).to match_array(User.where(provider: 'facebook'))
      end

      it "assign all twitter users to @twitter_users" do
        for i in 0..2
          FactoryGirl.create(:twitter_user, email: "example#{i}@test.com")
        end
        get :index
        expect(assigns(:twitter_users)).to be == User.where(provider: 'twitter')
      end

      it "assign all instagram users to @instagram_users" do
        for i in 0..2
          FactoryGirl.create(:instagram_user, email: "example#{i}@test.com")
        end
        get :index
        expect(assigns(:instagram_users)).to be == User.where(provider: 'instagram')
      end

      it "assign all google users to @google_users" do
        for i in 0..2
          FactoryGirl.create(:google_user, email: "example#{i}@test.com")
        end
        get :index
        expect(assigns(:google_users)).to be == User.where(provider: 'google_oauth2')
      end

      it "assign all other users to @other_users" do
        for i in 0..2
          FactoryGirl.create(:user, email: "example#{i}@test.com")
        end
        get :index
        expect(assigns(:other_users)).to be == User.where(provider: nil)
      end
    end
  end

  describe "GET 'show'" do
    it "returns http failure if user not logged-in" do
      get :show, id: 2
      expect(response).to_not be_success
    end

    describe "if user logged-in" do
      before :each do
        @user = FactoryGirl.create(:user)
        sign_in @user
      end

      it "returns http success" do
        get :show, id: @user
        expect(response).to be_success
      end

      it "returns http status 200" do
        get :show, id: @user
        expect(response).to have_http_status(200)
      end

      it 'assigns user to @user' do
        u2 = FactoryGirl.create(:user, email: "abc@test.com")
        get :show, id: u2
        expect(assigns(:user)).to eq(u2)
      end

    end
  end
end