# frozen_string_literal: true

# This is Iam, the Identity Access Manager concern for entities.
#
# This concern is to be included in entities wishing to handle responsibilities
# of users as actors of the entity.
#
# The list of responsibilities for each such entities is defined in the file
# `config/responsibilities.yml` and follows the following path:
# entity:                    ##  key word
#   risk:                    ##  entity name, also event, document, etc
#     responsibilities:      ##  key word "responsibilities" define its config
#       author:              ##  responsibility name in entity
#         required: true     ##  indicates if responsibility is required
#         singular: true     ##  indicates if only one responsibility is allowed
#
# The association to the actors model is established here. After creation
# of the entity, two things happen:
# 1. the service instance is created (which created the appropriate methods to
#    manipulate the actors); and
# 2. the delegators are created in order to get these actors directly:
#    The owner of a risk can be accessed directly with risk.owner.
#
module IamEntitySetup
  extend ActiveSupport::Concern

  included do
    has_many :actors, as: :affiliation, inverse_of: :affiliation,
                      dependent: :destroy,
                      after_add: :mark_dirty_actor,
                      after_remove: :mark_dirty_actor
    after_initialize :iam_entity, :delegate_methods

    validate :validate_responsibilities
  end

  def iam_entity
    @iam_entity ||= Iam::ActorResponsibility.new(record: self)
  end

  # Delegates entity methods to iam_entity to have direct access to them.
  # Roles are taken from `config/responsibilities.yml` following the path
  # entity.[entity_name].responsibilities and getting the keys of the resulting
  # hash.  The value of each key denotes the configuration of that
  # responsibility for the entity.  Please refer to that file for details on an
  # entity's responsibilities configuration.
  #
  # Methods are readers: return user(s) with that responsibility. Ex:
  #   risk.owner or risk.validators,
  # returning a User object or an array respectively.
  #
  def delegate_methods
    responsibilities = Rails.configuration.responsibilities.dig(
      "entity", self.class.to_s.underscore, "responsibilities"
    )
    return unless responsibilities

    responsibility_names = responsibilities.keys
    responsibility_names.each do |responsibility|
      if responsibilities.dig(responsibility, "singular")
        # reader sing responsibility; writer, replace sing responsibility
        self.class.delegate responsibility, "#{responsibility}=",
                            to: :iam_entity
      else
        # reader plural responsibilities
        # writer, replace plural responsibilities
        # writer, add plural responsibilities
        # writer, add plural responsibility
        # writer, remove plural responsibility
        #
        self.class.delegate(
          "#{responsibility}s",
          "#{responsibility}s=",
          "add_#{responsibility}s",
          "add_#{responsibility}",
          "remove_#{responsibility}", to: :iam_entity
        )
      end
      # user with this responsibility?
      self.class.delegate "#{responsibility}?", to: :iam_entity
    end
  end

  def validate_responsibilities
    @validator ||= Iam::ActorValidation.new(record: self)
    @validator.validate
  end
end
