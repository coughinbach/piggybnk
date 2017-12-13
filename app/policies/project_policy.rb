class ProjectPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def show?
    true
  end

  def create?
    true
  end

  def update?
    user_is_owner?
  end

  def destroy?
    user_is_owner?
  end

  def breakbnk?
    user_is_owner?
  end

  private

  def user_is_owner?
    record.user_projects.where(user: user)
  end
end
