require 'spec_helper'

describe CoursController do
  render_views

  before(:each) do
    @base_title = "DocTor"
  end

  describe "GET 'tous'" do
    it "devrait reussir" do
      get 'tous'
      response.should be_success
    end

    it "devrait avoir le bon titre" do
      get 'tous'
      response.should have_selector("title",
      								:content => @base_title + " - Tous les cours")
	end    
  end

end
