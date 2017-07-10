class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :confirmable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :wikis
  has_many :collaborators, dependent: :destroy
  
  enum role: [:standard, :premium, :admin]
  after_initialize :init_role  
  
  private
    
  def init_role
    self.role ||= :standard
  end
  
end
