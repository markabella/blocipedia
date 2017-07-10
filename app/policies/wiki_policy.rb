 class WikiPolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    false
  end

  def show?
    scope.where(:id => record.id).exists?
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    user.present?
  end

  def edit?
    update?
  end

  def destroy?
    false
  end
  
  def scope
    Pundit.policy_scope!(user, record.class)
  end
  
   class Scope
     attr_reader :user, :scope
 
     def initialize(user, scope)
       @user = user
       @scope = scope
     end
 
     def resolve
       wikis = []
       all_wikis = scope.all
         wikis = []
         all_wikis.each do |wiki|
             wikis << wiki # only show standard users public wikis and private wikis they are a collaborator on
           end
         wikis
     end
   end
 end