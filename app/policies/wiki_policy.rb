WikiPolicy = Struct.new(:user, :wiki) do 
  
  self::Scope = Struct.new(:user, :scope) do
    def resolve
      scope.where(:public_access => true)
    end
  end

  def show?
    edit? # same rule as edit
  end

  def edit?
    (wiki.public_access && user) || owned? || collaborator?
  end

  def destroy?
    owned?
  end

  def collaborator?
    if user
      if (Collaborator.where(user_id: user.id, wiki_id: wiki.id).blank? == true)
        false
      else
        true
      end
    else
      false
    end
  end

  def owned?
    if user
      user.id == wiki.user_id
    else
      false
    end    
  end

  def premium?
    if user
      Subscription.find_by user_id: user.id
    else
      false
    end    
  end

end