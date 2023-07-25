# frozen_string_literal: true

class CurrentCustomerController < ApplicationController
  # def index
  #   current_customer_endpoint = 'get_current_customer'
  #   api_url = "http://localhost:3000/#{current_customer_endpoint}"

  #   user = set_connexion(api_url)
  #   # pp customer['id']
  #   user.tags
  #   render json: user.tags
  # end

  def index
    # session_id = get_token
    tags = set_connexion.tags
    render json: tags
  end

end
