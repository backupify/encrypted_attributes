require 'openssl'
require 'base64'

module EncryptedAttributes
  module TestHelpers
    def assert_encrypted(model, *attributes)
      options = attributes.pop if attributes.last.is_a?(Hash)
      public_key = options[:public]
      private_key = options[:private]
      combined_key = options[:key]
      if combined_key
        public_key = private_key = combined_key
      end

      instance = model.new

      attributes.each_with_index do |attribute, i|
        assert_respond_to instance, :"raw_#{attribute}"

        testing_value = "abcdef-#{i}"

        instance.send("#{attribute}=", testing_value)
        raw_value = instance.send("raw_#{attribute}")
        processed_value = instance.send(attribute)

        assert_not_equal raw_value, processed_value

        decoded_raw_value = Base64.decode64(raw_value)
        decrypted_raw_value = private_key.private_decrypt(decoded_raw_value)

        assert_equal testing_value, decrypted_raw_value
      end
    end
  end
end
