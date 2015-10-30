class Photo < ActiveRecord::Base
  belongs_to :notice

  mount_uploader :image, ImageUploader

end
