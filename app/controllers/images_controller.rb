class ImagesController < ApplicationController
    def show
      Rails.logger.debug "Constructed file path: #{Rails.root.join('output', params[:filename])}"
      send_file Rails.root.join('output', params[:filename] + ".svg"), type: 'image/svg+xml', disposition: 'inline'
    end
  end