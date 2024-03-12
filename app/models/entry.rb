class Entry < ApplicationRecord
  belongs_to :place
  has_one_attached :uploaded_image # assuming you're using Active Storage for images
end
