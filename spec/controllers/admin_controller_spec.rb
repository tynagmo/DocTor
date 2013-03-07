require 'spec_helper'

describe AdminController do

  describe "GET 'tous'" do
    it "should be successful" do
      get 'tous'
      response.should be_success
    end
  end

  describe "GET 'detail'" do
    it "should be successful" do
      get 'detail'
      response.should be_success
    end
  end

end
