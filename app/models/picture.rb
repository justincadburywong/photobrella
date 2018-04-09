class Picture < ApplicationRecord
  include PictureUploader[:file]

  belongs_to :user
  # validates :user_id, presence: true
  scope :sorted, -> { order(created_at: :desc) }

end
