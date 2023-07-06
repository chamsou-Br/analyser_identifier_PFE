# frozen_string_literal: true

#
# Including this module, a class is expected to expose `firstname` and
# `lastname` string accessors and adds a `name` accessor that composes those two
# in a {User::Name} value object.
#
# @dependency `firstname` [String] accessor
# @dependency `lastname` [String] accessor
#
# @example Including the module
#   class Person
#     include HumanNameable
#
#     attr_accessor :firstname, :lastname
#
#     def initialize(firstname, lastname)
#       @firstname, @lastname = firstname, lastname
#     end
#   end
#
# @example Accessing the `name` value object
#   developer = Person.new("Grace", "Hopper")
#   developer.name
#   # => <User::Name @first="Grace" @last="Hopper">
#
# @example Updating attributes by updating the `name` value object
#   developer = Person.new("Grace", "Hopper")
#   developer.name = User::Name.new("Ada", "Lovelace")
#   developer
#   # => <User @firstname="Ada" @lastname="Lovelace">
#
module HumanNameable
  extend ActiveSupport::Concern

  # @!attribute [rw] firstname
  #   @return [String]

  # @!attribute [rw] lastname
  #   @return [String]

  # @!attribute [rw] name
  #   @return [User::Name]
  #   @raise [NoMethodError] if not assigned an object responding to `first`
  #     and `last`

  included do
    validates :firstname, :lastname, length: { maximum: 255 },
                                     presence: true

    composed_of :name, class_name: "User::Name",
                       mapping: [
                         %i[firstname first],
                         %i[lastname last]
                       ]
  end
end
