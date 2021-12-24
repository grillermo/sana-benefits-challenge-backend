module JwtHelper
  def decode_authorization_header(header)
    hmac_secret = Devise::JWT.config.values[:secret]
    token = header.split(' ').last

    JWT.decode(token, hmac_secret, true, algorithm: 'HS256').first
  end
end
