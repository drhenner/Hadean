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
