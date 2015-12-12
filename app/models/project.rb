class Project < ActiveRecord::Base
  has_many :notices
  belongs_to :user

  include PgSearch

  # Padrões de pesquisa:
  # Pesquisa pelo :name e :description da notícia
  # Pesquisa pelos modelos associados
  pg_search_scope :search, against: [:name, :description],
                  associated_against: {user: [:name, :username, :contact_name, :email]}

  # Retorna true caso o projeto esteja completo
  # Retorna false caso contrário
  def completed?
    self.completed
  end

  # Retorna true caso o projeto esteja incompleto
  # Retorna false caso contrário
  def uncompleted?
    !self.completed
  end

  # Retorna true caso o projeto tenha sido cancelado
  # Retorna false caso contrário
  def canceled?
    self.canceled
  end

  # Método da gem pg_search
  def self.text_search(query)
    if query.present?
      search(query)
    end
  end
end
