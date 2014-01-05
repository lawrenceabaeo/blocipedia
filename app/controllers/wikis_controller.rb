class WikisController < ApplicationController
  def index
    @wikis =Wiki.all
    @public_wikis = policy_scope(Wiki)
    if (current_user)
      @user_owned_wikis = wikis_the_current_user_owns(current_user)
      @my_collaborations = collaborations_the_current_user_is_part_of(current_user)
    end    
  end

  def show
    @wiki = Wiki.friendly.find(params[:id])
    authorize @wiki
  end

  def new
    @wiki = Wiki.new
    @users = User.all
  end

  def create
    @wiki = current_user.wikis.build(wiki_params)
    if(params.has_key?(:users))
      @wiki.collaborators.clear
      collabs = params[:users][:id]
      collabs.each do |latest_collaborator|
        if (latest_collaborator != "")
          @wiki.users << User.find(latest_collaborator)
        end
      end unless collabs.nil?
    end

    if @wiki.save
      flash[:notice] = "Wiki was saved."
      redirect_to @wiki
    else
      flash[:error] = "There was an error saving the wiki. Please try again."
      render :new
    end
  end

  def edit
    @wiki = Wiki.friendly.find(params[:id])
    @users = User.all
    authorize @wiki
  end

  def update
    # puts "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ"
    # puts params.inspect
    # puts "After puts params.inspect"
    # puts params[:users][:id]
    # puts "After params[:users][:id]"
    # puts "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ"
    
    @wiki = Wiki.friendly.find(params[:id])
    
    if(params.has_key?(:users))
      @wiki.collaborators.clear
      # puts "AFTER CLEARING COLLABORATORS AFTER CLEARING COLLABORATORS AFTER CLEARING COLLABORATORS "
      # puts "CURRENT COLLABORATORS:#{@wiki.collaborators}"
      # puts "AFTER CURRENT COLLABORATORS"
      collabs = params[:users][:id]
      collabs.each do |latest_collaborator|
        if (latest_collaborator != "")
          @wiki.users << User.find(latest_collaborator)
        end
      end unless collabs.nil?
    end

    if @wiki.update_attributes(wiki_params)
      flash[:notice] = "Wiki was updated."
      redirect_to @wiki
    else
      flash[:error] = "There was an error saving the wiki. Please try again."
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.friendly.find(params[:id])
    
    authorize @wiki

    if @wiki.destroy
      flash[:notice] = "Wiki was successfully deleted."
    else
      flash[:error] = "Wiki could NOT be deleted. Try again."
    end
    redirect_to wikis_path
  end

  ########################################
  private 

  def wiki_params
    params.require(:wiki).permit(:title, :body, :public_access, collaborators_attributes: [:id, :user_id, :wiki_id, :_destroy])
  end

  def wikis_the_current_user_owns(user)
    Wiki.where("wikis.user_id = ?", user.id)
  end

  def collaborations_the_current_user_is_part_of(user)
    # Person.where(:confirmed => true).limit(5).pluck(:id)
    wiki_ids = Collaborator.where(:user_id => user.id).pluck(:wiki_id)

    # wiki_ids = Collaborator.where("user_id = ? ", user.id)
    Wiki.find(wiki_ids) 
  end
end
