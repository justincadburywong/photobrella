require 'rails_helper'

RSpec.describe PicturesController, type: :controller do
  before do
    @user = FactoryBot.create(:user)
    @picture = FactoryBot.build(:picture)
    @picture.user_id = @user.id
    @picture.save
  end

  describe "#index" do
    it "renders the index page" do
      get :index
      expect(response).to have_rendered("/index")
    end
  end

  context "not logged in" do
    describe "/" do
      it 'redirects to root_path if not logged in' do
        get :index
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  context "logged in" do
    before(:each) do
      session[:user_id] = @user.id
    end
    describe "/" do
      it 'renders the new page if the user is logged in' do
        get :index
        expect(response).to have_rendered("/index")
      end
    end
  end

end
