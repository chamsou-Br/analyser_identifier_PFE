# frozen_string_literal: true

module Api
  class ApiController < ActionController::Base
    def set_connexion(session_id, endpoint)
      api_url = "http://localhost:3000/#{endpoint}"

      headers = {
        'Cookie' => "_qualipso_session=#{session_id}"
      }
      customer = HTTParty.get(api_url, headers: headers)
      return customer
    end

    def current_customer
      session_id = '43c98da67f85160f0372b32e1fd2ae49' # Replace with the actual session ID
      endpoint = 'get_current_customer'
      api_url = "http://localhost:3000/#{endpoint}"

      headers = {
        'Cookie' => "_qualipso_session=#{session_id}"
      }

      customer = HTTParty.get(api_url, headers: headers)
      user = Customer.find(customer['id'])
      return user
    end

  end
end
