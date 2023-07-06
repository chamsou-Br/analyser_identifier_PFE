# frozen_string_literal: true

module MediaFile
  extend ActiveSupport::Concern

  module ClassMethods
    def mediafile_options
      @mediafile_options || { delete_dir_if_empty: true }
    end

    private

    def mediafile(options = {})
      @mediafile_options = { delete_dir_if_empty: true }.merge(options)
    end
  end

  included do
    mount_uploader :file, DocumentUploader

    after_rollback :destroy_file, on: [:create]
  end

  # TODO: there is a serializer already at app/serializers/event_attachment_serializer.rb
  # Need to do a manual serialiazer as other parts (ElasticSearch) count on the default
  # as_json method, so it cannot be overwritten.
  # This method is used by imporver2
  def serialize_this
    as_json(only: %i[id file title])
  end

  #
  # Returns the `file_url` of this file minus the Rails root.
  #
  def relative_file_url
    file_url.split(Rails.root.to_s).last
  end

  def original_filename=(value)
    @original_filename = value
  end

  def original_filename
    @original_filename
  end

  def actual_extension
    file.url.split(".").last.downcase
  end

  def self.msword_extension
    %w[doc docx docm dotm dotx dot]
  end

  def self.excel_extension
    %w[xls xlsx xltm xltx xlsm csv]
  end

  def self.msppt_extension
    %w[ppt pptx pps pptx pptm potx potm ppam ppsx ppsm sldx sldm]
  end

  def self.msoutlook_extension
    %w[pst ost oft]
  end

  def self.image_extension
    %w[git jpg jpeg png tif bmp svg dib efig cgm eps fif iff ilbm lbm pcd pct
       pcx pic psd psp tga tiff wmf wpg]
  end

  def self.video_extension
    %w[mpeg mpg mpe mpeg-1 mpeg-2 m1s mpa mp2 m2a mp2v m2v m2s avi mov qt asf
       asx wmv wma wmx rm ra ram rmvb mp4 3gp ogm mkv]
  end

  def self.audio_extension
    %w[aac ac3 amr ape mka mp2 mp3 mpc oga ogg qcp ra tta w64 wav wma wv wvc]
  end

  # TODO: Rename `is_<x>?` methods to simply `<x>?`
  # rubocop:disable Naming/PredicateName
  def is_audio?
    MediaFile.audio_extension.include? actual_extension
  end

  def is_video?
    MediaFile.video_extension.include? actual_extension
  end

  def is_msword?
    MediaFile.msword_extension.include? actual_extension
  end

  def is_excel?
    MediaFile.excel_extension.include? actual_extension
  end

  def is_ppt?
    MediaFile.msppt_extension.include? actual_extension
  end

  def is_outlook?
    MediaFile.msoutlook_extension.include? actual_extension
  end

  def is_image?
    MediaFile.image_extension.include? actual_extension
  end

  def is_pdf?
    actual_extension == "pdf"
  end
  # rubocop:enable Naming/PredicateName

  def download_path
    file_url.to_s
  end

  def destroy_file
    file.remove!
  end
end
