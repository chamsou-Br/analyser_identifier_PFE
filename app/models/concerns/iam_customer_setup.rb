# frozen_string_literal: true

# This is Iam, the Identity Access Manager concern for a customer.

# This concern is to be included in the customer model to handle
# responsibilities of users at the customer level. Within the customer, there
# are three levels of responsibiliites: the `model_level`, `module_level` and
# `app_model`.
#
# * The `model_level`, usually denoting a class (i,e Risk), describes
# responsibilities that apply over the set of entities. For instance, user x is
# owner over Risk means that user x can be assigned as owner for a particular
# risk.
#
# The list of responsibilities for models (model names) is defined in the file
# `config/responsibilities.yml` and follows the following path:
# model_level:               ##  key word
#   risk:                    ##  model_level name, usually lowercase class name
#     responsibilities:      ##  key word "responsibilities" defines its config
#       owner:               ##  responsibility name in the model_level
#         required: false    ##  indicates if responsibility is required
#         singular: false    ##  indicates if only one responsibility is allowed
#
# * The `module_level` describes responsibilities that apply over the entire
# module in the business definition: improver, risk_module.
#
# The list of responsibilities for pyx4 modules is defined in the file
# `config/responsibilities.yml` and follows the following path:
# module_level:              ##  key word
#   risk_module:             ##  pyx4 module name
#     responsibilities:      ##  key word "responsibilities" defines its config
#       admin:               ##  responsibility name at module level
#         required: true     ##  indicates if responsibility is required
#         singular: false    ##  indicates if only one responsibility is allowed
#
# * The `app_module` describe for now one responsibility, the `instance_onwer`.
# It follows this path:
# app_level:
#   instance:
#     responsibilities:
#       owner:
#         required: false
#         singular: true
#
# The association to the actors model is established here. After creation
# of the customer, two things happen:
# 1. the service instance is created (which creates the appropriate methods to
#    manipulate the actors); and
# 2. the delegators are created in order to get these actors directly:
#    The owners of Risk can be accessed directly with
#      customer.risk_owners.
#    The admins of the risk_module can be accessed directly with
#      customer.risk_module_admins.
#
module IamCustomerSetup
  extend ActiveSupport::Concern

  included do
    has_many :actors, as: :affiliation, inverse_of: :affiliation,
                      dependent: :destroy
    after_initialize :iam_customer, :delegate_all_methods

    # TODO: revise when this validation should take place. It should be
    # hooked to the update of the flag: when risk is enabled, the actors needed
    # at the customer level should be created.
    #
    validate :validate_actors, if: :risk_enabled?
  end

  def iam_customer
    @iam_customer ||= Iam::ActorResponsibility.new(customer: self)
  end

  def delegate_all_methods
    delegate_methods("model_level")
    delegate_methods("module_level")
    delegate_methods("app_level")
  end

  def delegate_methods(level)
    level_config = Rails.configuration.responsibilities[level]

    level_config.each do |level_name, responsibility_config|
      responsibilities = responsibility_config["responsibilities"].keys
      responsibilities.each do |responsibility|
        full_responsibility = "#{level_name}_#{responsibility}"
        #  This branch was not visited, there are no singular responsibilities
        #  in model or module levels.
        if responsibility_config.dig("responsibilities", responsibility, "singular")
          # reader sing responsibility writer and replace sing responsibility
          self.class.delegate full_responsibility, "#{full_responsibility}=",
                              to: :iam_customer
        else
          # reader plural responsibility
          # writer, replace plural responsibilities
          # writer, add plural responsibilities
          # writer, add plural responsibility
          # writer, remove plural responsibility
          #
          self.class.delegate(
            "#{full_responsibility}s",
            "#{full_responsibility}s=",
            "add_#{full_responsibility}s",
            "add_#{full_responsibility}",
            "remove_#{full_responsibility}", to: :iam_customer
          )
        end
        # user with responsibility?
        self.class.delegate "#{full_responsibility}?", to: :iam_customer
      end
    end
  end

  def risk_enabled?
    flag ? risk_module? : false
  end

  def validate_actors
    @validator ||= Iam::ActorValidation.new(customer: self)
    @validator.validate_module
  end
end
