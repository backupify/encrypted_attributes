require 'test/test_helper'

class HelperTest < Test::Unit::TestCase

  def setup
    TestModel.class_eval do
      encrypt :secret, :key => TEST_KEY
    end
    @model = TestModel.new
  end

  def test_helper_works
    assert_encrypted TestModel, :secret, :key => TEST_KEY
  end

  def test_helper_fails_properly
    assert_raises(MiniTest::Assertion) do
      assert_encrypted TestModel, :not_secret, :key => TEST_KEY
    end
  end

end
