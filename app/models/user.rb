class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         authentication_keys: [:login]
  validates :username, uniqueness: { case_sensitive: false }
  has_many :projects

  attr_accessor :login

  include PgSearch

  # Padrões de pesquisa:
  # Pesquisa pelo :name e :username, :contact_name e :email
  pg_search_scope :search, against: [:name, :username, :contact_name, :email] 

  # Verifica se o usuário é administrador
  def is_admin?
    admin
  end

  # Verifica se o usuário possui algum projeto ativo
  # * A função pára no primeiro projeto que estiver incompleto
  # * Caso não haja projetos incompletos, retorna +false+
  def has_any_active_project?
    self.projects.each { |project| return true if project.uncompleted? || !project.canceled? }
    false
  end  

  # método da gem pg_search
  def self.text_search(query)
    if query.present?
      search(query)
    end
  end

  # Verifica se :project pertence ao usuário
  def has_project(project)
    self.projects.include?(project)
  end

  # Override da função do Devise para que seja possível fazer login
  # tanto com email quanto com usuário
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end
end
