class Project < ActiveRecord::Base
  has_many :notices
  belongs_to :user

  def completed?
    self.completed
  end

  def uncompleted?
    !self.completed
  end

  def canceled?
    self.canceled
  end
end
