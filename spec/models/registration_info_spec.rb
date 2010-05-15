require 'spec_helper'

describe RegistrationInfo do
  context "Valid Registration Info" do
    before(:each) do
      @reg_info = RegistrationInfo.make
    end
    
    it "should be valid with minimum attributes" do
      @reg_info.should be_valid
    end
    
  end
end
