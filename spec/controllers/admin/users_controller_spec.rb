require 'spec_helper'

describe Admin::UsersController do
  
  #integrate_views
  #render_views
  #context "index action" do
    
    #before(:all) do
    #  @first_user = mock "User"
    #  @second_user = mock "User"
    #end
    
    it "should render the index action" do
      #@first_user.should_receive(:email).and_return( "test@test.com" )
      #@second_user.should_receive(:email).and_return( "test2@test.com"  )
      @first_user  = User.make
      @second_user = User.make
      User.stub!(:find).and_return([@first_user, @second_user]) 
      get 'index'
      response.should render_template('index')
    end
  #end
end
