require 'spec_helper'

describe Admin::UsersController do
  
  #integrate_views
  #render_views
  #context "index action" do
    
    before(:all) do
      @first_user = User.make
      @second_user = User.make
    end
    
    it "should render the index action" do
      User.stub!(:find).and_return([@first_user, @second_user]) 
      #@users = [@first_user, @second_user]
      get 'index'
      response.should render_template('index')
    end
  #end
end
