# EncryptedAttributes

Encrypts attributes transparently in ActiveModel-like models.

## Usage

Extend your model with the module:

    class MyModel < ActiveRecord::Base
      extend EncryptedAttributes
    end

Call `encrypt` and supply the attributes to encrypt and the keypair to use.

    class MyModel < ActiveRecord::Base
      extend EncryptedAttributes
      encrypt :super_secret, :public => public_key, :private => :private_key
    end

Use the methods as normal. There is an attribute prefixed with "raw" that
provides the encoded, encrypted version.

    model.super_secret = "Hello, world!"
    model.raw_super_secret #=> Base64 encoded, encrypted version
    model.super_secret     #=> "Hello, world!"
