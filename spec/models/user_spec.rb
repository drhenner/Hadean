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
