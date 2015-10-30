class Notice < ActiveRecord::Base
  has_many :documents
  has_many :photos
  belongs_to :project
  accepts_nested_attributes_for :photos

end
