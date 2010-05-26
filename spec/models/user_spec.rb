require 'spec_helper'

describe User do
  context "Valid User" do
    before(:each) do
      @user = User.make
    end
    
    it "should be valid with minimum attributes" do
      @user.should be_valid
    end
    
  end
  
end


describe User, ".name" do
  it "should return the correct name" do
    user = User.make(:registered)
    #should_receive(:authenticate).with("password").and_return(true)
    user.stub!(:first_name).and_return("Fred")
    user.stub!(:last_name).and_return("Flint")
    user.name.should == "Fred Flint"
  end
end