# frozen_string_literal: true

module CommonAssociations
  extend ActiveSupport::Concern

  included do
    has_many :localisings, as: :localisable, dependent: :destroy
    has_many :localisations, through: :localisings, autosave: true
    accepts_nested_attributes_for :localisings, allow_destroy: true
  end
end
