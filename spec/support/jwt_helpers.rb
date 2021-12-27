module JwtHelper
  def decode_authorization_header(header)
    hmac_secret = Devise::JWT.config.values[:secret]
    token = header.split(' ').last

    JWT.decode(token, hmac_secret, true, algorithm: 'HS256').first
  end

  def auth_headers(user)
    headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
    # This will add a valid token for `user` in the `Authorization` header
    auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, user)
  end
end
