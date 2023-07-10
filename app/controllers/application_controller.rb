class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  skip_before_action :verify_authenticity_token

  helper_method :set_connexion

  def set_connexion(api_url)
    session_id = '77669f7b3a75a28871c4d6de14d586c5'

    headers = {
      'Cookie' => "_qualipso_session=#{session_id}"
    }
    customer = HTTParty.get(api_url, headers: headers)
    user = Customer.find(customer['id'])
    return user
  end
end
