require "encrypted_attributes/version"
require "openssl"
require "base64"

module EncryptedAttributes
  def encrypt(*attributes, options)
    public_key = options[:public]
    private_key = options[:private]

    attributes.each do |attribute|
      raw_attribute_getter = :"raw_#{attribute}"

      define_method(raw_attribute_getter) do
        read_attribute(attribute).to_s
      end

      define_method(attribute) do
        decoded_attribute = Base64.decode64(send(raw_attribute_getter))
        if decoded_attribute.nil? || decoded_attribute.empty?
          ""
        else
          decrypting_key = (private_key.respond_to?(:call) ? private_key.call : private_key)
          decrypting_key.private_decrypt(decoded_attribute)
        end
      end

      define_method("#{attribute}=") do |new_value|
        new_value = "" if new_value.nil?
        encrypting_key = (public_key.respond_to?(:call) ? public_key.call : public_key)
        encrypted_value = encrypting_key.public_encrypt(new_value)
        encoded_value = Base64.encode64(encrypted_value)
        write_attribute(attribute, encoded_value)
      end
    end
  end
end
