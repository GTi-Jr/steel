class Attachment < ActiveRecord::Base
  belongs_to :notice

  mount_uploader :image, ImageUploader

end
