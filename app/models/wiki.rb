class Wiki < ActiveRecord::Base
  belongs_to :user
  
  after_initialize :init_private
  
  default_scope { order('updated_at DESC') } 
  
  private
    
  def init_private
    self.private ||= false
  end
end
