# frozen_string_literal: true

module ImproverOrderable
  extend ActiveSupport::Concern

  included do |base|
    def base.orders
      if self == ActFilter
        { created_up: 0, created_down: 1, last_updated_up: 2, last_updated_down: 3, late_act: 4, none: 6 }
      elsif self == AuditFilter
        { created_up: 0, created_down: 1, last_updated_up: 2, last_updated_down: 3, late_audit: 5, none: 6 }
      else
        { created_up: 0, created_down: 1, last_updated_up: 2, last_updated_down: 3, none: 6 }
      end
    end

    # TODO: Reduce cyclomatic complexity or increase tolerance
    # rubocop:disable Metrics/CyclomaticComplexity
    def base.apply_order(elmts, order_by)
      case orders.key(order_by.to_i)
      when :created_up
        elmts.order(created_at: :asc)
      when :created_down
        elmts.order(created_at: :desc)
      when :last_updated_up
        elmts.order(updated_at: :asc)
      when :last_updated_down
        elmts.order(updated_at: :desc)
      when :late_act
        elmts.order("estimated_closed_at IS NULL", real_closed_at: :asc, estimated_closed_at: :asc)
      when :late_audit
        elmts.order(completed_at: :asc, estimated_closed_at: :asc)
      when :none
        elmts
      else
        elmts.order(created_at: :desc)
      end
    end
    # rubocop:enable Metrics/CyclomaticComplexity

    # remove value and return the new object filter
    def remove_value(key, value = nil)
      case key
      when "created"
        @date_created_start = nil
        @date_created_end = nil
      when "closed"
        @date_closed_start = nil
        @date_closed_end = nil
      when "responsable"
        @responsable = ""
      else
        send(key).delete(value)
      end

      self
    end
  end
end
