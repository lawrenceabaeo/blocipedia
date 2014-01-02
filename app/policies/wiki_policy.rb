WikiPolicy = Struct.new(:user, :wiki) do 

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

end