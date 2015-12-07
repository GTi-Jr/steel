class Notice < ActiveRecord::Base
  has_many :documents
  has_many :attachments
  belongs_to :project
  accepts_nested_attributes_for :attachments

end
