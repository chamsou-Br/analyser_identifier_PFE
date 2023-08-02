class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  skip_before_action :verify_authenticity_token

  helper_method :get_current_customer
  helper_method :get_token

  # Initiation of class variables
  @@session_token = nil
  @@memorized_session_data_length = 0
  MSQUALIPSO_BASE_URL = "http://localhost:3000".freeze

  # Returns the current session token
  def get_token
    # Checks if we don't have other new tokens, we return directly same token
    @@session_token &&= @@session_token if redis_session_data_length == @@memorized_session_data_length

    session_data = redis_connection.keys("qualipso_#{Rails.env}:session:*") # Retrieve the key
    @@memorized_session_data_length = session_data.length # Memorize the session_data length

    # Test all tokens, retrieve the right token
    if (session_data.length == 1)
      @@session_token = session_data[0].match(/:session:(\w+)/)[1]
    else
      session_data.each do |key|
        current_token = key.match(/:session:(\w+)/)[1]
        if test_token(current_token)
          @@session_token = current_token
          break
        end
      end
    end

    return @@session_token
  end

  # Tests if the token works
  def test_token(token)
    api_url = "#{MSQUALIPSO_BASE_URL}/api/test_token"
    headers = {'Cookie' => "_qualipso_session=#{token}"}
    customer = HTTParty.get(api_url, headers: headers).to_s

    customer[0] == "w" && customer[1] == "o"
  end

  # Retrieves the current_customer
  def get_current_customer
    session_id = get_token
    headers = {'Cookie' => "_qualipso_session=#{session_id}"}
    api_url = "#{MSQUALIPSO_BASE_URL}/get_current_customer"

    customer = HTTParty.get(api_url, headers: headers, timeout: 20)
    user = Customer.find(customer['id'])
    user
  end

  private

  # returns the number of session keys available
  def redis_session_data_length
    session_data = redis_connection.keys('qualipso_development:session:*') # Retrieve the key
    session_data.length
  end

  # Connection to redis
  def redis_connection
    @redis_connection ||= begin
      redis_config = {
        url: ENV.fetch('REDIS_URL', 'redis://localhost:6379'),
        namespace: "pyx4_#{Rails.env}"
      }.freeze
      Redis.new(redis_config)
    end
  end
end
