require 'rails_helper'

RSpec.describe RecipesController, type: :controller do
  before do
    @user = FactoryGirl.create(:user)
    @picture = FactoryGirl.build(:picture)
    @picture.user_id = @user.id
    @picture.save
  end

  describe "#index" do
    it "renders the index page" do
      get :index
      expect(response).to have_rendered("pictures/index")
    end
  end

  describe "#show" do
    it "renders the show page" do
      get :show, params: {id: @picture.id}
      expect(response).to have_rendered("pictures/show")
    end
  end

  context "not logged in" do
    describe "/new" do
      it 'redirects to root_path if not logged in' do
        get :new
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe "/edit" do
      it "renders the edit page if the user is an admin" do
        get :edit, params: { id: @picture.id }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  # context "logged in" do
  #   before(:each) do
  #     session[:user_id] = @user.id
  #   end
  #   describe "/new" do
  #     it 'renders the new page if the user is logged in' do
  #       get :new
  #       expect(response).to have_rendered("pictures/new")
  #     end
  #   end
  #
  #   describe "/edit" do
  #     it "renders the edit page if the user is logged in" do
  #       get :edit, params: { id: @picture.id }
  #       expect(response).to have_rendered("pictures/edit")
  #     end
  #   end
  # end

end
