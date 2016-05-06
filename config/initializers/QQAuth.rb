require 'timeout'

class QQAuth

	def authorize_url
		"https://graph.qq.com/oauth2.0/authorize?response_type=code&client_id=#{APP_CONFIG['qq_api_key']}&redirect_uri=#{URI.escape APP_CONFIG['qq_redirect_uri']}"
	end

	def callback(code)
		@openid = Timeout::timeout(20) do
			@access_token = JSON.parse(RestClient.get('https://graph.qq.com/oauth2.0/token',
				:grant_type => 'authorization_code',
				:client_id => APP_CONFIG['qq_api_key'],
                                                 	:client_secret => APP_CONFIG['qq_api_secret'],
                                                 	:code => code,
                                                 	:redirect_uri => APP_CONFIG['qq_redirect_uri'])
			)['access_token']
			JSON.parse(RestClient.get("https://graph.qq.com/oauth2.0/me?access_token=#{@access_token}"))['openid']
		end
		raise Error, "验证失败" unless @openid # error信息如何显示？
	rescue Timeout::Error
		raise Error, "访问超时，请稍后重试"

		return @openid
	end

	def get_user_info
		user_info = Timeout::timeout(20) do
			JSON.parse(RestClient.get("https://graph.qq.com/user/get_user_info?openid=#{@openid}&access_token=#{@access_token}&oauth_consumer_key=#{APP_CONFIG['qq_api_key']}"))
		end
		unless user_info["nickname"]
			raise Error, "获取用户信息时发生错误，请稍后重试"
		end
		return user_info
	rescue Timeout::Error
		raise Error, "访问超时，请稍后重试"
	end

end