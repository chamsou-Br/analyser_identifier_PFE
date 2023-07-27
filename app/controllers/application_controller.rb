class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  skip_before_action :verify_authenticity_token

  helper_method :set_connexion
  helper_method :get_token


  @@session_token = nil
  @@memorized_session_data_length = 0


  # Returns the current session token
  def get_token
    # Checks if we don't have other new tokens, we return directly same token
    if (@@session_token && redis_session_data_length == @@memorized_session_data_length)
      puts "No other token is added"
      return @@session_token
    end

    puts "New token available we are searching it"
    redis_config = {
      url: ENV.fetch('REDIS_URL', 'redis://localhost:6379'),
      namespace: "pyx4_#{Rails.env}"
    }.freeze
    redis = Redis.new(redis_config) # Establish the connection to Redis
    session_data = redis.keys("qualipso_#{Rails.env}:session:*") # Retrieve the key
    puts "retrieved all keys"
    @@memorized_session_data_length = session_data.length # Memorize the session_data length

    # Test all tokens, retrieve the right token
    if (session_data.length == 1)
      @@session_token = session_data[0].match(/:session:(\w+)/)[1]
      return @@session_token
    else
      for n in 0..session_data.length-1 do
        current_token = session_data[n].match(/:session:(\w+)/)[1]
        puts "testing: #{current_token}"
        if (test_token(current_token))
          @@session_token = current_token
          puts "token: #{@@session_token} is working"
          return @@session_token
        end
      end
    end
  end

  # Tests if the token works
  def test_token(token)
    puts "Testing"
    api_url = "http://localhost:3000/api/test_token"
    headers = {'Cookie' => "_qualipso_session=#{token}"}
    customer = HTTParty.get(api_url, headers: headers).to_s
    puts "Tested"

    if (customer[0] == "w" && customer[1] == "o")
      is_good = true
    else
      is_good = false
    end
    return is_good
  end


  def set_connexion

    session_id = get_token
    headers = {'Cookie' => "_qualipso_session=#{session_id}"}
    current_customer_endpoint = 'get_current_customer'
    api_url = "http://localhost:3000/#{current_customer_endpoint}"

    customer = HTTParty.get(api_url, headers: headers, timeout: 20)
    user = Customer.find(customer['id'])
    return user
  end

  private

  def redis_session_data_length
    redis_config = {
      url: ENV.fetch('REDIS_URL', 'redis://localhost:6379'),
      namespace: "pyx4_#{Rails.env}"
    }.freeze
    redis = Redis.new(redis_config) # Establish the connection to Redis
    session_data = redis.keys('qualipso_development:session:*') # Retrieve the key
    puts session_data.length
    session_data.length
  end

end
