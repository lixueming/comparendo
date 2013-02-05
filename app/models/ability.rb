class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    # company
    can :manage, Company, :user_id => user.id
    can :create, Company unless user.new_record?

    # image
    can :create, Image unless user.new_record?
    can :manage, Image, :user_id => user.id

    # article
    can :read, Article unless user.new_record?
    can :create, Article if user.author?
    can :tags, Article unless user.new_record?
    can :update, Article do |article|
      user.is_author_of?(article) && user.author?
    end
    can :destroy, Article do |article|
      user.is_author_of?(article)
    end

    # default access
    if user.admin?
      can :manage, :all
    else
      can :read, :all
    end

  end
end
