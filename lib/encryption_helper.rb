require 'openssl'

module EncryptionHelper

  # NOTE SETTINGS[:encryption_key] should be in initializer.rb
  module AES256CBC
    def encrypt(plaintext)
      aes = OpenSSL::Cipher::Cipher.new('AES-256-CBC')
      aes.encrypt # must be call before #key and #iv
      aes.key = SETTINGS[:encryption_key]
      aes.iv = iv = aes.random_iv
      ciphertext = aes.update(plaintext)
      ciphertext <<  aes.final
      return iv, ciphertext
    end

    def decrypt(iv, ciphertext)
      aes = OpenSSL::Cipher::Cipher.new('AES-256-CBC')
      aes.decrypt # must be called before aes.key aes.iv
      aes.key = SETTINGS[:encryption_key]
      aes.iv = iv
      plaintext = aes.update(ciphertext)
      plaintext << aes.final
    end
  end

end