class Picture < ApplicationRecord
  include PictureUploader[:file]
end
