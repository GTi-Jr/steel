class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :username, uniqueness: true
  has_many :projects

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
end
