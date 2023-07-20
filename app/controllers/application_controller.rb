class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  skip_before_action :verify_authenticity_token

  helper_method :set_connexion

  def set_connexion(api_url)
    session_id = '21ad89e89c9ed1989f4db1c22573801e'

    headers = {
      'Cookie' => "_qualipso_session=#{session_id}"
    }
    customer = HTTParty.get(api_url, headers: headers)
    user = Customer.find(customer['id'])
    return user
  end
end
