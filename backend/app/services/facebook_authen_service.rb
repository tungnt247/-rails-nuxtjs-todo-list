class FacebookAuthenService
  def initialize(code)
    @code = code
  end

  def call
    facebook_authen
  end

  private

  attr_reader :code
  
  def facebook_access_token
    response = Faraday.get("https://graph.facebook.com/v7.0/oauth/access_token?client_id=#{ENV['FACEBOOK_APP_ID']}&redirect_uri=http://localhost:8000/login&client_secret=#{ENV['FACEBOOK_APP_SECRET']}&code=#{code}")
    @token ||= JSON.parse(response.body)['access_token']
  end

  def facebook_user_information
    input_token = facebook_access_token
    debug_token_response = Faraday.get("https://graph.facebook.com/debug_token?input_token=#{input_token}&access_token=#{ENV['FACEBOOK_APP_TOKEN']}")
    uid = JSON.parse(debug_token_response.body)['data']['user_id']

    user_infor_response = Faraday.get("https://graph.facebook.com/#{uid}?fields=id,email&access_token=#{input_token}")
    @user_infor ||= JSON.parse(user_infor_response.body)
  end

  def facebook_authen
    user_info = facebook_user_information
    user = User.find_or_initialize_by(
      email: user_info['email'],
      uid: user_info['id'],
      provider: 'facebook'
    )
    user.skip_password_validation = true
    user.save
    @token = user_token(user)
  end

  def user_token(user)
    return nil unless user
    {
      token: JsonWebToken.encode({ user_id: user.id, exp: TOKEN_EXPIRE_TIME } )
    }
  end
end
