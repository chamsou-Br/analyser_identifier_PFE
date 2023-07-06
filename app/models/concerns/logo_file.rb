# frozen_string_literal: true

module LogoFile
  extend ActiveSupport::Concern

  included do
    mount_uploader :logo, LogoUploader
    attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  end

  def crop_logo(p_crop_x, p_crop_y, p_crop_w, p_crop_h)
    return if !p_crop_x.present? || !p_crop_y.present? || !p_crop_w.present? || !p_crop_h.present?

    self.crop_x = p_crop_x.to_i
    self.crop_y = p_crop_y.to_i
    self.crop_w = p_crop_w.to_i
    self.crop_h = p_crop_h.to_i
    logo.recreate_versions!
  end

  def original_logo_filename=(value)
    @original_logo_filename = value
  end

  def original_logo_filename
    @original_logo_filename
  end

  def logo_filename
    File.basename(logo_url)
  end
end
