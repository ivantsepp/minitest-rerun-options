require 'minitest/autorun'

describe Minitest do
  describe "nesting one level" do
    it "should still work" do
      _(1+1).must_equal 3
    end
  end
end
