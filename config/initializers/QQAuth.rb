require 'timeout'
require 'rest-client'
require 'json'

class QQAuth

	def authorize_url
		"https://graph.qq.com/oauth2.0/authorize?response_type=code&client_id=#{APP_CONFIG['qq_api_key']}&redirect_uri=#{URI.escape APP_CONFIG['qq_redirect_uri']}"
	end

	def callback(code)
		@openid = Timeout::timeout(20) do
			long_str = RestClient.get('https://graph.qq.com/oauth2.0/token',
				{ :params =>
					{
						:grant_type => 'authorization_code',
						:client_id => APP_CONFIG['qq_api_key'],
						:client_secret => APP_CONFIG['qq_api_secret'],
						:code => code,
						:redirect_uri => APP_CONFIG['qq_redirect_uri']
					}
                                                 	  })
			long_str = long_str.split('&')[0]
			@access_token = long_str.split('=')[1]

			long_str = RestClient.get("https://graph.qq.com/oauth2.0/me?access_token=#{@access_token}").gsub('callback( ', '')
			long_str = long_str.gsub(" );\n", '')
			JSON.parse(long_str)['openid']
		end
		raise "验证失败" unless @openid
		return @openid
	rescue Timeout::Error
		raise "访问超时，请稍后重试"
	end

	def get_user_info
		user_info = Timeout::timeout(20) do
			JSON.parse(RestClient.get("https://graph.qq.com/user/get_user_info?openid=#{@openid}&access_token=#{@access_token}&oauth_consumer_key=#{APP_CONFIG['qq_api_key']}"))
		end
		unless user_info["nickname"]
			raise "获取用户信息时发生错误，请稍后重试"
		end
		return user_info
	rescue Timeout::Error
		raise "访问超时，请稍后重试"
	end

	def get_info
		info = Timeout::timeout(20) do
			JSON.parse(RestClient.get("https://graph.qq.com/user/get_info?access_token=#{@access_token}&oauth_consumer_key=#{APP_CONFIG['qq_api_key']}&openid=#{@openid}&format=json"))
		end
		unless info['data']
			raise "获取用户微博信息时发生错误，请稍后重试"
		end
		return info
	rescue Timeout::Error
		raise "访问超时，请稍后重试"
	end

end