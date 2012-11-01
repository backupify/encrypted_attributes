$LOAD_PATH << File.dirname(__FILE__) + "/.."
$LOAD_PATH << File.dirname(__FILE__) + "/../lib"

if ENV['CI']
  puts "Enabling simplecov(rcov) for jenkins"
  require 'simplecov'
  require 'simplecov-rcov'
  SimpleCov.formatter = SimpleCov::Formatter::RcovFormatter
  SimpleCov.start
end


require 'test/unit'
require 'encrypted_attributes'
require 'encrypted_attributes/test_helpers'

class Test::Unit::TestCase
  include EncryptedAttributes::TestHelpers
end

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
