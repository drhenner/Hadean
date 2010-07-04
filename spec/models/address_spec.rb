require 'spec_helper'

describe Address do
  context "Valid Address" do
    before(:each) do
      @address = Address.make
    end
    
    it "should be valid with minimum attribues" do
      @address.should be_valid
    end
    
  end
  
end


describe Address, "#save_default_address(object, params)" do
  
  before(:each) do
    @user     = User.make
    @address  = Address.make
    @params   = @address.attributes
    @params[:default] = '1'
  end
  
  it "should save the address" do
    @address.save_default_address(@user, @params)
    @address.id.should_not be_nil
  end
  
  it "should save the address" do
    
    @address2   = Address.make
    @params2    = Address.make.attributes
    @params2[:default] = '1'
    @address2.save_default_address(@user, @params2)
    @address.save_default_address(@user, @params)
    @address.default.should       be_true
    @address2.reload.default.should_not  be_true
  end
  
  
end