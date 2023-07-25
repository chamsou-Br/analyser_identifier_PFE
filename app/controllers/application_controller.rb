class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  skip_before_action :verify_authenticity_token

  helper_method :set_connexion
  helper_method :get_token

  def test_token(token)
    api_url = "http://localhost:3000/api/test_token"
    # token = "68aba32a9325cc17601a603a13409d85"
    headers = {'Cookie' => "_qualipso_session=#{token}"}
    puts customer = HTTParty.get(api_url, headers: headers).to_s

    if (customer[0] == "w" && customer[1] == "o")
      is_good = true
    else
      is_good = false
    end

    return is_good
  end

  def get_token
    redis_config = {
      url: ENV.fetch('REDIS_URL', 'redis://localhost:6379'),
      namespace: "pyx4_#{Rails.env}"
    }.freeze
    redis = Redis.new(redis_config) # Establish the connection to Redis
    session_data = redis.keys('qualipso_development:session:*') # Retrieve the key

    for n in 0..session_data.length-1 do
      testing_token = session_data[n].match(/:session:(\w+)/)[1]
      if (test_token(testing_token))
        @@session_token = testing_token
        return @@session_token
      end
    end
  end

  def set_connexion
    session_id = get_token
    headers = {'Cookie' => "_qualipso_session=#{session_id}"}
    current_customer_endpoint = 'get_current_customer'
    api_url = "http://localhost:3000/#{current_customer_endpoint}"

    customer = HTTParty.get(api_url, headers: headers, timeout: 40)
    user = Customer.find(customer['id'])
    return user
  end
end
