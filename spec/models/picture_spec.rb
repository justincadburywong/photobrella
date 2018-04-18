require 'rails_helper'

RSpec.describe Picture, type: :model do
  describe "Model" do
    before do
      @user = FactoryGirl.create(:user)
      @picture = FactoryGirl.build(:picture)
      @picture.user_id = @user.id
    end

    # context "Attributes" do
    #   it 'are readable' do
    #     expect(@picture.name).to eq ''
    #     expect(@picture.description).to eq ''
    #     expect(@picture.category).to eq ''
    #     expect(@picture.ingredient1).to eq ''
    #     expect(@picture.quantity1).to eq ''
    #     expect(@picture.instruction1).to eq ''
    #   end
    # end

    context "Validations" do

      it "should validate name" do
        should validate_presence_of(:name)
        should validate_length_of(:name)
        .is_at_most 32
      end

      it "should validate description" do
        should validate_presence_of(:description)
        should validate_length_of(:description)
        .is_at_least 3
      end

      it "should validate category" do
        should validate_presence_of(:category)
        should validate_length_of(:category)
      end

      it "should validate ingredient1" do
        should validate_presence_of(:ingredient1)
        should validate_length_of(:ingredient1)
      end

      it "should validate quantity1" do
        should validate_presence_of(:quantity1)
        should validate_length_of(:quantity1)
      end

      it "should validate instruction1" do
        should validate_presence_of(:instruction1)
        should validate_length_of(:instruction1)
      end

    end

    context "#save" do
      it "should save correctly when valid" do
        expect {
          @picture.save
        }.to change(Picture, :count).by(1)
      end

      it "should not save when name is empty" do
        @picture.name = ""
        expect {
          @picture.save
        }.not_to change(Picture, :count)
      end

      it "should not save when name is nil" do
        @picture.name = nil
        expect {
          @picture.save
        }.not_to change(Picture, :count)
      end
    end

    context "#update" do
      it "should correctly change the name" do
        @picture.update(name: "BA's Best Chicken")
        expect(@picture.name).to eq("BA's Best Chicken")
      end
      it "should correctly change the description" do
        @picture.update(description: "Hot hot hot")
        expect(@picture.description).to eq("Hot hot hot")
      end
      it "should correctly change the source" do
        @picture.update(source: "http://www.bonappetit.com/story/easiest-roast-chicken-picture")
        expect(@picture.source).to eq("http://www.bonappetit.com/story/easiest-roast-chicken-picture")
      end
      it "should correctly change the category" do
        @picture.update(category: "Chicken, Bon Appetit")
        expect(@picture.category).to eq("Chicken, Bon Appetit")
      end
      it "should correctly change the prep_time" do
        @picture.update(prep_time: "1 hour")
        expect(@picture.prep_time).to eq("1 hour")
      end
      it "should correctly change the servings" do
        @picture.update(servings: "6")
        expect(@picture.servings).to eq("6")
      end
      it "should correctly change the cals_serving" do
        @picture.update(cals_serving: "630")
        expect(@picture.cals_serving).to eq("630")
      end
      it "should correctly change the notes" do
        @picture.update(notes: "This picture eliminates one of the most common complaints about whole roast chickens - that it's hard to know when they're cooked all the way through.")
        expect(@picture.notes).to eq("This picture eliminates one of the most common complaints about whole roast chickens - that it's hard to know when they're cooked all the way through.")
      end
    end

    context "#destroy" do
      it "should reduce the total entries in the database" do
        @picture.save
        expect {
          @picture.destroy
        }.to change(Picture, :count).by(-1)
      end
      it "should remove picture from the database" do
        @picture.save
        @picture.destroy
        expect(Picture.first).to eq(nil)
      end
    end

  end
end
