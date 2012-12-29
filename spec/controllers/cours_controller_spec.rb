require 'spec_helper'

describe CoursController do

  describe "GET 'tous'" do
    it "should be successful" do
      get 'tous'
      response.should be_success
    end
  end

end
