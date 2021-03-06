# encoding: utf-8

class PictureUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Include the Sprockets helpers for Rails 3.1+ asset pipeline compatibility:
  include Sprockets::Helpers::RailsHelper
  include Sprockets::Helpers::IsolatedHelper

  # background processing via sidekiq
  include ::CarrierWave::Backgrounder::Delay

  # Choose what kind of storage to use for this uploader:
  #storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def cache_dir
    'uploads/tmp'
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    "/images/fallback/" + [:small, "default.png"].compact.join('_')
  end

  # Process files as they are uploaded:
  version :normal do
    process resize_to_fill: [720, 450]
  end

  version :medium, from_version: :normal do
    process resize_to_fill: [218, 145]
  end

  version :large, from_version: :normal do
    process resize_to_fill: [280, 186]
  end

  version :small, from_version: :normal do
    process resize_to_fill: [50, 50]
  end

  version :featured, from_version: :normal do
    process resize_to_fill: [768, 466]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
