# frozen_string_literal: true

module Discussion
  #
  # Including the **Discussable** concern makes a given model capable of having
  # a discussion thread and being commented on.
  #
  module Discussable
    extend ActiveSupport::Concern

    class_methods do
      #
      # Aggregates the records returned from the given `relation_names`
      # relations assuming they represent individuals that can discuss the
      # record.  If a block is provided, it received the record as context
      # `self` and the aggregate records as a first argument.
      #
      # @param [Array<Symbol>] relation_names
      # @return [void]
      # @yieldparam [Array<User>] participants
      # @yieldreturn [Array<User>]
      # @example
      #
      #     class Audit
      #       include Discussion::Discussable
      #
      #       discussable_by :organizer, :contributors
      #     end
      #
      #     Audit.new.discussion_participants
      #     # => Returns array of contributors and organizer for the audit
      #
      #     class Risk
      #       include Discussion::Discussable
      #
      #       discussable_by :owner, :validators do |participants|
      #         participants.reject(&:risk_admin?)
      #       end
      #     end
      #
      def discussable_by(*relation_names, &block)
        define_method(:discussion_participants) do
          # Collect all discussion participants in a flat array of person
          # records (`User` in the Pyx4 case)
          participants = relation_names.select { |name| respond_to?(name) }
                                       .map { |name| send(name) }
                                       .flatten

          if block
            # If a block was provided, execute it with the record as a context
            # passing to it the `participants` retrieved so far
            instance_exec(participants, &block)
          else
            # Otherwise, return the participants fetched so far
            participants
          end.uniq
        end
      end
    end

    included do
      # Append the including class' `name` to the list of acceptable record
      # types to which discussion threads can belong
      #
      # @note This automatic inference expects model classes to all be loaded
      #   in order to validate if a given model can have discussion threads.
      #   This is virtually never an issue given preloading in production and
      #   most classes being loaded in development.  It is still possible in
      #   theory in development to attempt to validate the thread's record type
      #   before the discussable class is loaded but this seems currently
      #   impossible in our own project.
      Discussion.config.discussable_types << name unless Discussion.config.discussable_types.include?(name)

      # Something that is discussable may have a discussion thread.
      #
      # @!attribute [rw] discussion
      #   Discussion thread in which users comment on this record
      #   @return [Discussion::Thread]
      has_one :discussion, as: :record,
                           class_name: "Discussion::Thread"

      # @!attribute [rw] comments
      #   Comments users have made on this record
      #   @return [ActiveRecord::Relation<Discussion::Comment>]
      # has_many :comments, source_type: "Discussion::Comment", through: :discussion
      delegate :comments, allow_nil: true, to: :discussion

      scope :with_discussion, -> { includes(discussion: :comments) }

      #
      # Has this record been discussed by anyone?
      #
      # @return [Boolean]
      #
      def discussed?
        comments.present?
      end

      # Use a sane default of `owner` and `contributors` as individuals that may
      # discuss the record
      discussable_by :owner, :contributors
    end
  end
end
