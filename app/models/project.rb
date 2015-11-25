class Project < ActiveRecord::Base
  has_many :notices
  belongs_to :user

  include PgSearch

  pg_search_scope :search, against: [:name, :description],
                  associated_against: {user: [:name, :username, :contact_name, :email]}

  def completed?
    self.completed
  end

  def uncompleted?
    !self.completed
  end

  def canceled?
    self.canceled
  end

  def self.text_search(query)
    if query.present?
      search(query)
    else
      scoped
    end
  end
end
