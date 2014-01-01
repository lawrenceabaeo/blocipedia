class WikisController < ApplicationController
  def index
    @wikis =Wiki.all
    if (current_user)
      @user_owned_wikis = current_user_wiki(current_user)
    end
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = current_user.wikis.build(wiki_params)
    if @wiki.save
      flash[:notice] = "Wiki was saved."
      redirect_to @wiki
    else
      flash[:error] = "There was an error saving the wiki. Please try again."
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
  end

  def update
    @wiki = Wiki.find(params[:id])
    if @wiki.update_attributes(wiki_params)
      flash[:notice] = "Wiki was updated."
      redirect_to @wiki
    else
      flash[:error] = "There was an error saving the wiki. Please try again."
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])
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
    params.require(:wiki).permit(:title, :body)
  end

  def current_user_wiki(user)
    Wiki.where("wikis.user_id = ?", user.id)
  end
end
