require 'openssl'
require 'base64'
require 'uri'

class CryptedUriTokenCreator

  def initialize(text, action=:encrypt, params={context: nil, key: nil})
    @text = ensure_text(text)
    @action = ensure_action(action)
    @context = ensure_context(params[:context])
    @key = ensure_key(params[:key])
  end

  def execute
    if encrypt?
      URI.escape(encrypt(@context, @key, @text)[0])
    else
      decrypt(@context, @key, URI.unescape(@text))
    end
  end

  private

  def encrypt?
    @action == :encrypt
  end

  def encrypt(context, key, text)
    key = key + context if context.presence
    crypted = aes(:encrypt, key, text)
    crypted.unpack('H*')
  end

  def decrypt(context, key, text)
    text = text[0] if text.instance_of? Array
    text = [text].pack('H*')
    key = key + context if context.presence
    aes(:decrypt, key, text)
  end

  def aes(mode, key, text)
    (aes = OpenSSL::Cipher::Cipher.new('aes-256-cbc').send(mode)).key = Digest::SHA256.digest(key)
    aes.update(text) << aes.final
  end

  def ensure_text(value)
    if value.instance_of? String
      return value
    elsif value.instance_of? Fixnum
      return value.to_s
    else
      raise "Parameter 'value' is not a String or Fixnum"
    end
  end

  def ensure_key(key)
    key.presence || Rails.application.secrets.salt
  end

  def ensure_action(action)
    if action.presence && (action == :encrypt || action == :decrypt)
      action
    else
      :encrypt
    end
  end

  def ensure_context(context)
    if context.presence
      context = context.to_s if context.instance_of? Symbol
      context
    else
      nil
    end
  end
end