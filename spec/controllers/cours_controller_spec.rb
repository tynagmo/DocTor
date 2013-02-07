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

  describe "GET 'html'" do
    it "devrait reussir" do
      get 'html'
      response.should be_success
    end

    it "devrait avoir le bon titre" do
      get 'html'
      response.should have_selector("title",
                        :content => @base_title + " - Générer pages HTML")
    end
  end

  describe "GET 'pdf'" do
    it "devrait resussir" do
      get 'pdf'
      response.should be_success
    end

    it "devrait avoir le bon titre" do
      get 'pdf'
      response.should have_selector("title",
                      :content => @base_title + " - Générer cours PDF"
    end
  end

end
