# frozen_string_literal: true

# This is Iam, the Identity Access Manager concern.
#
# This concern is to be included in objects that handle responsibilities
# of users as actors.
#
# The method definitions here included, depend on methods created by the setup
# concerns for both entity and customer. If they do not exist, the methods here
# raise an `ArgumentError`, as it is understood that the `responsibility` does
# not exist. The methods are syntactic sugar or an API to facilitate the user of
# the Iam service.
#
module IamApiMethods
  extend ActiveSupport::Concern
  #
  # This method returns the user that has that responsibility in the object,
  # if the responsibility is singular.
  #
  # @param [String] responsibility, in the singular form
  #
  # @return [User] user with the responsibility
  # @return [nil] if no user is found.
  #
  # @raise [ArgumentError] if the responsibility seems to be pluralized,
  #   is in the wrong number (singular: true|false) for the method or
  #   no appropriate method is found.
  #
  # @example
  #  risk.get_actor("owner")
  #
  def get_actor(responsibility)
    plurization?(responsibility)

    if respond_to? responsibility
      send(responsibility)
    else
      responsibility_error(responsibility)
    end
  end

  # This method returns the users that have that responsibility in the object,
  # if the responsibility is plural.
  #
  # @param [String] responsibility, in the singular form
  #
  # @return [Array<User>] The list of users or [] if no users found.
  #
  # @raise [ArgumentError] if the responsibility seems to be pluralized,
  #   is in the wrong number (singular: true|false) for the method or
  #   no appropriate method is found.
  #
  #  @example
  #    risk.get_actors("validator")
  #
  def get_actors(responsibility)
    plurization?(responsibility)

    if respond_to? "#{responsibility}s"
      send("#{responsibility}s")
    else
      responsibility_error(responsibility)
    end
  end

  # This method assigns the user to this responsibility, replacing the previous
  # owner. The responsibility is singular.
  #
  # @param [String] responsibility, in the singular form
  # @param [User] user, the user to assign responsibility
  #
  # @return [User] If assignment was successful.
  #
  # @raise [ArgumentError] if the responsibility seems to be pluralized,
  #   is in the wrong number (singular: true|false) for the method or
  #   no appropriate method is found.
  #
  #  @example
  #    risk.set_actor("owner", user)
  #
  # TODO: cannot set to nil if responsibility is required
  #
  def set_actor(responsibility, user)
    plurization?(responsibility)
    invalid_user?(user)

    if respond_to? "#{responsibility}="
      send("#{responsibility}=", user)
    else
      responsibility_error(responsibility)
    end
  end

  # This method replaces the actors of this responsibility by users in this
  # object, if the responsibility is plural.
  #
  # @param [String] responsibility, in the singular form
  # @param [Array<User>] users, the user list to assign responsibility
  #
  # @return [Array<User>] the list of users replaces if successful.
  #
  # @raise [ArgumentError] if the responsibility seems to be pluralized,
  #   is in the wrong number (singular: true|false) for the method or
  #   no appropriate method is found.
  #
  #  @example
  #    risk.replace_actors("validator", users)
  #
  # TODO: cannot set to [] if responsibility is required
  #
  def replace_actors(responsibility, users)
    plurization?(responsibility)
    invalid_users?(users)

    if respond_to? "#{responsibility}s="
      send("#{responsibility}s=", users)
    else
      responsibility_error(responsibility)
    end
  end

  # This method adds the user to the actors list of this responsibility
  # in this object, if the responsibility is plural.
  #
  # @param [String] responsibility, in the singular form
  # @param [User] user, to add to responsibility
  #
  # @return [User] user added if successful
  #
  # @raise [ArgumentError] if the responsibility seems to be pluralized,
  #   is in the wrong number (singular: true|false) for the method or
  #   no appropriate method is found.
  #
  #  @example
  #    risk.add_actor("validator", user)
  #
  # TODO: cannot add a user already added
  #
  def add_actor(responsibility, user)
    plurization?(responsibility)
    invalid_user?(user)

    if respond_to? "add_#{responsibility}"
      send("add_#{responsibility}", user)
    else
      responsibility_error(responsibility)
    end
  end

  # This method adds the users to the actors list of this responsibility
  # in this object, if the responsibility is plural.
  #
  # @param [String] responsibility, in the singular form
  # @param [Array<User>] users, the user list to assign responsibility
  #
  # @return [Array<User>] user list if successful
  #
  # @raise [ArgumentError] if the responsibility seems to be pluralized,
  #   is in the wrong number (singular: true|false) for the method or
  #   no appropriate method is found.
  #
  #  @example
  #    risk.add_actors("validator", users)
  #
  # TODO: cannot add a user already added
  #
  def add_actors(responsibility, users)
    plurization?(responsibility)
    invalid_users?(users)

    if respond_to? "add_#{responsibility}s"
      send("add_#{responsibility}s", users)
    else
      responsibility_error(responsibility)
    end
  end

  # This method removes the user from the actors list of this responsibility
  # in this object, if the responsibility is plural.
  #
  # @param [String] responsibility, in the singular form
  # @param [User] user, to add to responsibility
  #
  # @return [true] on success
  #
  # @raise [ArgumentError] if the responsibility seems to be pluralized,
  #   is in the wrong number (singular: true|false) for the method or
  #   no appropriate method is found.
  #
  #  @example
  #    risk.remove_actor("validator", user)
  #
  # TODO: cannot remove the last actor if responsibility is required.
  #
  def remove_actor(responsibility, user)
    plurization?(responsibility)
    invalid_user?(user)

    if respond_to? "remove_#{responsibility}"
      send("remove_#{responsibility}", user)
    else
      responsibility_error(responsibility)
    end
  end

  #
  # This method assigns the user to this responsibility, replacing the previous
  # owner. The responsibility is singular.
  #
  # @param [String] responsibility, in the singular form
  # @param [User] user
  #
  # @return [true] if user has that responsibility
  #
  # @raise [ArgumentError] if the responsibility seems to be pluralized,
  #   is in the wrong number (singular: true|false) for the method or
  #   no appropriate method is found.
  #
  #  @example
  #    risk.is_actor?("owner", user)
  #
  def responsible_actor?(responsibility, user)
    plurization?(responsibility)
    invalid_user?(user)

    if respond_to? "#{responsibility}?"
      send("#{responsibility}?", user)
    else
      responsibility_error(responsibility)
    end
  end

  private

  # This method checks if a string finishes in `s`.
  # It returns false if the string in not pluralized (no final `s`).
  # If true (final `s` present), it raises an `ArgumentError`.
  #
  def plurization?(responsibility)
    return false unless responsibility[-1] == "s"

    raise ArgumentError,
          "\"#{responsibility}\" looks like a responsibility in the plural "\
          "form, use the singular instead."
  end

  # This method raises an `ArgumentError` when called, and lists the
  # possibilites, as to why responsibility` cannot be used in the method.
  #
  def responsibility_error(responsibility)
    raise ArgumentError,
          "The responsibility #{responsibility} is not an acceptable argument."\
          "\nPossible reasons: \n* Is does not exist; \n"\
          "* The number (singular: true/false) of the responsibility is "\
          "inconsistent with the method requirements; \n"\
          "* The string is puralized: use the singular representation instead."
  end

  # This method checks if the provided object is of class `User` or is nil.
  # It raises an `ArgumentError` when not a valid user object or nil.
  #
  def invalid_user?(user)
    return false if user.is_a?(User) || user.nil?

    raise ArgumentError, "The user provided is not a valid user."
  end

  # This method checks if the provided object is an `Array` and all its
  # elements are of class `User` or if a empty array is provided.
  # It raises an `ArgumentError` when not a valid argument for the method.
  #
  def invalid_users?(users)
    # The list of users has to be an array of valid users or an empty array.
    if users.is_a?(Array) &&
       (users.map { |user| user.is_a?(User) }.uniq == [true] || users.none?)
      return false
    end

    raise ArgumentError, "The list of users provided is not a valid array of "\
                         "user objects."
  end
end
