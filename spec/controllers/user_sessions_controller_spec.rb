require 'spec_helper'

describe UserSessionsController do

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
  end

  describe "GET 'destroy'" do
    it "should be successful" do
      get 'delete'
      response.should be_success
    end
  end

end
