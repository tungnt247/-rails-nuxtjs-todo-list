class JsonWebToken
  class << self
    def encode(payload)
      JWT.encode(payload, ENV['JWT_SECRET_KEY'], 'HS256')
    end

    def decode(token)
      return HashWithIndifferentAccess.new(JWT.decode(token, ENV['JWT_SECRET_KEY'])[0])
    rescue
      nil
    end
  end
end
