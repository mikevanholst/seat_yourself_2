require 'spec_helper'

describe Restaurant do
  let!(:restaurant) {FactoryGirl.create(:restaurant)}
  
  it "should have a valid factory" do
    restaurant.should be_valid
  end

  it {should validate_presence_of(:name)}
  it {should validate_presence_of(:phone)}
  it {should validate_presence_of(:address)}
  it {should validate_presence_of(:seats)}

  
  # expect(restaurant).to be_valid
end
