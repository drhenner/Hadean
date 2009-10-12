require 'test_helper'

class NameTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Name.new.valid?
  end
end
