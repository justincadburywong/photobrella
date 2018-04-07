class Picture < ApplicationRecord
  include PictureUploader[:file]
  scope :sorted, -> { order(created_at: :desc) }
end
