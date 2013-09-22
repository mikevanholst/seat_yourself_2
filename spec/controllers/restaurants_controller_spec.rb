require 'spec_helper'

describe RestaurantsController do
let!(:restaurant) {FactoryGirl.create(:restaurant)}

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      get 'show', :id => restaurant.id
      response.should be_success
    end
  end

  describe "GET 'edit'" do
   it "returns http success" do
      get 'edit',:id => restaurant.id
      response.should be_success
    end
  end
end
