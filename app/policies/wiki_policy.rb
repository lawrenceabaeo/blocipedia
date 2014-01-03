WikiPolicy = Struct.new(:user, :wiki) do 
  
  self::Scope = Struct.new(:user, :scope) do
    def resolve
      scope.where(:public_access => true)
    end
  end

  def edit?
    owned?
  end

  def destroy?
    owned?
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