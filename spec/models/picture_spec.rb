require 'rails_helper'

RSpec.describe Picture, type: :model do
  describe "Model" do
    before do
      @user = FactoryBot.create(:user)
      @picture = FactoryBot.build(:picture)
      @picture.user_id = @user.id
    end

    context "Validations" do

      it "should validate user_id" do
        should validate_presence_of(:user_id)
      end
      it "should validate numbericality of user_id" do
        should validate_numericality_of(:user_id)
      end
      it "should validate positive number of user_id" do
        should_not allow_value(-1).for(:user_id)
      end
      it "should validate non zero number of user_id" do
        should_not allow_value(0).for(:user_id)
      end
      it "should validate integer number of user_id" do
        should_not allow_value(1.5).for(:user_id)
      end
      it "should validate file_data" do
        should validate_presence_of(:file_data)
      end
      it "should validate tags" do
        should validate_presence_of(:tags)
      end

    end

    context "#save" do
      it "should save correctly when valid" do
        expect {
          @picture.save
        }.to change(Picture, :count).by(1)
      end

      it "should not save when user_id is empty" do
        @picture.user_id = ""
        expect {
          @picture.save
        }.not_to change(Picture, :count)
      end

      it "should not save when user_id is nil" do
        @picture.user_id = nil
        expect {
          @picture.save
        }.not_to change(Picture, :count)
      end

      it "should not save when file_data is empty" do
        @picture.file_data = ""
        expect {
          @picture.save
        }.not_to change(Picture, :count)
      end

      it "should not save when file_data is nil" do
        @picture.file_data = nil
        expect {
          @picture.save
        }.not_to change(Picture, :count)
      end

      it "should not save when tags is empty" do
        @picture.tags = ""
        expect {
          @picture.save
        }.not_to change(Picture, :count)
      end

      it "should not save when tags is nil" do
        @picture.tags = nil
        expect {
          @picture.save
        }.not_to change(Picture, :count)
      end

    end

    context "#update" do
      it "should correctly change the tags" do
        @picture.update(tags: ["BA's Best Chicken"])
        expect(@picture.tags).to eq(["BA's Best Chicken"])
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
