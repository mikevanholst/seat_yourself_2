require 'spec_helper'

describe UsersController do
  let!(:user) { FactoryGirl.create(:user) }

  describe "GET 'new'" do
    it "returns http succes" do
      get 'new'
      response.should be_success
    end
  end

end
