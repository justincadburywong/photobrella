class Picture < ApplicationRecord
  include PictureUploader[:file]
  belongs_to :user
  validates :user_id, presence: true, numericality: {only_integer: true, greater_than: 0}
  validates :file_data, presence: true, uniqueness: true
  validates :tags, presence: true, uniqueness: true
  scope :sorted, -> { order(created_at: :desc) }
end
