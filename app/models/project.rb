class Project < ActiveRecord::Base
  has_many :notices
  belongs_to :user

  def completed?
    completed
  end
end
