class Project < ActiveRecord::Base
  has_many :notices
  belongs_to :user
end
