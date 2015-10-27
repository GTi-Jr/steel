class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :username, uniqueness: true       
  has_many :projects

  def is_admin?
    admin
  end

  def has_any_active_project?
    self.projects.each { |project| return true if project.uncompleted? }
    false
  end  
end
