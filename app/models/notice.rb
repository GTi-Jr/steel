class Notice < ActiveRecord::Base
  has_many :documents
  has_many :photos
end
