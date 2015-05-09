require 'crypted_uri_token_creator'

class CryptedRequestToConnectTokenCreator < CryptedUriTokenCreator
  def initialize(text, action=nil)
    super text, action, {context: :connect_request}
  end
end