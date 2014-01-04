class WikisController < ApplicationController
  def index
    @wikis =Wiki.all
    @public_wikis = policy_scope(Wiki)
    if (current_user)
      @user_owned_wikis = current_user_wiki(current_user)
    end
  end

  def show
    @wiki = Wiki.friendly.find(params[:id])
  end

  def new
    @wiki = Wiki.new
    @users = User.all
  end

  def create
    @wiki = current_user.wikis.build(wiki_params)
    collabs = params[:users][:id]
    collabs.each do |latest_collaborator|
      if (latest_collaborator != "")
        @wiki.users << User.find(latest_collaborator)
      end
    end unless collabs.nil?

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
    # @collaborators = @wiki.collaborators
    @users = User.all
    authorize @wiki
  end

  def update
    puts "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ"
    puts params.inspect
    puts "After puts params.inspect"
    puts params[:users][:id]
    puts "After params[:users][:id]"
    puts "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ"
    @wiki = Wiki.friendly.find(params[:id])
    puts "BEFORE @wiki.collaborators BEFORE @wiki.collaborators"
    puts @wiki.collaborators 
    puts "AFTER @wiki.collaborators"
    @wiki.collaborators.clear
    puts "AFTER CLEARING COLLABORATORS AFTER CLEARING COLLABORATORS AFTER CLEARING COLLABORATORS "
    puts "CURRENT COLLABORATORS:#{@wiki.collaborators}"
    puts "AFTER CURRENT COLLABORATORS"
    
    collabs = params[:users][:id]
    collabs.each do |latest_collaborator|
      puts "latest_collaborator is #{latest_collaborator}"
      if (latest_collaborator != "")
        @wiki.users << User.find(latest_collaborator)
      end
    end unless collabs.nil?
  
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

  def current_user_wiki(user)
    Wiki.where("wikis.user_id = ?", user.id)
  end
end
