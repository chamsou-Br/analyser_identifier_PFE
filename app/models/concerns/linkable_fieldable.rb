# frozen_string_literal: true

# This concern ensures the deletion of an associated field value when the
# linkable is deleted.
#
# TODO: to be deleted once double account of association is deleted and such
# associations are the responsibility of Rails only. #1787, #1782, !2501
#
module LinkableFieldable
  extend ActiveSupport::Concern

  included do
    before_destroy :delete_field_value

    private

    def delete_field_value
      fv = FieldValue.where(entity_type: self.class.to_s, entity_id: id)
      return unless fv.any?

      fv.destroy_all
    end
  end
end
