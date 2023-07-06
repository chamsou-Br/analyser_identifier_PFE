# frozen_string_literal: true

module Notice
  #
  # Including the **Notice** concern gives the module access to general methods
  # used by many entities with workflow.
  #
  module Noticeable
    extend ActiveSupport::Concern

    # Notifies the receiver when this user has a new role triggered by a change
    # from sender.
    #
    # @param receiver [User]
    # @param sender [User]
    # @param role [String]
    #
    def notify_on_role_change(receiver:, sender:, role:)
      create_and_deliver(receiver: receiver,
                         sender: sender,
                         metadata: { role: role, category: :role_change_request })
    end

    # Takes into account if a role is singular or plural. When singular, call
    # the `create_and_deliver` on that user with role. When plural, iterate
    # through the users with the role, calling `create_and_deliver` in turn.
    #
    # @param roles [Array<String>] Role to notify with category
    # @param sender [User]
    # @param category [String] Category of the message
    #
    def dispatch_notif_workflow(roles:, sender:, category:)
      roles.each do |role|
        params_notif = { sender: sender,
                         metadata: { role: role, category: category } }

        if respond_to? role
          # single role
          receiver_s = send(role)
          next unless receiver_s

          create_and_deliver({ receiver: receiver_s }.merge(params_notif))

        elsif respond_to? "#{role}s"
          # plural role: iterates through users with this role
          receivers = send("#{role}s")
          receivers.each do |receiver_p|
            create_and_deliver({ receiver: receiver_p }.merge(params_notif))
          end

        else
          # `entity` does not seem to have this `role`. admins and managers will
          # fall in this category if we ever need to sent notifications to them.
          # TODO: might decide to do something more
          puts "Cannot send a notifaciton to this role: #{role}."
          puts "This role does not exist in #{self.class}."
        end
      end
    end

    # This method does what is name spells out: creates and if needed, delivers
    # the notification.
    #
    # The `notify` method is included as a concern in the target of the
    # notification (here a `User`) with the `notification_target` method.
    # The target is the recipient of the notification.
    #
    # @param receiver [User]
    # @param sender [User]
    # @param metadata [Hash] Params for the notifications, :category and :role
    #
    def create_and_deliver(receiver:, sender:, metadata:)
      return if receiver == sender

      notif = receiver.notify(object: self,
                              sender_id: sender&.id,
                              type: "notification",
                              metadata: metadata)

      # TODO: needs logic to take into account mail freq by the user.
      # TODO: here is one place where the layout can be specified.
      # TODO: wrap in a transaction the following two statements.
      #
      notif.deliver(:email, action: :entity)
      notif.update(mailed_date: DateTime.now,
                   mailed_frequency: :real_time)
    end

    # Convenience method for calling the notitication system from mutations
    # and have a clear interface.
    #
    # @param transition [String]
    # @param sender [User]
    #
    # @return the result of calling `notify_on` the transition on the object
    #
    def notify_on(transition, sender)
      send("notify_on_#{transition}", sender)
    end
  end
end
