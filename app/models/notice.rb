class Notice < ActiveRecord::Base
  has_many :documents
  has_many :photos
  belongs_to :projects
end
