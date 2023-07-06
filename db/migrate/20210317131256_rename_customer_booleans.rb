# frozen_string_literal: true

# This migration aims to rename some `customers` boolean columns to more
# English-meaningful names.  Specifically:
# - `intern` to `internal`
# - `try` to `trial`
# These changes enhance the fluency of these customer attributes and also
# prevent some name collisions.  `try` is a very low-level method added to the
# `Object` class by ActiveSupport which can easily cause confusion when used and
# prevents some core rails conveniences from working as intended.
class RenameCustomerBooleans < ActiveRecord::Migration[5.1]
  def change
    # Rename `intern` to `internal` because it is intended to describe a
    # customer as being _internal_ to the Pyx4 organization
    rename_column(:customers, :intern, :internal)

    # Rename `try` to `trial` because it is intended to describe a customer
    # using a trial version of the application and does not collide with
    # ActiveSupport's `try` method
    rename_column(:customers, :try, :trial)
  end
end
