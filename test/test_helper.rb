$LOAD_PATH << File.dirname(__FILE__) + "/.."
$LOAD_PATH << File.dirname(__FILE__) + "/../lib"
require 'test/unit'
require 'encrypted_attributes'

TEST_KEY = OpenSSL::PKey::RSA.new(2048)

class TestModel
  def initialize
    @attributes = {}
  end

  attr_accessor :attributes

  def read_attribute(attribute)
    @attributes[attribute]
  end

  def write_attribute(attribute, value)
    @attributes[attribute] = value
  end

  extend EncryptedAttributes
end
