# frozen_string_literal: true

require "/Users/macbookpro/Desktop/app-inst/mstags2/app/models/concerns/iam_customer_setup.rb"

class CurrentCustomerController < ApplicationController
  
  
  def index
    session_id = '00b8db8c8edd7f06ea1a3a204dc3f38a' # Replace with the actual session ID
    tags_endpoint = 'get_tags'
    current_customer_endpoint = 'get_current_customer'
    api_url = "http://localhost:3000/#{current_customer_endpoint}"
    
    user = set_connexion(api_url)
    # pp customer['id']
    user.tags
    render json: user.tags
    
    # render json: { error: error_message }, status: :internal_server_error

    # # Process the response
    # if customer.success?
    #   # Success: Parse and use the customer data
    #   customer_body = customer.parsed_response
    #   render json: user.tags
    # else
    #   # Error: Handle the response accordingly
    #   error_message = "API request failed with code #{customer.code}: #{customer.message}"
    #   render json: { error: error_message }, status: :internal_server_error
    # end
  end
end
  