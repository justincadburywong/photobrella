# MiniMagick
require 'image_processing/mini_magick'

class PictureUploader < Shrine
  # Use MiniMagick to process image versions
  include ImageProcessing::MiniMagick

  # The determine_mime_type plugin allows you to determine and store the actual MIME type of the file analyzed from file content.
  plugin :determine_mime_type
  # The remove_attachment plugin allows you to delete attachments through checkboxes on the web form.
  plugin :remove_attachment
  # The store_dimensions plugin extracts and stores dimensions of the uploaded image using the fastimage gem, which has built-in protection agains image bombs.
  plugin :store_dimensions
  # The validation_helpers plugin provides helper methods for validating attached files.
  plugin :validation_helpers
  # The pretty_location plugin attempts to generate a nicer folder structure for uploaded files.
  plugin :pretty_location
  # Allows you to define processing performed for a specific action.
  plugin :processing
  # The versions plugin enables your uploader to deal with versions, by allowing you to return a Hash of files when processing.
  plugin :versions
  # The delete_promoted plugin deletes files that have been promoted, after the record is saved. This means that cached files handled by the attacher will automatically get deleted once they're uploaded to store. This also applies to any other uploaded file passed to Attacher#promote.
  plugin :delete_promoted
  # The delete_raw plugin will automatically delete raw files that have been uploaded. This is especially useful when doing processing, to ensure that temporary files have been deleted after upload.
  plugin :delete_raw
  # The cached_attachment_data plugin adds the ability to retain the cached file across form redisplays, which means the file doesn't have to be reuploaded in case of validation errors.
  plugin :cached_attachment_data
  # The recache makes versions available immediately.
  plugin :recache


  # Define validations
  # For a complete list of all validation helpers, see AttacherMethods. http://shrinerb.com/rdoc/classes/Shrine/Plugins/ValidationHelpers/AttacherMethods.html
  Attacher.validate do
    validate_max_size 15.megabytes, message: 'is too large (max is 15 MB)'
    validate_mime_type_inclusion ['image/jpeg', 'image/png', 'image/gif']
  end

  # Access :original and :thumbnail versions immediately.
  # Recaching will be automatically triggered in a callback.
  process(:recache) do |io|
    {
      original: io,
      thumbnail: resize_to_fill!(io.download, 600, 0)
    }
  end

  # Process additonal versions in background.
  process(:store) do |io|
    original = io[:original].download
    {
      # Original
      sm: resize_to_fit(original, 350, 0),
      md: resize_to_fit(original, 600, 0),
      lg: resize_to_fit(original, 1200, 0),

      # Squares
      sm_square: resize_to_fill(original, 350, 0),
      md_square: resize_to_fill(original, 600, 0),
      lg_square: resize_to_fill(original, 1200, 0),
    }
  end
end
