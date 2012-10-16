require 'test/test_helper'

class CombinedKeyTest < Test::Unit::TestCase

  def setup
    TestModel.class_eval do
      encrypt :secret, :key => TEST_KEY
    end
    @model = TestModel.new
  end

  def test_attribute_is_encrypted_in_memory
    @model.secret = "1234"
    assert_not_equal @model.secret, @model.raw_secret
  end

  def test_attribute_is_encrypted_and_encoded
    @model.secret = "1234"
    decoded = Base64.decode64(@model.raw_secret)
    decrypted = TEST_KEY.private_decrypt(decoded)

    assert_equal "1234", decrypted
  end

  def test_attribute_will_automatically_decrypt_itself
    @model.secret = "1234"
    assert_equal "1234", @model.secret
  end

end
