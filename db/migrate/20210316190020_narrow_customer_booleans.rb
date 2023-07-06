# frozen_string_literal: true

# This migration aims to narrow all customer boolean columns to be strictly
# boolean (TRUE or FALSE) and not NULL.  It uses `false` as a replacement for
# `NULL` for any existing `NULL` values
class NarrowCustomerBooleans < ActiveRecord::Migration[5.1]
  def change
    # Disallow using `nil`/`NULL` for the `freemium` column
    # Any existing records with `nil` will be set to `false`
    change_column_null(:customers, :freemium, false, false)

    # Disallow using `nil`/`NULL` for the `intern` column
    # Any existing records with `nil` will be set to `false`
    change_column_null(:customers, :intern, false, false)

    # Disallow using `nil`/`NULL` for the `reserved` column
    # Any existing records with `nil` will be set to `false`
    change_column_null(:customers, :reserved, false, false)

    # Set the default `try` column value to `false`.  It was `nil` so `false` is
    # equivalent for boolean ActiveRecord attributes
    change_column_default(:customers, :try, false)
    # Disallow using `nil`/`NULL` for the `try` column
    # Any existing records with `nil` will be set to `false`
    change_column_null(:customers, :try, false, false)

    # Disallow using `nil`/`NULL` for the `deactivated` column
    # Any existing records with `nil` will be set to `false`
    change_column_null(:customers, :deactivated, false, false)
  end
end
