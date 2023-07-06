# frozen_string_literal: true

module Api
  class TagsController < Api::ApiController
    def suggest
      text = params[:text]
      render json: Tag.suggest(text, current_customer)
    end
  end
end
