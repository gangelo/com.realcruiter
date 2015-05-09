require 'crypted_uri_token_creator'

class CryptedConnectionTokenCreator < CryptedUriTokenCreator
  def initialize(text, action=nil)
    super text, action, {context: :connection}
  end
end