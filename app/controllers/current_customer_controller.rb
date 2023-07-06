# frozen_string_literal: true
class CurrentCustomerController < ApplicationController
  def set_connexion(session_id, endpoint)
    api_url = "http://localhost:3000/#{endpoint}"

    headers = {
      'Cookie' => "_qualipso_session=#{session_id}"
    }
    customer = HTTParty.get(api_url, headers: headers)
    return customer
  end
  
  def index
    session_id = 'c7a7f96de8db07a401666ee20513f93b' # Replace with the actual session ID
    tags_endpoint = 'get_tags'
    current_customer_endpoint = 'get_current_customer'
    
    customer = set_connexion(session_id,current_customer_endpoint)
    # pp customer['id']
    user = Customer.find(customer['id'])
    user.tags



    # Output the response code and message
    puts "Response code: #{customer.code}"
    puts "Response message: #{customer.message}"

    # Process the response
    if customer.success?
      # Success: Parse and use the customer data
      customer_body = customer.parsed_response
      render json: user.tags
    else
      # Error: Handle the response accordingly
      error_message = "API request failed with code #{customer.code}: #{customer.message}"
      render json: { error: error_message }, status: :internal_server_error
    end
  end
end
  