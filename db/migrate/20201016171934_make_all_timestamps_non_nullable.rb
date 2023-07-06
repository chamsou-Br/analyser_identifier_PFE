# frozen_string_literal: true

class MakeAllTimestampsNonNullable < ActiveRecord::Migration[5.1]
  # Fallback timestamp to use for `created_at` or `updated_at` when no data
  # exists
  FALLBACK_TIMESTAMP = DateTime.new(1970, 1, 1, 0, 0, 1)

  # All ActiveRecord model using `created_at` and `updated_at` timestamps that
  # accept `nil` in the current production DB schema
  KLASSES_WITH_NULLABLE_TIMESTAMPS = [
    ActDomainSetting, ActEvalTypeSetting, ActTypeSetting, ActVerifTypeSetting,
    Act, ActsValidator, AuditAttachment, AuditThemeSetting, AuditTypeSetting,
    CriticalitySetting, CustomerSetting, EventAttachment, EventCauseSetting,
    EventCustomProperty, EventDomainSetting, EventTypeSetting, Event,
    EventsContinuousImprovementManager, GraphBackground, GraphStep,
    Grouppackage, LdapSetting, Localisation, NewNotification,
    PackageConnection, PastilleSetting, StoreConnection, StoreSubscription,
    TaskFlag, Task, TimelineAct, TimelineEvent
  ].freeze

  def change
    KLASSES_WITH_NULLABLE_TIMESTAMPS.each do |klass|
      table_sym = klass.table_name.to_sym

      # Update timestamp columns to be non-nullable (`false`) and replace nils
      # with `FALLBACK_TIMESTAMP` if any are found
      change_column_null table_sym, :created_at, false, FALLBACK_TIMESTAMP
      change_column_null table_sym, :updated_at, false, FALLBACK_TIMESTAMP
    end
  end
end
