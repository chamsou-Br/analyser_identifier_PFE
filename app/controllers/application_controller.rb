class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  skip_before_action :verify_authenticity_token

  helper_method :set_connexion

  def set_connexion(api_url)
    session_id = '00b8db8c8edd7f06ea1a3a204dc3f38a'

    headers = {
      'Cookie' => "_qualipso_session=#{session_id}"
    }
    customer = HTTParty.get(api_url, headers: headers)
    user = Customer.find(customer['id'])
    return user
  end
end
