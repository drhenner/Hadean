require 'spec_helper'

describe Role do
  ##  These roles are preloaded from the seeds... lets make sure all the seeds are valid
  describe "Valid Seed data" do
    
    Role.all do |role|
      it "should be valid" do 
        role.should be_valid
      end
    end
    
  end
end
