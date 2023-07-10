# rubocop:disable all
module ApplicationHelper
    
end

module BestInPlaceFormatter
  module ActionViewExtensions
    module Formatter
      # Used for best_in_place
      def render_for_html(attr)
        sanitize(attr)&.gsub(/\n/, '<br/>')&.html_safe
      end
    end
  end
end

ActionView::Base.send :include, BestInPlaceFormatter::ActionViewExtensions::Formatter