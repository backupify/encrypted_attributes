require "encrypted_attributes/version"
require "openssl"
require "base64"

module EncryptedAttributes
  def encrypt(*attributes, options)
    public_key = options[:public]
    private_key = options[:private]
    combined_key = options[:key]
    if combined_key
      public_key = combined_key
      private_key = combined_key
    end

    attributes.each do |attribute|
      raw_attribute_getter = :"raw_#{attribute}"

      define_method(raw_attribute_getter) do
        read_attribute(attribute)
      end

      define_method(attribute) do
        encoded_attribute = send(raw_attribute_getter)
        if encoded_attribute.nil?
          return nil
        end
        decoded_attribute = Base64.decode64(encoded_attribute)
        if decoded_attribute.nil? || decoded_attribute.empty?
          decoded_attribute
        else
          private_key.private_decrypt(decoded_attribute)
        end
      end

      define_method("#{attribute}=") do |new_value|
        if new_value.nil?
          write_attribute(attribute, nil)
        else
          encrypted_value = public_key.public_encrypt(new_value)
          encoded_value = Base64.encode64(encrypted_value)
          write_attribute(attribute, encoded_value)
        end
      end
    end
  end
end
