# frozen_string_literal: true

class AddOptionalSsoKeysToSsoSettings < ActiveRecord::Migration[4.2]
  def change
    add_column :customer_sso_settings, :phone_key, :string
    add_column :customer_sso_settings, :service_key, :string
    add_column :customer_sso_settings, :function_key, :string
    add_column :customer_sso_settings, :mobile_phone_key, :string
  end
end
